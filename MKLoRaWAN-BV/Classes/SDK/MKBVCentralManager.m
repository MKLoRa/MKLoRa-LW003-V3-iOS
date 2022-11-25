//
//  MKBVCentralManager.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVCentralManager.h"

#import "MKBLEBaseCentralManager.h"
#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseLogManager.h"

#import "MKBVPeripheral.h"
#import "MKBVOperation.h"
#import "CBPeripheral+MKBVAdd.h"

static NSString *const mk_bv_logName = @"mk_bv_bleLog";

NSString *const mk_bv_peripheralConnectStateChangedNotification = @"mk_bv_peripheralConnectStateChangedNotification";
NSString *const mk_bv_centralManagerStateChangedNotification = @"mk_bv_centralManagerStateChangedNotification";

NSString *const mk_bv_deviceDisconnectTypeNotification = @"mk_bv_deviceDisconnectTypeNotification";

static MKBVCentralManager *manager = nil;
static dispatch_once_t onceToken;

//@interface NSObject (MKBVCentralManager)
//
//@end
//
//@implementation NSObject (MKBVCentralManager)
//
//+ (void)load{
//    [MKBVCentralManager shared];
//}
//
//@end

@interface MKBVCentralManager ()

@property (nonatomic, copy)NSString *password;

@property (nonatomic, copy)void (^sucBlock)(CBPeripheral *peripheral);

@property (nonatomic, copy)void (^failedBlock)(NSError *error);

@property (nonatomic, assign)mk_bv_centralConnectStatus connectStatus;

@end

@implementation MKBVCentralManager

- (void)dealloc {
    [self logToLocal:@"MKBVCentralManager销毁"];
    NSLog(@"MKBVCentralManager销毁");
}

- (instancetype)init {
    if (self = [super init]) {
        [self logToLocal:@"MKBVCentralManager初始化"];
        [[MKBLEBaseCentralManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKBVCentralManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKBVCentralManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    [MKBLEBaseCentralManager singleDealloc];
    manager = nil;
    onceToken = 0;
}

+ (void)removeFromCentralList {
    [[MKBLEBaseCentralManager shared] removeDataManager:manager];
    manager = nil;
    onceToken = 0;
}

#pragma mark - MKBLEBaseScanProtocol
- (void)MKBLEBaseCentralManagerDiscoverPeripheral:(CBPeripheral *)peripheral
                                advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                                             RSSI:(NSNumber *)RSSI {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",advertisementData);
        NSDictionary *dataModel = [self parseModelWithRssi:RSSI advDic:advertisementData peripheral:peripheral];
        if (!MKValidDict(dataModel)) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(mk_bv_receiveDevice:)]) {
                [self.delegate mk_bv_receiveDevice:dataModel];
            }
        });
    });
}

- (void)MKBLEBaseCentralManagerStartScan {
    [self logToLocal:@"开始扫描"];
    if ([self.delegate respondsToSelector:@selector(mk_bv_startScan)]) {
        [self.delegate mk_bv_startScan];
    }
}

- (void)MKBLEBaseCentralManagerStopScan {
    [self logToLocal:@"停止扫描"];
    if ([self.delegate respondsToSelector:@selector(mk_bv_stopScan)]) {
        [self.delegate mk_bv_stopScan];
    }
}

#pragma mark - MKBLEBaseCentralManagerStateProtocol
- (void)MKBLEBaseCentralManagerStateChanged:(MKCentralManagerState)centralManagerState {
    NSLog(@"蓝牙中心改变");
    NSString *string = [NSString stringWithFormat:@"蓝牙中心改变:%@",@(centralManagerState)];
    [self logToLocal:string];
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_bv_centralManagerStateChangedNotification object:nil];
}

- (void)MKBLEBasePeripheralConnectStateChanged:(MKPeripheralConnectState)connectState {
    //连接成功的判断必须是发送密码成功之后
    if (connectState == MKPeripheralConnectStateUnknow) {
        self.connectStatus = mk_bv_centralConnectStatusUnknow;
    }else if (connectState == MKPeripheralConnectStateConnecting) {
        self.connectStatus = mk_bv_centralConnectStatusConnecting;
    }else if (connectState == MKPeripheralConnectStateConnectedFailed) {
        self.connectStatus = mk_bv_centralConnectStatusConnectedFailed;
    }else if (connectState == MKPeripheralConnectStateDisconnect) {
        self.connectStatus = mk_bv_centralConnectStatusDisconnect;
    }
    NSLog(@"当前连接状态发生改变了:%@",@(connectState));
    NSString *string = [NSString stringWithFormat:@"连接状态发生改变:%@",@(connectState)];
    [self logToLocal:string];
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_bv_peripheralConnectStateChangedNotification object:nil];
}

#pragma mark - MKBLEBaseCentralManagerProtocol
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        [self logToLocal:@"+++++++++++++++++接收数据出错"];
        NSLog(@"+++++++++++++++++接收数据出错");
        return;
    }
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
        //非日志
        NSString *string = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        [self saveToLogData:string appToDevice:NO];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        //引起设备断开连接的类型
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_bv_deviceDisconnectTypeNotification
                                                            object:nil
                                                          userInfo:@{@"type":[content substringWithRange:NSMakeRange(8, 2)]}];
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
        //设备存储的数据
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        if (!MKValidStr(content)) {
            return;
        }
        if ([self.dataDelegate respondsToSelector:@selector(mk_bv_receiveStorageData:)]) {
            [self.dataDelegate mk_bv_receiveStorageData:content];
        }
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
        //日志
        NSString *content = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        if (!MKValidStr(content)) {
            return;
        }
        [self saveToLogData:content appToDevice:NO];
        if ([self.logDelegate respondsToSelector:@selector(mk_bv_receiveLog:)]) {
            [self.logDelegate mk_bv_receiveLog:content];
        }
        return;
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"+++++++++++++++++发送数据出错");
        [self logToLocal:@"发送数据出错"];
        return;
    }
    
}

#pragma mark - public method
- (CBCentralManager *)centralManager {
    return [MKBLEBaseCentralManager shared].centralManager;
}

- (CBPeripheral *)peripheral {
    return [MKBLEBaseCentralManager shared].peripheral;
}

- (mk_bv_centralManagerStatus )centralStatus {
    return ([MKBLEBaseCentralManager shared].centralStatus == MKCentralManagerStateEnable)
    ? mk_bv_centralManagerStatusEnable
    : mk_bv_centralManagerStatusUnable;
}

- (void)startScan {
    [[MKBLEBaseCentralManager shared] scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"AA0A"]] options:nil];
}

- (void)stopScan {
    [[MKBLEBaseCentralManager shared] stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral
                 password:(NSString *)password
                 sucBlock:(void (^)(CBPeripheral * _Nonnull))sucBlock
              failedBlock:(void (^)(NSError * error))failedBlock {
    if (!peripheral) {
        [MKBLEBaseSDKAdopter operationConnectFailedBlock:failedBlock];
        return;
    }
    if (password.length != 8 || ![MKBLEBaseSDKAdopter asciiString:password]) {
        [self operationFailedBlockWithMsg:@"The password should be 8 characters." failedBlock:failedBlock];
        return;
    }
    self.password = @"";
    self.password = password;
    __weak typeof(self) weakSelf = self;
    [self connectPeripheral:peripheral successBlock:^(CBPeripheral *peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError *error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!peripheral) {
        [MKBLEBaseSDKAdopter operationConnectFailedBlock:failedBlock];
        return;
    }
    self.password = @"";
    __weak typeof(self) weakSelf = self;
    [self connectPeripheral:peripheral successBlock:^(CBPeripheral *peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError *error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)disconnect {
    [[MKBLEBaseCentralManager shared] disconnect];
}

- (void)addTaskWithTaskID:(mk_bv_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock {
    MKBVOperation <MKBLEBaseOperationProtocol>*operation = [self generateOperationWithOperationID:operationID
                                                                                   characteristic:characteristic
                                                                                      commandData:commandData
                                                                                     successBlock:successBlock
                                                                                     failureBlock:failureBlock];
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)addReadTaskWithTaskID:(mk_bv_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock {
    MKBVOperation <MKBLEBaseOperationProtocol>*operation = [self generateReadOperationWithOperationID:operationID
                                                                                       characteristic:characteristic
                                                                                         successBlock:successBlock
                                                                                         failureBlock:failureBlock];
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)addOperation:(MKBVOperation *)operation {
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (BOOL)notifyStorageData:(BOOL)notify {
    if (self.connectStatus != mk_bv_centralConnectStatusConnected || [MKBLEBaseCentralManager shared].peripheral == nil || [MKBLEBaseCentralManager shared].peripheral.bv_storageData == nil) {
        return NO;
    }
    [[MKBLEBaseCentralManager shared].peripheral setNotifyValue:notify
                                              forCharacteristic:[MKBLEBaseCentralManager shared].peripheral.bv_storageData];
    return YES;
}

- (BOOL)notifyLogData:(BOOL)notify {
    if (self.connectStatus != mk_bv_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.bv_log == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.bv_log];
    return YES;
}

#pragma mark - password method
- (void)connectPeripheral:(CBPeripheral *)peripheral
             successBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    self.sucBlock = nil;
    self.sucBlock = sucBlock;
    self.failedBlock = nil;
    self.failedBlock = failedBlock;
    MKBVPeripheral *trackerPeripheral = [[MKBVPeripheral alloc] initWithPeripheral:peripheral];
    [[MKBLEBaseCentralManager shared] connectDevice:trackerPeripheral sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        if (MKValidStr(self.password) && self.password.length == 8) {
            //需要密码登录
            [self logToLocal:@"密码登录"];
            [self sendPasswordToDevice];
            return;
        }
        //免密登录
        [self logToLocal:@"免密登录"];
        MKBLEBase_main_safe(^{
            self.connectStatus = mk_bv_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_bv_peripheralConnectStateChangedNotification object:nil];
            if (self.sucBlock) {
                self.sucBlock(peripheral);
            }
        });
    } failedBlock:failedBlock];
}

- (void)sendPasswordToDevice {
    NSString *commandData = @"ed010108";
    for (NSInteger i = 0; i < self.password.length; i ++) {
        int asciiCode = [self.password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    __weak typeof(self) weakSelf = self;
    MKBVOperation *operation = [[MKBVOperation alloc] initOperationWithID:mk_bv_connectPasswordOperation commandBlock:^{
        __strong typeof(self) sself = weakSelf;
        [sself saveToLogData:commandData appToDevice:YES];
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:[MKBLEBaseCentralManager shared].peripheral.bv_password type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error || !MKValidDict(returnData) || ![returnData[@"state"] isEqualToString:@"01"]) {
            //密码错误
            [sself operationFailedBlockWithMsg:@"Password Error" failedBlock:sself.failedBlock];
            return ;
        }
        //密码正确
        MKBLEBase_main_safe(^{
            sself.connectStatus = mk_bv_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_bv_peripheralConnectStateChangedNotification object:nil];
            if (sself.sucBlock) {
                sself.sucBlock([MKBLEBaseCentralManager shared].peripheral);
            }
        });
    }];
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

#pragma mark - task method
- (MKBVOperation <MKBLEBaseOperationProtocol>*)generateOperationWithOperationID:(mk_bv_taskOperationID)operationID
                                                                 characteristic:(CBCharacteristic *)characteristic
                                                                    commandData:(NSString *)commandData
                                                                   successBlock:(void (^)(id returnData))successBlock
                                                                   failureBlock:(void (^)(NSError *error))failureBlock{
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failureBlock];
        return nil;
    }
    if (!MKValidStr(commandData)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failureBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failureBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKBVOperation <MKBLEBaseOperationProtocol>*operation = [[MKBVOperation alloc] initOperationWithID:operationID commandBlock:^{
        __strong typeof(self) sself = weakSelf;
        [sself saveToLogData:commandData appToDevice:YES];
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:characteristic type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            MKBLEBase_main_safe(^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failureBlock];
            return ;
        }
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":returnData,
                                    };
        MKBLEBase_main_safe(^{
            if (successBlock) {
                successBlock(resultDic);
            }
        });
    }];
    return operation;
}

- (MKBVOperation <MKBLEBaseOperationProtocol>*)generateReadOperationWithOperationID:(mk_bv_taskOperationID)operationID
                                                                     characteristic:(CBCharacteristic *)characteristic
                                                                       successBlock:(void (^)(id returnData))successBlock
                                                                       failureBlock:(void (^)(NSError *error))failureBlock{
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failureBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failureBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKBVOperation <MKBLEBaseOperationProtocol>*operation = [[MKBVOperation alloc] initOperationWithID:operationID commandBlock:^{
        [[MKBLEBaseCentralManager shared].peripheral readValueForCharacteristic:characteristic];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            MKBLEBase_main_safe(^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failureBlock];
            return ;
        }
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":returnData,
                                    };
        MKBLEBase_main_safe(^{
            if (successBlock) {
                successBlock(resultDic);
            }
        });
    }];
    return operation;
}

#pragma mark - private method
- (NSDictionary *)parseModelWithRssi:(NSNumber *)rssi advDic:(NSDictionary *)advDic peripheral:(CBPeripheral *)peripheral {
    if ([rssi integerValue] == 127 || !MKValidDict(advDic) || !peripheral) {
        return @{};
    }
    NSData *manufacturerData = advDic[CBAdvertisementDataManufacturerDataKey];
    if (manufacturerData.length != 17) {
        return @{};
    }
    NSData *type = advDic[@"kCBAdvDataServiceData"][[CBUUID UUIDWithString:@"AA0A"]];
    NSString *deviceType = [MKBLEBaseSDKAdopter hexStringFromData:type];
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:manufacturerData];
    content = [content substringFromIndex:4];
    
    NSNumber *txPower = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(0, 2)]];
    NSString *battery = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
    NSString *voltage = [NSString stringWithFormat:@"%.3f",([MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)] * 0.001)];
    BOOL needPassword = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"];
    NSString *tempValue = [content substringWithRange:NSMakeRange(10, 4)];
    NSString *temperature = tempValue;
    if (![tempValue isEqualToString:@"ffff"]) {
        temperature = [NSString stringWithFormat:@"%.2f",([[MKBLEBaseSDKAdopter signedHexTurnString:tempValue] integerValue] * 0.01)];
    }
    NSString *humidityValue = [content substringWithRange:NSMakeRange(14, 4)];
    NSString *humidity = humidityValue;
    if (![humidityValue isEqualToString:@"ffff"]) {
        humidity = [NSString stringWithFormat:@"%.2f",([MKBLEBaseSDKAdopter getDecimalWithHex:humidityValue range:NSMakeRange(0, humidityValue.length)] * 0.01)];
    }
    
    NSString *tempMac = [[content substringWithRange:NSMakeRange(18, 12)] uppercaseString];
    NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",
    [tempMac substringWithRange:NSMakeRange(0, 2)],
    [tempMac substringWithRange:NSMakeRange(2, 2)],
    [tempMac substringWithRange:NSMakeRange(4, 2)],
    [tempMac substringWithRange:NSMakeRange(6, 2)],
    [tempMac substringWithRange:NSMakeRange(8, 2)],
    [tempMac substringWithRange:NSMakeRange(10, 2)]];
    
    [self logToLocal:[@"扫描到设备:" stringByAppendingString:content]];
    
    return @{
        @"rssi":rssi,
        @"peripheral":peripheral,
        @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
        @"deviceType":deviceType,
        @"txPower":txPower,
        @"battery":battery,
        @"voltage":voltage,
        @"needPassword":@(needPassword),
        @"temperature":temperature,
        @"humidity":humidity,
        @"macAddress":macAddress,
        @"connectable":advDic[CBAdvertisementDataIsConnectable],
    };
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.MPCentralManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    MKBLEBase_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

- (void)saveToLogData:(NSString *)string appToDevice:(BOOL)app {
    if (!MKValidStr(string)) {
        return;
    }
    NSString *fuction = (app ? @"App To Device" : @"Device To App");
    NSString *recordString = [NSString stringWithFormat:@"%@---->%@",fuction,string];
    [self logToLocal:recordString];
}

- (void)logToLocal:(NSString *)string {
    if (!MKValidStr(string)) {
        return;
    }
    [MKBLEBaseLogManager saveDataWithFileName:mk_bv_logName dataList:@[string]];
}

@end
