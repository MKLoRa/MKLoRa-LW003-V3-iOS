//
//  MKBVBleSettingsModel.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/6/11.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVBleSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKBVInterface.h"
#import "MKBVInterface+MKBVConfig.h"

@interface MKBVBleSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBVBleSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAdvName]) {
            [self operationFailedBlockWithMsg:@"Read Device Name Error" block:failedBlock];
            return;
        }
        if (![self readAdvInterval]) {
            [self operationFailedBlockWithMsg:@"Read Adv Interval Error" block:failedBlock];
            return;
        }
        if (![self readBroadcastTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Broadcast Timeout Error" block:failedBlock];
            return;
        }
        if (![self readBluetoothEventNotify]) {
            [self operationFailedBlockWithMsg:@"Read Bluetooth Event Notify Error" block:failedBlock];
            return;
        }
        if (![self readNeedPassword]) {
            [self operationFailedBlockWithMsg:@"Read Need Password Error" block:failedBlock];
            return;
        }
        if (![self readTxPower]) {
            [self operationFailedBlockWithMsg:@"Read Tx Power Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configAdvName]) {
            [self operationFailedBlockWithMsg:@"Config Device Name Error" block:failedBlock];
            return;
        }
        if (![self configAdvInterval]) {
            [self operationFailedBlockWithMsg:@"Config Adv Interval Error" block:failedBlock];
            return;
        }
        if (![self configBroadcastTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Broadcast Timeout Error" block:failedBlock];
            return;
        }
        if (![self configBluetoothEventNotify]) {
            [self operationFailedBlockWithMsg:@"Config Bluetooth Event Notify Error" block:failedBlock];
            return;
        }
        if (![self configNeedPassword]) {
            [self operationFailedBlockWithMsg:@"Config Need Password Error" block:failedBlock];
            return;
        }
        if (![self configTxPower]) {
            [self operationFailedBlockWithMsg:@"Config Tx Power Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interfae
- (BOOL)readAdvName {
    __block BOOL success = NO;
    [MKBVInterface bv_readDeviceNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advName = returnData[@"result"][@"deviceName"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvName {
    __block BOOL success = NO;
    [MKBVInterface bv_configDeviceName:self.advName sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdvInterval {
    __block BOOL success = NO;
    [MKBVInterface bv_readAdvIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvInterval {
    __block BOOL success = NO;
    [MKBVInterface bv_configAdvInterval:[self.advInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBroadcastTimeout {
    __block BOOL success = NO;
    [MKBVInterface bv_readBroadcastTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBroadcastTimeout {
    __block BOOL success = NO;
    [MKBVInterface bv_configBroadcastTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBluetoothEventNotify {
    __block BOOL success = NO;
    [MKBVInterface bv_readBluetoothEventNotifyStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.eventNotify = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBluetoothEventNotify {
    __block BOOL success = NO;
    [MKBVInterface bv_configBluetoothEventNotifyStatus:self.eventNotify sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNeedPassword {
    __block BOOL success = NO;
    [MKBVInterface bv_readConnectationNeedPasswordWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.needPassword = [returnData[@"result"][@"need"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNeedPassword {
    __block BOOL success = NO;
    [MKBVInterface bv_configNeedPassword:self.needPassword sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTxPower {
    __block BOOL success = NO;
    [MKBVInterface bv_readTxPowerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.txPower = [self fetchTxPowerValueString:returnData[@"result"][@"txPower"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTxPower {
    __block BOOL success = NO;
    [MKBVInterface bv_configTxPower:self.txPower sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"BleSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (self.advName.length > 16) {
        return NO;
    }
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 1 || [self.timeout integerValue] > 60) {
        return NO;
    }
    if (!ValidStr(self.advInterval) || [self.advInterval integerValue] < 1 || [self.advInterval integerValue] > 100) {
        return NO;
    }
    return YES;
}

- (NSInteger)fetchTxPowerValueString:(NSString *)txPower {
    if ([txPower isEqualToString:@"-40dBm"]) {
        return 0;
    }
    if ([txPower isEqualToString:@"-20dBm"]) {
        return 1;
    }
    if ([txPower isEqualToString:@"-16dBm"]) {
        return 2;
    }
    if ([txPower isEqualToString:@"-12dBm"]) {
        return 3;
    }
    if ([txPower isEqualToString:@"-8dBm"]) {
        return 4;
    }
    if ([txPower isEqualToString:@"-4dBm"]) {
        return 5;
    }
    if ([txPower isEqualToString:@"0dBm"]) {
        return 6;
    }
    if ([txPower isEqualToString:@"2dBm"]) {
        return 7;
    }
    if ([txPower isEqualToString:@"3dBm"]) {
        return 8;
    }
    if ([txPower isEqualToString:@"4dBm"]) {
        return 9;
    }
    if ([txPower isEqualToString:@"5dBm"]) {
        return 10;
    }
    if ([txPower isEqualToString:@"6dBm"]) {
        return 11;
    }
    if ([txPower isEqualToString:@"7dBm"]) {
        return 12;
    }
    if ([txPower isEqualToString:@"8dBm"]) {
        return 13;
    }
    return 5;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("BleSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
