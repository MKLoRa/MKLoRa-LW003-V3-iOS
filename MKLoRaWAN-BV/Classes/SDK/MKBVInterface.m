//
//  MKBVInterface.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKBVCentralManager.h"
#import "MKBVOperationID.h"
#import "MKBVOperation.h"
#import "CBPeripheral+MKBVAdd.h"
#import "MKBVSDKDataAdopter.h"

#define centralManager [MKBVCentralManager shared]
#define peripheral ([MKBVCentralManager shared].peripheral)

@implementation MKBVInterface

#pragma mark *********************Device Service Information*****************

+ (void)bv_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bv_taskReadDeviceModelOperation
                           characteristic:peripheral.bv_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bv_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bv_taskReadFirmwareOperation
                           characteristic:peripheral.bv_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bv_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bv_taskReadHardwareOperation
                           characteristic:peripheral.bv_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bv_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bv_taskReadSoftwareOperation
                           characteristic:peripheral.bv_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bv_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bv_taskReadManufacturerOperation
                           characteristic:peripheral.bv_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark *************************System***********************

+ (void)bv_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBatteryVoltageOperation
                     cmdFlag:@"06"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPCBAStatusOperation
                     cmdFlag:@"07"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadSelftestStatusOperation
                     cmdFlag:@"08"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBatteryConsumptionTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBatteryConsumptionTimeOperation
                     cmdFlag:@"09"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTimeZoneOperation
                     cmdFlag:@"0c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLowPowerPromptOperation
                     cmdFlag:@"0d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"0e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTurnOffDeviceByButtonStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTurnOffDeviceByButtonStatusOperation
                     cmdFlag:@"0f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readShutDownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadShutDownPayloadStatusOperation
                     cmdFlag:@"10"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBluetoothEventNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBluetoothEventNotifyStatusOperation
                     cmdFlag:@"11"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readRepoweredDefaultModeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadRepoweredDefaultModeOperation
                     cmdFlag:@"12"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readContinuityTransferFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadContinuityTransferFunctionStatusOperation
                     cmdFlag:@"13"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTHFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTHFunctionStatusOperation
                     cmdFlag:@"14"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTHSampleRateWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTHSampleRateOperation
                     cmdFlag:@"15"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"16"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadIndicatorSettingsOperation
                     cmdFlag:@"17"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadMacAddressOperation
                     cmdFlag:@"18"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Ble Params***********************

+ (void)bv_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadDeviceNameOperation
                     cmdFlag:@"30"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadAdvIntervalOperation
                     cmdFlag:@"31"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTxPowerOperation
                     cmdFlag:@"32"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"33"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPasswordOperation
                     cmdFlag:@"34"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"35"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)bv_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"40"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanRegionOperation
                     cmdFlag:@"41"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanModemOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanClassTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanClassTypeOperation
                     cmdFlag:@"43"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"45"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanDEVADDROperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"48"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"49"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanCHOperation
                     cmdFlag:@"4a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanDROperation
                     cmdFlag:@"4b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"4c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanADRACKLimitOperation
                     cmdFlag:@"4d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanADRACKDelayOperation
                     cmdFlag:@"4e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"4f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readMulticaseGroupStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadMulticaseGroupStatusOperation
                     cmdFlag:@"50"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readMcAddrWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadMcAddrOperation
                     cmdFlag:@"51"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readMcAppSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadMcAppSkeyOperation
                     cmdFlag:@"52"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readMcNwkSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadMcNwkSkeyOperation
                     cmdFlag:@"53"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"54"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"55"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readDeviceInfoMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadDeviceInfoMessageTypeOperation
                     cmdFlag:@"56"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readEventMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadEventMessageTypeOperation
                     cmdFlag:@"57"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBeaconMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBeaconMessageTypeOperation
                     cmdFlag:@"58"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readHeartbeatMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadHeartbeatMessageTypeOperation
                     cmdFlag:@"5b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Scan Params***********************
+ (void)bv_readScanReportStrategiesWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadScanReportStrategiesOperation
                     cmdFlag:@"70"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTimingScanImmediatelyReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTimingScanImmediatelyReportDurationOperation
                     cmdFlag:@"71"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTimingScanImmediatelyReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTimingScanImmediatelyReportTimePointOperation
                     cmdFlag:@"72"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPeriodicScanImmediatelyReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPeriodicScanImmediatelyReportParamsOperation
                     cmdFlag:@"73"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readScanAlwaysOnPeriodicReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadScanAlwaysOnPeriodicReportIntervalOperation
                     cmdFlag:@"74"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPeriodicScanPeriodicReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPeriodicScanPeriodicReportParamsOperation
                     cmdFlag:@"75"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readScanAlwaysOnTimingReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadScanAlwaysOnTimingReportTimePointOperation
                     cmdFlag:@"79"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTimingScanTimingReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTimingScanTimingReportDurationOperation
                     cmdFlag:@"7a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTimingScanTimingReportScanTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTimingScanTimingReportScanTimePointOperation
                     cmdFlag:@"7b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTimingScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                     failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTimingScanTimingReportReportTimePointOperation
                     cmdFlag:@"7c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPeriodicScanTimingReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPeriodicScanTimingReportParamsOperation
                     cmdFlag:@"7d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPeriodicScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                       failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPeriodicScanTimingReportReportTimePointOperation
                     cmdFlag:@"7f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBeaconContentOperation
                     cmdFlag:@"80"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readUIDContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadUIDContentOperation
                     cmdFlag:@"81"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadURLContentOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readTLMContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadTLMContentOperation
                     cmdFlag:@"83"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPBeaconContentOperation
                     cmdFlag:@"84"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPDeviceInfoContentWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPDeviceInfoContentOperation
                     cmdFlag:@"85"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPACCContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPACCContentOperation
                     cmdFlag:@"86"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPTHContentWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPTHContentOperation
                     cmdFlag:@"87"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPButtonContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPButtonContentOperation
                     cmdFlag:@"88"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPTagContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPTagContentOperation
                     cmdFlag:@"89"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readOtherTypeContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadOtherTypeContentOperation
                     cmdFlag:@"8a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readOtherBlockOptionsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadOtherBlockOptionsOperation
                     cmdFlag:@"8b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readDataRetentionStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadDataRetentionStrategyOperation
                     cmdFlag:@"8c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readReportDataMaxLengthWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadReportDataMaxLengthOperation
                     cmdFlag:@"8d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Scan Fliter***********************

+ (void)bv_readDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadDuplicateDataFilterOperation
                     cmdFlag:@"90"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadScanningPHYTypeOperation
                     cmdFlag:@"91"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadRssiFilterValueOperation
                     cmdFlag:@"92"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterRelationshipOperation
                     cmdFlag:@"93"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByMacPreciseMatchOperation
                     cmdFlag:@"94"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByMacReverseFilterOperation
                     cmdFlag:@"95"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterMACAddressListOperation
                     cmdFlag:@"96"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByAdvNamePreciseMatchOperation
                     cmdFlag:@"97"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByAdvNameReverseFilterOperation
                     cmdFlag:@"98"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee009900";
    [centralManager addTaskWithTaskID:mk_bv_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.bv_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKBVSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
        
    } failureBlock:failedBlock];
}

+ (void)bv_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterTypeStatusOperation
                     cmdFlag:@"9a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBeaconStatusOperation
                     cmdFlag:@"9b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBeaconMajorRangeOperation
                     cmdFlag:@"9c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBeaconMinorRangeOperation
                     cmdFlag:@"9d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBeaconUUIDOperation
                     cmdFlag:@"9e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByUIDStatusOperation
                     cmdFlag:@"9f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByUIDNamespaceIDOperation
                     cmdFlag:@"a0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByUIDInstanceIDOperation
                     cmdFlag:@"a1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByURLStatusOperation
                     cmdFlag:@"a2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByURLContentOperation
                     cmdFlag:@"a3"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByTLMStatusOperation
                     cmdFlag:@"a4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByTLMVersionOperation
                     cmdFlag:@"a5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBXPBeaconStatusOperation
                     cmdFlag:@"a6"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBXPBeaconMajorRangeOperation
                     cmdFlag:@"a7"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBXPBeaconMinorRangeOperation
                     cmdFlag:@"a8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBXPBeaconUUIDOperation
                     cmdFlag:@"a9"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPButtonFilterStatusOperation
                     cmdFlag:@"ad"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadBXPButtonAlarmFilterStatusOperation
                     cmdFlag:@"ae"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByBXPTagIDStatusOperation
                     cmdFlag:@"af"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadPreciseMatchTagIDStatusOperation
                     cmdFlag:@"b0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadReverseFilterTagIDStatusOperation
                     cmdFlag:@"b1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterBXPTagIDListOperation
                     cmdFlag:@"b2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByOtherStatusOperation
                     cmdFlag:@"b3"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByOtherRelationshipOperation
                     cmdFlag:@"b4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bv_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bv_taskReadFilterByOtherConditionsOperation
                     cmdFlag:@"b5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_bv_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.bv_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
