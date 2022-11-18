//
//  MKBVInterface.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVInterface : NSObject

#pragma mark ******************Device Service Information**********************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************System***********************

/// Read battery voltage.
/*
 @{
 @"voltage":@"3000",        //Unit:mV
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the PCBA Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Selftest Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Statistical results of battery consumption time.
/*
 @{
    @"advTime":@"110000",           //BLE ADV(Unit:s)
    @"scanTime":@"11111",           //BLE Scan(Unit:s)
    @"loraTime":@"55555",           //LoRa(Unit:s)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBatteryConsumptionTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the time zone of the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.
/*
    @{
    @"prompt":@"0",         //@"0":10%   @"1":20%   @"2":30%   @"3":40%    @"4":50%
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to trigger a heartbeat when the device is low on battery.
/*
    @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Turn off Device by button.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTurnOffDeviceByButtonStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Shut-Down Payload.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readShutDownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError * error))failedBlock;

/// Bluetooth Event Notify.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBluetoothEventNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Default Operating mode after the device is repowered.
/*
 @{
 @"mode":@"1"
 }
 0: Off mode
 1:On mode
 2:Revert to last mode
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readRepoweredDefaultModeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Continuity Transfer Function.(*When the device encounters network disconnection or power failure, whether continue to transfer the data that hadn't been uploaded before when it is connected to the network or powered up again.)
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readContinuityTransferFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature and humidity sampling switch status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTHFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature and humidity sampling frequency.
/*
 @{
    @"sampleRate":@"1",     //Unit:Min.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTHSampleRateWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/*
 @{
    @"interval":@"60",      //Unit:min
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Indicator Settings.
/*
 @{
    @"lowPower":@(YES),
    @"charged":@(YES),
    @"broadcast":@(NO)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the mac address of the device.
/*
 @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *************************Ble Params***********************
/// Read the broadcast name of the device.
/*
 @{
 @"deviceName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Adv Interval of the device.
/*
 @{
 @"interval":@"1",      //Unit:100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/*
 @{
 @"txPower":@"0dBm"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast timeout time in Bluetooth configuration mode.
/*
 @{
 @"timeout":@"10"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// When the connected device requires a password, read the current connection password.
/*
 @{
 @"password":@"xxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Is a password required when the device is connected.
/*
 @{
 @"need":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ************************ LoRaWAN ***********************
/// Read the current network status of LoRaWAN.
/*
    0:Connecting
    1:OTAA network access or ABP mode.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the region information of LoRaWAN.
/*
 0:AS923 
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN network access type.
/*
 1:ABP
 2:OTAA
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the class type of the LoRaWAN.
/*
 0:ClassA
 1:ClassB   Currently not supported
 2:ClassC
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanClassTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVADDR of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the NWKSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan CH.It is only used for US915,AU915,CN470.
/*
 @{
 @"CHL":0
 @"CHH":2
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan DR.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/*
 @{
 @"DR":1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Uplink Strategy  Of Lorawan.
/*
 @{
 @"isOn":@(isOn),
 @"transmissions":transmissions,
 @"DRL":DRL,            //DR For Payload Low.
 @"DRH":DRH,            //DR For Payload High.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK LIMIT Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK DELAY Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan duty cycle status.It is only used for EU868,CN779, EU433 and RU864.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group switch status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readMulticaseGroupStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group address.
/*
 @{
    @"mcAddr":@"11223344"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readMcAddrWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group APPSKEY.
/*
 @{
    @"appSkey":@"2B7E151628AED2A6ABF7158809CF4F3C"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readMcAppSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group NWKSKEY.
/*
 @{
    @"nwkSkey":@"2B7E151628AED2A6ABF7158809CF4F3C"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readMcNwkSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan devtime command synchronization interval.(Hour)
/*
 @{
    @"interval":@"55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Network Check Interval Of Lorawan.(Hour)
/*
 @{
    @"interval":@"55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Device Information Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readDeviceInfoMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Event Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readEventMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Beacon Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBeaconMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Heartbeat Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readHeartbeatMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *************************Scan Params***********************

/// Scan & Report Strategies.
/*
 @{
    @"strategy":@"0",
 }
 @"0":No Scan & No Report
 @"1":Timing Scan & Immediately Report
 @"2":Periodic Scan & Immediately Report
 @"3":Scan Always On & Periodic Report
 @"4":Periodic Scan & Periodic Report
 @"5":Scan Always On & Timing Report
 @"6":Timing Scan & Timing Report
 @"7":Periodic Scan & Timing Report
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readScanReportStrategiesWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Immediately Report(Bluetooth Scan Duration).
/*
 @{
    @"duration":@"5",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTimingScanImmediatelyReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Immediately Report(Bluetooth Scan Time Point).
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTimingScanImmediatelyReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Immediately Report(Bluetooth Scan Duration & Bluetooth Scan Interval).
/*
 @{
    @"duration":@"5",            //Unit:S
    @"interval":@"10",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPeriodicScanImmediatelyReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock;

/// Scan Always On & Periodic Report.(Report Interval)
/*
 @{
    @"interval":@"5",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readScanAlwaysOnPeriodicReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Periodic Report(Bluetooth Scan Duration & Bluetooth Scan Interval & Report Interval).
/*
 @{
    @"scanDuration":@"5",            //Unit:S
    @"scanInterval":@"10",       //Unit:S
    @"reportInterval":@"10",     //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPeriodicScanPeriodicReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock;


/// Scan Always On & Timing Report.
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readScanAlwaysOnTimingReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock;

/// Timing Scan & Timing Report.(Bluetooth scan duration.)
/*
 @{
    @"duration":@"10",          //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTimingScanTimingReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Timing Scan & Timing Report.(Bluetooth Scan Time Point.)
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTimingScanTimingReportScanTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock;

/// Timing Scan & Timing Report.(Report Time Point.)
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTimingScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                     failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Timing Report(Bluetooth Scan Duration & Bluetooth Scan Interval).
/*
 @{
    @"duration":@"5",            //Unit:S
    @"interval":@"10",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPeriodicScanTimingReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Timing Report.(Report Time Point.)
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPeriodicScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                       failedBlock:(void (^)(NSError * error))failedBlock;



/// Content reported by iBeacon data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"uuid":@(YES),
 @"major":@(NO),
 @"minor":@(NO),
 @"measured":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by EddyStone-UID data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"measured":@(YES),
 @"namespaceID":@(YES),
 @"instanceID":@(NO),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readUIDContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by EddyStone-URL data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"measured":@(YES),
 @"url":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by EddyStone-TLM data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"version":@(NO),
 @"battery":@(NO),
 @"temperature""@(YES),
 @"ADV_CNT":@(YES),
 @"SEC_CNT":(YES)
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readTLMContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-iBeacon data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"uuid":@(YES),
 @"major":@(NO),
 @"minor":@(NO),
 @"measured":@(YES),
 @"txPower":@(YES),
 @"advInterval":@(NO),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-deviceInfo data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"txPower":@(YES),
 @"rangingData":@(NO),
 @"advInterval":@(NO),
 @"battery":@(YES),
 @"deviceProperty":@(YES),
 @"switchStatus":@(NO),
 @"firmwareVersion":@(YES),
 @"deviceName":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPDeviceInfoContentWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-ACC data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"txPower":@(YES),
 @"rangingData":@(NO),
 @"advInterval":@(NO),
 @"sampleRate":@(YES),
 @"fullScale":@(YES),
 @"motionThreshold":@(NO),
 @"axisData":@(YES),
 @"battery":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPACCContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-TH data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"txPower":@(YES),
 @"rangingData":@(NO),
 @"advInterval":@(NO),
 @"temperature":@(YES),
 @"humidity":@(YES),
 @"battery":@(NO),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPTHContentWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-Button data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"frameType":@(YES),
 @"statusFlag":@(YES),
 @"triggerCount":@(YES),
 @"deviceID":@(YES),
 @"firmwareType":@(firmwareType),
 @"deviceName":@(YES),
 @"fullScale":@(YES),
 @"motionThreshold":@(YES),
 @"axisData":@(YES),
 @"temperature":@(YES),
 @"rangingData":@(YES),
 @"battery":@(YES),
 @"txPower":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPButtonContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-Tag data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"sensorStatus":@(YES),
 @"hallCount":@(YES),
 @"motionCount":@(YES),
 @"axisData":@(YES),
 @"battery":@(YES),
 @"tagID":@(YES),
 @"deviceName":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPTagContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by Other Type data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readOtherTypeContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by Other Type  Block Options data.
/*
 @{
    @"optionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readOtherBlockOptionsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;


/// Data retention strategy when the report interval isn't enough to upload all the data for the current reporting cycle.
/*
 @{
    @"strategy":@"0",           //@"0":Current Cycle Priority   @"1":Next Cycle Priority
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readDataRetentionStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Report Data Max Length.
/*
 @{
    @"level":@"0",          //@"0":Level 1(115 Bytes)   @"1":Level 2(242 Bytes)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readReportDataMaxLengthWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Scan Fliter***********************

/// Duplicate Data Filter.
/*
 @{
    @"filter":@"0",
 }
 
 @"0":None
 @"1":MAC
 @"2":MAC+Data Type
 @"3":MAC+Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Scanning Type/PHY.
/*
 @{
    @"phyType":@"0",            //0:1M PHY (BLE 4.x)      1:1M PHY (BLE 5)    2:1M PHY (BLE 4.x + BLE 5)     3:Coded PHY(BLE 5)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// The device will uplink valid ADV data with RSSI no less than xx dBm.
/*
 @{
 @"rssi":@"-127"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/*
 @{
 @"relationship":@"4"
 }
 @"0":Null
 @"1":Only MAC
 @"2":Only ADV Name
 @"3":Only Raw Data
 @"4":ADV Name & Raw Data
 @"5":MAC & ADV Name & Raw Data
 @"6":ADV Name | Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"macList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"nameList":@[
    @"moko",
 @"LW004-PB",
 @"asdf"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read switch status of filtered device types.
/*
 @{
     @"iBeacon":@(YES),
     @"uid":@(YES),
     @"url":@(YES),
     @"tlm":@(YES),
     @"bxp_beacon":@(YES),
     @"bxp_deviceInfo":@(YES),
     @"bxp_acc":@(YES),
     @"bxp_th":@(YES),
     @"bxp_button":@(YES),
     @"bxp_tag":@(YES),
     @"other":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/*
 @{
 @"namespaceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/*
 @{
 @"instanceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/*
 @{
 @"url":@"moko.com"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/*
 @{
 @"version":@"0",           //@"0":Null(Do not filter data)   @"1":Unencrypted TLM data. @"2":Encrypted TLM data.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Button Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Alarm Filter status of the BXP Button Info.
/*
 @{
     @"singlePresse":@(YES),
     @"doublePresse":@(YES),
     @"longPresse":@(YES),
     @"abnormal":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-TagID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-TagID addresses.
/*
 @{
 @"tagIDList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/*
 @{
 @"relationship":@"0",
 }
  0:A
  1:A & B
  2:A | B
  3:A & B & C
  4:(A & B) | C
  5:A | B | C
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter.
/*
 @{
    @"conditionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
                @"data":@"001122"
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
                @"data":@"0011"
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bv_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
