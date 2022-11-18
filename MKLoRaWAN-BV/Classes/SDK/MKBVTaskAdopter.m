//
//  MKBVTaskAdopter.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKBVSDKDataAdopter.h"
#import "MKBVOperationID.h"

NSString *const mk_bv_totalNumKey = @"mk_bv_totalNumKey";
NSString *const mk_bv_totalIndexKey = @"mk_bv_totalIndexKey";
NSString *const mk_bv_contentKey = @"mk_bv_contentKey";

@implementation MKBVTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_bv_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_bv_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_bv_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_bv_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_bv_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_bv_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(6, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(10, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_bv_taskOperationID operationID = mk_bv_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(6, len)];
        NSDictionary *resultDic= @{
            mk_bv_totalNumKey:totalNum,
            mk_bv_totalIndexKey:index,
            mk_bv_contentKey:(subData ? subData : [NSData data]),
        };
        if ([cmd isEqualToString:@"99"]) {
            //读取Adv Name过滤规则
            operationID = mk_bv_taskReadFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_bv_taskOperationID operationID = mk_bv_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(8, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"99"]) {
            //配置Adv Name过滤规则
            operationID = mk_bv_taskConfigFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_bv_taskOperationID operationID = mk_bv_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        
    }else if ([cmd isEqualToString:@"06"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_bv_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //读取自检故障原因
//        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":content,
        };
        operationID = mk_bv_taskReadSelftestStatusOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //读取电池消耗时间统计
        NSString *advTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *scanTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
        NSString *loraTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 8)];
        resultDic = @{
            @"advTime":advTime,
            @"scanTime":scanTime,
            @"loraTime":loraTime,
        };
        operationID = mk_bv_taskReadBatteryConsumptionTimeOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_bv_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //读取低电状态百分比
        NSString *prompt = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"prompt":prompt,
        };
        operationID = mk_bv_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //读取低电信息包开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //读取按键关机功能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadTurnOffDeviceByButtonStatusOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //读取关机信息包开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadShutDownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //读取广播事件信息包开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadBluetoothEventNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //读取设备上电后模式选择
        NSString *mode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"mode":mode,
        };
        operationID = mk_bv_taskReadRepoweredDefaultModeOperation;
    }else if ([cmd isEqualToString:@"13"]) {
        //读取断电续传功能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadContinuityTransferFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"14"]) {
        //读取温湿度采样开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadTHFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //读取温湿度采样间隔
        resultDic = @{
            @"sampleRate":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadTHSampleRateOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //读取心跳间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //读取指示灯开关
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL lowPower = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL charged = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL broadcast = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        resultDic = @{
            @"lowPower":@(lowPower),
            @"charged":@(charged),
            @"broadcast":@(broadcast),
        };
        operationID = mk_bv_taskReadIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"18"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_bv_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_bv_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //读取设备Tx Power
        NSString *txPower = [MKBVSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_bv_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //读取广播超时时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_bv_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_bv_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取LoRaWAN ClassType
        resultDic = @{
            @"classType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanClassTypeOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_bv_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_bv_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_bv_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_bv_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_bv_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_bv_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_bv_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_bv_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"4f"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取组播开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadMulticaseGroupStatusOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //读取组播地址
        resultDic = @{
            @"mcAddr":content
        };
        operationID = mk_bv_taskReadMcAddrOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //读取组播 APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_bv_taskReadMcAppSkeyOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //读取组播 nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_bv_taskReadMcNwkSkeyOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //读取设备信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_bv_taskReadDeviceInfoMessageTypeOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //读取事件信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_bv_taskReadEventMessageTypeOperation;
    }else if ([cmd isEqualToString:@"58"]) {
        //读读取beacon信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_bv_taskReadBeaconMessageTypeOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //读取心跳包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_bv_taskReadHeartbeatMessageTypeOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //读取扫描上报策略
        resultDic = @{
            @"strategy":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadScanReportStrategiesOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //读取定时扫描&立即上报扫描时长
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadTimingScanImmediatelyReportDurationOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //读取定时扫描&立即上报定时扫描时间
        NSArray *list = [MKBVSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_bv_taskReadTimingScanImmediatelyReportTimePointOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //读取定期扫描&立即上报扫描参数
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"duration":duration,
            @"interval":interval,
        };
        operationID = mk_bv_taskReadPeriodicScanImmediatelyReportParamsOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //读取扫描常开&定期上报上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadScanAlwaysOnPeriodicReportIntervalOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //读取定期扫描&立即上报扫描参数
        NSString *scanDuration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *scanInterval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        NSString *reportInterval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 4)];
        resultDic = @{
            @"scanDuration":scanDuration,
            @"scanInterval":scanInterval,
            @"reportInterval":reportInterval,
        };
        operationID = mk_bv_taskReadPeriodicScanPeriodicReportParamsOperation;
    }else if ([cmd isEqualToString:@"79"]) {
        //读取扫描常开&定时上报定时上报时间
        NSArray *list = [MKBVSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_bv_taskReadScanAlwaysOnTimingReportTimePointOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //读取定时扫描&定时上报扫描时长
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadTimingScanTimingReportDurationOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //读取定时扫描&定时上报定时扫描时间
        NSArray *list = [MKBVSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_bv_taskReadTimingScanTimingReportScanTimePointOperation;
    }else if ([cmd isEqualToString:@"7c"]) {
        //读取定时扫描&定时上报定时上报时间
        NSArray *list = [MKBVSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_bv_taskReadTimingScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //读取定期扫描&定时上报扫描参数
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"duration":duration,
            @"interval":interval,
        };
        operationID = mk_bv_taskReadPeriodicScanTimingReportParamsOperation;
    }else if ([cmd isEqualToString:@"7f"]) {
        //读取定期扫描&定时上报定时上报时间
        NSArray *list = [MKBVSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_bv_taskReadPeriodicScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //读取iBeacon上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL uuid = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL major = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL minor = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL measured = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"uuid":@(uuid),
            @"major":@(major),
            @"minor":@(minor),
            @"measured":@(measured),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBeaconContentOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //读取UID上报内容
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        
        BOOL macAddress = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL measured = [[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL namespaceID = [[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL instanceID = [[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL response = [[binary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"namespaceID":@(namespaceID),
            @"instanceID":@(instanceID),
            @"measured":@(measured),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadUIDContentOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //读取URL上报内容
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        
        BOOL macAddress = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL measured = [[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL url = [[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL response = [[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"url":@(url),
            @"measured":@(measured),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadURLContentOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //读取TLM上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL version = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL ADV_CNT = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL SEC_CNT = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"version":@(version),
            @"battery":@(battery),
            @"temperature":@(temperature),
            @"ADV_CNT":@(ADV_CNT),
            @"SEC_CNT":@(SEC_CNT),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadTLMContentOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //读取BXP-iBeacon上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL uuid = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL major = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL minor = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL measured = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL advInterval = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"uuid":@(uuid),
            @"major":@(major),
            @"minor":@(minor),
            @"measured":@(measured),
            @"txPower":@(txPower),
            @"advInterval":@(advInterval),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBXPBeaconContentOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //读取BXP-Device Info上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advInterval = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL deviceProperty = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL switchStatus = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL firmwareVersion = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL deviceName = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"battery":@(battery),
            @"deviceProperty":@(deviceProperty),
            @"switchStatus":@(switchStatus),
            @"firmwareVersion":@(firmwareVersion),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBXPDeviceInfoContentOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //读取BXP-ACC上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advInterval = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL sampleRate = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL fullScale = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL motionThreshold = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL axisData = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"battery":@(battery),
            @"sampleRate":@(sampleRate),
            @"fullScale":@(fullScale),
            @"motionThreshold":@(motionThreshold),
            @"axisData":@(axisData),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBXPACCContentOperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //读取BXP-ACC上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advInterval = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL humidity = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"battery":@(battery),
            @"temperature":@(temperature),
            @"humidity":@(humidity),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBXPTHContentOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //读取BXP-Button上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryCenter = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(4, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL firmwareType = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL statusFlag = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL triggerCount = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL deviceID = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL frameType = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL deviceName = [[binaryCenter substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL fullScale = [[binaryCenter substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL motionThreshold = [[binaryCenter substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL axisData = [[binaryCenter substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryCenter substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryCenter substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryCenter substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryCenter substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"firmwareType":@(firmwareType),
            @"statusFlag":@(statusFlag),
            @"triggerCount":@(triggerCount),
            @"deviceID":@(deviceID),
            @"frameType":@(frameType),
            @"deviceName":@(deviceName),
            @"fullScale":@(fullScale),
            @"motionThreshold":@(motionThreshold),
            @"axisData":@(axisData),
            @"temperature":@(temperature),
            @"rangingData":@(rangingData),
            @"battery":@(battery),
            @"txPower":@(txPower),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBXPButtonContentOperation;
    }else if ([cmd isEqualToString:@"89"]) {
        //读取BXP-Tag上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL sensorStatus = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL hallCount = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL motionCount = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL axisData = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        

        BOOL tagID = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL deviceName = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"sensorStatus":@(sensorStatus),
            @"hallCount":@(hallCount),
            @"motionCount":@(motionCount),
            @"axisData":@(axisData),
            @"battery":@(battery),
            @"tagID":@(tagID),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadBXPTagContentOperation;
    }else if ([cmd isEqualToString:@"8a"]) {
        //读取Other Type Content上报内容
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        
        BOOL macAddress = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL response = [[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_bv_taskReadOtherTypeContentOperation;
    }else if ([cmd isEqualToString:@"8b"]) {
        //读取Other Type 数据块上报内容
        NSArray *list = [MKBVSDKDataAdopter parseOtherBlockOptionList:content];
        
        resultDic = @{
            @"optionList":list,
        };
        operationID = mk_bv_taskReadOtherBlockOptionsOperation;
    }else if ([cmd isEqualToString:@"8c"]) {
        //读取扫描数据保留策略
        resultDic = @{
            @"strategy":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadDataRetentionStrategyOperation;
    }else if ([cmd isEqualToString:@"8d"]) {
        //读取扫描数据最大上报长度
        resultDic = @{
            @"level":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadReportDataMaxLengthOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //读取重复过滤规则
        resultDic = @{
            @"filter":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //读取蓝牙扫描phy选择
        resultDic = @{
            @"phyType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)]
        };
        operationID = mk_bv_taskReadScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //读取RSSI过滤规则
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[[MKBLEBaseSDKAdopter signedHexTurnString:content] integerValue]],
        };
        operationID = mk_bv_taskReadRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //读取广播内容过滤逻辑
        resultDic = @{
            @"relationship":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bv_taskReadFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //读取精准过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //读取反向过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //读取MAC过滤列表
        NSArray *macList = [MKBVSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"macList":(MKValidArray(macList) ? macList : @[]),
        };
        operationID = mk_bv_taskReadFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //读取精准过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //读取反向过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //读取过滤设备类型开关
        BOOL iBeacon = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL uid = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL url = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL tlm = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        BOOL bxp_beacon = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        BOOL bxp_deviceInfo = ([[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"]);
        BOOL bxp_acc = ([[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"]);
        BOOL bxp_th = ([[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"]);
        BOOL bxp_button = ([[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"]);
        BOOL bxp_tag = ([[content substringWithRange:NSMakeRange(18, 2)] isEqualToString:@"01"]);
        BOOL other = ([[content substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"iBeacon":@(iBeacon),
            @"uid":@(uid),
            @"url":@(url),
            @"tlm":@(tlm),
            @"bxp_beacon":@(bxp_beacon),
            @"bxp_deviceInfo":@(bxp_deviceInfo),
            @"bxp_acc":@(bxp_acc),
            @"bxp_th":@(bxp_th),
            @"bxp_button":@(bxp_button),
            @"bxp_tag":@(bxp_tag),
            @"other":@(other)
        };
        operationID = mk_bv_taskReadFilterTypeStatusOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //读取iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //读取iBeacon类型过滤的Major范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_bv_taskReadFilterByBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //读取iBeacon类型过滤的Minor范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_bv_taskReadFilterByBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"9e"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_bv_taskReadFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"9f"]) {
        //读取UID类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //读取UID类型过滤的Namespace ID
        resultDic = @{
            @"namespaceID":content,
        };
        operationID = mk_bv_taskReadFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //读取UID类型过滤的Instance ID
        resultDic = @{
            @"instanceID":content,
        };
        operationID = mk_bv_taskReadFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //读取URL类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"a3"]) {
        //读取URL类型过滤内容
        NSString *url = @"";
        if (content.length > 0) {
            NSData *urlData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            url = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"url":(MKValidStr(url) ? url : @""),
        };
        operationID = mk_bv_taskReadFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"a4"]) {
        //读取TLM类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"a5"]) {
        //读取TLM过滤数据类型
        NSString *version = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"version":version
        };
        operationID = mk_bv_taskReadFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"a6"]) {
        //读取BXP-iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"a7"]) {
        //读取BXP-iBeacon类型过滤的Major范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_bv_taskReadFilterByBXPBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"a8"]) {
        //读取iBeacon类型过滤的Minor范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_bv_taskReadFilterByBXPBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"a9"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_bv_taskReadFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"ad"]) {
        //读取BXP-Button过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadBXPButtonFilterStatusOperation;
    }else if ([cmd isEqualToString:@"ae"]) {
        //读取BXP-Button报警过滤开关
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL singlePresse = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL doublePresse = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL longPresse = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL abnormal = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"singlePresse":@(singlePresse),
            @"doublePresse":@(doublePresse),
            @"longPresse":@(longPresse),
            @"abnormal":@(abnormal),
        };
        operationID = mk_bv_taskReadBXPButtonAlarmFilterStatusOperation;
    }else if ([cmd isEqualToString:@"af"]) {
        //读取BXP-TagID类型开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"b0"]) {
        //读取BXP-TagID类型精准过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"b1"]) {
        //读取读取BXP-TagID类型反向过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"b2"]) {
        //读取BXP-TagID过滤规则
        NSArray *tagIDList = [MKBVSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"tagIDList":(MKValidArray(tagIDList) ? tagIDList : @[]),
        };
        operationID = mk_bv_taskReadFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"b3"]) {
        //读取Other过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bv_taskReadFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"b4"]) {
        //读取Other过滤条件的逻辑关系
        NSString *relationship = [MKBVSDKDataAdopter parseOtherRelationship:content];
        resultDic = @{
            @"relationship":relationship,
        };
        operationID = mk_bv_taskReadFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"b5"]) {
        //读取Other的过滤条件列表
        NSArray *conditionList = [MKBVSDKDataAdopter parseOtherFilterConditionList:content];
        resultDic = @{
            @"conditionList":conditionList,
        };
        operationID = mk_bv_taskReadFilterByOtherConditionsOperation;
    }
    
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_bv_taskOperationID operationID = mk_bv_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //关机
        operationID = mk_bv_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //设备重启
        operationID = mk_bv_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //恢复出厂设置
        operationID = mk_bv_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //清零电池消耗时间统计
        operationID = mk_bv_taskWorkingTimeResetOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //配置时间
        operationID = mk_bv_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //配置时区
        operationID = mk_bv_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //配置低电状态百分比
        operationID = mk_bv_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //配置低电信息包开关
        operationID = mk_bv_taskConfigLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //配置按键关机功能开关
        operationID = mk_bv_taskConfigTurnOffDeviceByButtonStatusOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //配置关机信息包开关
        operationID = mk_bv_taskConfigShutDownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //配置广播事件信息包开关
        operationID = mk_bv_taskConfigBluetoothEventNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //配置设备重新上电运行状态
        operationID = mk_bv_taskConfigRepoweredDefaultModeOperation;
    }else if ([cmd isEqualToString:@"13"]) {
        //配置断电续传
        operationID = mk_bv_taskConfigContinuityTransferFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"14"]) {
        //配置温湿度采样开关
        operationID = mk_bv_taskConfigTHFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //配置温湿度采样频率
        operationID = mk_bv_taskConfigTHSampleRateOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //配置心跳间隔
        operationID = mk_bv_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //配置指示灯开关
        operationID = mk_bv_taskConfigIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //读取多少天本地存储的数据
        operationID = mk_bv_taskReadNumberOfDaysStoredDataOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //清除存储的所有数据
        operationID = mk_bv_taskClearAllDatasOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //暂停/恢复数据传输
        operationID = mk_bv_taskPauseSendLocalDataOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //配置广播名称
        operationID = mk_bv_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //配置广播间隔
        operationID = mk_bv_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //配置Tx Power
        operationID = mk_bv_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //配置广播超时时长
        operationID = mk_bv_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //配置蓝牙连接密码
        operationID = mk_bv_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //配置蓝牙连接密码开关
        operationID = mk_bv_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //配置LoRaWAN频段
        operationID = mk_bv_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //配置LoRaWAN入网类型
        operationID = mk_bv_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //配置LoRaWAN ClassType
        operationID = mk_bv_taskConfigClassTypeOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_bv_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_bv_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_bv_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_bv_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_bv_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_bv_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //配置LoRaWAN CH
        operationID = mk_bv_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //配置LoRaWAN DR
        operationID = mk_bv_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_bv_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_bv_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_bv_taskConfigLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"4f"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_bv_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置组播开关
        operationID = mk_bv_taskConfigMulticaseGroupStatusOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //配置组播地址
        operationID = mk_bv_taskConfigMcADDROperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //配置组播APPSKEY
        operationID = mk_bv_taskConfigMcAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //配置组播NWKSKEY
        operationID = mk_bv_taskConfigMcNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_bv_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_bv_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //配置设备信息包上行参数
        operationID = mk_bv_taskConfigDeviceInfoPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //配置事件信息包上行参数
        operationID = mk_bv_taskConfigEventPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"58"]) {
        //配置beacon信息包上行参数
        operationID = mk_bv_taskConfigBeaconPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //配置心跳包上行参数
        operationID = mk_bv_taskConfigHeartbeatPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //配置扫描上报策略
        operationID = mk_bv_taskConfigScanReportStrategyOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //配置定时扫描&立即上报扫描时长
        operationID = mk_bv_taskConfigTimingScanImmediatelyReportDurationOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //配置定时扫描&立即上报定时扫描时间
        operationID = mk_bv_taskConfigTimingScanImmediatelyReportTimePointOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //配置定期扫描&立即上报定时扫描时间
        operationID = mk_bv_taskConfigPeriodicScanImmediatelyReportParamsOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //配置读取扫描常开&定期上报上报间隔
        operationID = mk_bv_taskConfigScanAlwaysOnPeriodicReportIntervalOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //配置定期扫描定期上报扫描参数
        operationID = mk_bv_taskConfigPeriodicScanPeriodicReportParamsOperation;
    }else if ([cmd isEqualToString:@"79"]) {
        //配置扫描常开&定时上报定时上报时间
        operationID = mk_bv_taskConfigScanAlwaysOnTimingReportTimePointOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //配置定时扫描&定时上报扫描时长
        operationID = mk_bv_taskConfigTimingScanTimingReportDurationOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //配置定时扫描&定时上报定时扫描时间
        operationID = mk_bv_taskConfigTimingScanTimingReportScanTimePointOperation;
    }else if ([cmd isEqualToString:@"7c"]) {
        //配置定时扫描&定时上报定时上报时间
        operationID = mk_bv_taskConfigTimingScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //配置定期扫描&定时上报扫描参数
        operationID = mk_bv_taskConfigPeriodicScanTimingReportParamsOperation;
    }else if ([cmd isEqualToString:@"7f"]) {
        //配置定期扫描&定时上报定时上报时间
        operationID = mk_bv_taskConfigPeriodicScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //配置iBeacon上报内容
        operationID = mk_bv_taskConfigBeaconContentOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //配置UID上报内容
        operationID = mk_bv_taskConfigUIDContentOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //配置URL上报内容
        operationID = mk_bv_taskConfigURLContentOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //配置TLM上报内容
        operationID = mk_bv_taskConfigTLMContentOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //配置BXP-iBeacon上报内容
        operationID = mk_bv_taskConfigBXPBeaconContentOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //配置BXP-Device Info上报内容
        operationID = mk_bv_taskConfigBXPDeviceInfoContentOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //配置BXP-ACC上报内容
        operationID = mk_bv_taskConfigBXPACCContentOperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //配置BXP-TH上报内容
        operationID = mk_bv_taskConfigBXPTHContentOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //配置BXP-Button上报内容
        operationID = mk_bv_taskConfigBXPButtonContentOperation;
    }else if ([cmd isEqualToString:@"89"]) {
        //配置BXP-Tag上报内容
        operationID = mk_bv_taskConfigBXPTagContentOperation;
    }else if ([cmd isEqualToString:@"8a"]) {
        //配置Other Type Content
        operationID = mk_bv_taskConfigOtherTypeContentOperation;
    }else if ([cmd isEqualToString:@"8b"]) {
        //配置Other Block Data
        operationID = mk_bv_taskConfigOtherBlockOptionsOperation;
    }else if ([cmd isEqualToString:@"8c"]) {
        //配置扫描数据保留策略
        operationID = mk_bv_taskConfigDataRetentionStrategyOperation;
    }else if ([cmd isEqualToString:@"8d"]) {
        //配置扫描数据最大上报长度
        operationID = mk_bv_taskConfigReportDataMaxLengthOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //配置重复数据过滤规则
        operationID = mk_bv_taskConfigDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //配置扫描PHY过滤
        operationID = mk_bv_taskConfigScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //配置扫描RSSI过滤
        operationID = mk_bv_taskConfigRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //配置扫描过滤逻辑
        operationID = mk_bv_taskConfigFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //配置精准过滤MAC开关
        operationID = mk_bv_taskConfigFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //配置反向过滤MAC开关
        operationID = mk_bv_taskConfigFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //配置MAC过滤规则
        operationID = mk_bv_taskConfigFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //配置精准过滤Adv Name开关
        operationID = mk_bv_taskConfigFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //配置反向过滤Adv Name开关
        operationID = mk_bv_taskConfigFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //配置iBeacon类型过滤开关
        operationID = mk_bv_taskConfigFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //配置iBeacon类型过滤Major范围
        operationID = mk_bv_taskConfigFilterByBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //配置iBeacon类型过滤Minor范围
        operationID = mk_bv_taskConfigFilterByBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"9e"]) {
        //配置iBeacon类型过滤UUID
        operationID = mk_bv_taskConfigFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"9f"]) {
        //配置UID类型过滤开关
        operationID = mk_bv_taskConfigFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //配置UID类型过滤Namespace ID.
        operationID = mk_bv_taskConfigFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //配置UID类型过滤Instace ID.
        operationID = mk_bv_taskConfigFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //配置URL类型过滤开关
        operationID = mk_bv_taskConfigFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"a3"]) {
        //配置URL类型过滤的内容
        operationID = mk_bv_taskConfigFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"a4"]) {
        //配置TLM类型开关
        operationID = mk_bv_taskConfigFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"a5"]) {
        //配置TLM过滤数据类型
        operationID = mk_bv_taskConfigFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"a6"]) {
        //配置BXP-iBeacon类型过滤开关
        operationID = mk_bv_taskConfigFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"a7"]) {
        //配置BXP-iBeacon类型过滤Major范围
        operationID = mk_bv_taskConfigFilterByBXPBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"a8"]) {
        //配置BXP-iBeacon类型过滤Minor范围
        operationID = mk_bv_taskConfigFilterByBXPBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"a9"]) {
        //配置BXP-iBeacon类型过滤UUID
        operationID = mk_bv_taskConfigFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"aa"]) {
        //配置过滤BXP-DeviceInfo开关
        operationID = mk_bv_taskConfigFilterByBXPDeviceInfoStatusOperation;
    }else if ([cmd isEqualToString:@"ab"]) {
        //配置过滤BXP-ACC开关
        operationID = mk_bv_taskConfigBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"ac"]) {
        //配置过滤BXP-TH开关
        operationID = mk_bv_taskConfigBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"ad"]) {
        //配置BXP-Button过滤开关
        operationID = mk_bv_taskConfigFilterByBXPButtonStatusOperation;
    }else if ([cmd isEqualToString:@"ae"]) {
        //配置BXP-Button类型过滤内容
        operationID = mk_bv_taskConfigFilterByBXPButtonAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"af"]) {
        //配置BXP-TagID类型过滤开关
        operationID = mk_bv_taskConfigFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"b0"]) {
        //配置BXP-TagID类型精准过滤Tag-ID开关
        operationID = mk_bv_taskConfigPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"b1"]) {
        //配置BXP-TagID类型反向过滤Tag-ID开关
        operationID = mk_bv_taskConfigReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"b2"]) {
        //配置BXP-TagID过滤规则
        operationID = mk_bv_taskConfigFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"b3"]) {
        //配置Other过滤关系开关
        operationID = mk_bv_taskConfigFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"b4"]) {
        //配置Other过滤条件逻辑关系
        operationID = mk_bv_taskConfigFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"b5"]) {
        //配置Other过滤条件列表
        operationID = mk_bv_taskConfigFilterByOtherConditionsOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_bv_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
