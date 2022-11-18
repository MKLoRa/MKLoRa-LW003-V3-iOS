#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKBVCentralManager

typedef NS_ENUM(NSInteger, mk_bv_centralConnectStatus) {
    mk_bv_centralConnectStatusUnknow,                                           //未知状态
    mk_bv_centralConnectStatusConnecting,                                       //正在连接
    mk_bv_centralConnectStatusConnected,                                        //连接成功
    mk_bv_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_bv_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_bv_centralManagerStatus) {
    mk_bv_centralManagerStatusUnable,                           //不可用
    mk_bv_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_bv_repoweredDefaultMode) {
    mk_bv_repoweredDefaultMode_offMode,             //Off mode
    mk_bv_repoweredDefaultMode_onMode,              //On mode
    mk_bv_repoweredDefaultMode_revertToLastMode,    //Revert To Last Mode
};

typedef NS_ENUM(NSInteger, mk_bv_lowPowerPrompt) {
    mk_bv_lowPowerPrompt_tenPercent,
    mk_bv_lowPowerPrompt_twentyPercent,
    mk_bv_lowPowerPrompt_thirtyPercent,
    mk_bv_lowPowerPrompt_fortyPercent,
    mk_bv_lowPowerPrompt_FiftyPercent,
};

typedef NS_ENUM(NSInteger, mk_bv_loraWanRegion) {
    mk_bv_loraWanRegionAS923,
    mk_bv_loraWanRegionAU915,
    mk_bv_loraWanRegionCN470,
    mk_bv_loraWanRegionCN779,
    mk_bv_loraWanRegionEU433,
    mk_bv_loraWanRegionEU868,
    mk_bv_loraWanRegionKR920,
    mk_bv_loraWanRegionIN865,
    mk_bv_loraWanRegionUS915,
    mk_bv_loraWanRegionRU864,
};

typedef NS_ENUM(NSInteger, mk_bv_loraWanModem) {
    mk_bv_loraWanModemABP,
    mk_bv_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_bv_loraWanClassType) {
    mk_bv_loraWanClassTypeA,          //Class A.
    mk_bv_loraWanClassTypeC,            //Class C.
};

typedef NS_ENUM(NSInteger, mk_bv_messageType) {
    mk_bv_messageTypeUnconfirmed,          //Unconfirmed.
    mk_bv_messageTypeConfirmed,            //Confirmed.
};

typedef NS_ENUM(NSInteger, mk_bv_dataRetentionStrategy) {
    mk_bv_dataRetentionStrategy_currentCyclePriority,          //Current Cycle Priority.
    mk_bv_dataRetentionStrategy_nextCyclePriority,            //Next Cycle Priority.
};

typedef NS_ENUM(NSInteger, mk_bv_reportDataMaxLengthType) {
    mk_bv_reportDataMaxLengthType_level1,          //Level 1(115 Bytes).
    mk_bv_reportDataMaxLengthType_level2,            //Level 2(242 Bytes).
};

typedef NS_ENUM(NSInteger, mk_bv_scanReportStrategy) {
    mk_bv_scanReportStrategy_close,                               //No Scan & No Report
    mk_bv_scanReportStrategy_timingScanImmediatelyReport,         //Timing Scan & Immediately Report
    mk_bv_scanReportStrategy_periodicScanImmediatelyReport,       //Periodic Scan & Immediately Report
    mk_bv_scanReportStrategy_scanAlwaysOnPeriodicReport,          //Scan Always On & Periodic Report
    mk_bv_scanReportStrategy_periodicScanPeriodicReport,          //Periodic Scan & Periodic Report
    mk_bv_scanReportStrategy_scanAlwaysOnTimingReport,            //Scan Always On & Timing Report
    mk_bv_scanReportStrategy_timingScanTimingReport,              //Timing Scan & Timing Report
    mk_bv_scanReportStrategy_periodicScanTimingReport,            //Periodic Scan & Timing Report
};

typedef NS_ENUM(NSInteger, mk_bv_filterByOther) {
    mk_bv_filterByOther_A,                 //Filter by A condition.
    mk_bv_filterByOther_AB,                //Filter by A & B condition.
    mk_bv_filterByOther_AOrB,              //Filter by A | B condition.
    mk_bv_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_bv_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_bv_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_bv_txPower) {
    mk_bv_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_bv_txPowerNeg20dBm,   //-20dBm
    mk_bv_txPowerNeg16dBm,   //-16dBm
    mk_bv_txPowerNeg12dBm,   //-12dBm
    mk_bv_txPowerNeg8dBm,    //-8dBm
    mk_bv_txPowerNeg4dBm,    //-4dBm
    mk_bv_txPower0dBm,       //0dBm
    mk_bv_txPower2dBm,       //2dBm
    mk_bv_txPower3dBm,       //3dBm
    mk_bv_txPower4dBm,       //4dBm
    mk_bv_txPower5dBm,       //5dBm
    mk_bv_txPower6dBm,       //6dBm
    mk_bv_txPower7dBm,       //7dBm
    mk_bv_txPower8dBm,       //8dBm
};

typedef NS_ENUM(NSInteger, mk_bv_duplicateDataFilter) {
    mk_bv_duplicateDataFilter_none,             //None
    mk_bv_duplicateDataFilter_mac,              //MAC
    mk_bv_duplicateDataFilter_macAndDataType,   //MAC+Data Type
    mk_bv_duplicateDataFilter_macAndRawData,    //MAC+Raw Data
};

typedef NS_ENUM(NSInteger, mk_bv_PHYMode) {
    mk_bv_PHYMode_BLE4,                     //1M PHY (BLE 4.x)
    mk_bv_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_bv_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.x + BLE 5)
    mk_bv_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_bv_filterRelationship) {
    mk_bv_filterRelationship_null,
    mk_bv_filterRelationship_mac,
    mk_bv_filterRelationship_advName,
    mk_bv_filterRelationship_rawData,
    mk_bv_filterRelationship_advNameAndRawData,
    mk_bv_filterRelationship_macAndadvNameAndRawData,
    mk_bv_filterRelationship_advNameOrRawData,
};

typedef NS_ENUM(NSInteger, mk_bv_filterByTLMVersion) {
    mk_bv_filterByTLMVersion_null,             //Do not filter data.
    mk_bv_filterByTLMVersion_0,                //Unencrypted TLM data.
    mk_bv_filterByTLMVersion_1,                //Encrypted TLM data.
};

@protocol mk_bv_scanTimePointProtocol <NSObject>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:10   2:20   3:30    4:40   5:50
@property (nonatomic, assign)NSInteger minuteGear;

@end

@protocol mk_bv_motionModeEventsProtocol <NSObject>

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@property (nonatomic, assign)BOOL fixOnEnd;

@end

@protocol mk_bv_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. If minIndex==0,maxIndex must be 0.The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end

#pragma mark - ***********************Content Protocol************************

@protocol mk_bv_baseContentProtocol <NSObject>

/// YES:Report.     NO:Not Reported.
@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;


@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_bv_beaconContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL uuid;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

/// Measured RSSI@1M
@property (nonatomic, assign)BOOL measured;

@end


@protocol mk_bv_uidContentProtocol <mk_bv_baseContentProtocol>

/// RSSI@0M
@property (nonatomic, assign)BOOL measured;

@property (nonatomic, assign)BOOL namespaceID;

@property (nonatomic, assign)BOOL instanceID;

@end

@protocol mk_bv_urlContentProtocol <mk_bv_baseContentProtocol>

/// RSSI@0M
@property (nonatomic, assign)BOOL measured;

@property (nonatomic, assign)BOOL url;

@end

@protocol mk_bv_tlmContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL version;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL ADV_CNT;

@property (nonatomic, assign)BOOL SEC_CNT;

@end


@protocol mk_bv_bxpBeaconContentProtocol <mk_bv_beaconContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL advInterval;

@end


@protocol mk_bv_bxpDeviceInfoContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL deviceProperty;

@property (nonatomic, assign)BOOL switchStatus;

@property (nonatomic, assign)BOOL firmwareVersion;

@property (nonatomic, assign)BOOL deviceName;

@end


@protocol mk_bv_bxpACCContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL sampleRate;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL battery;

@end



@protocol mk_bv_bxpTHContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL humidity;

@property (nonatomic, assign)BOOL battery;

@end



@protocol mk_bv_bxpButtonContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL frameType;

@property (nonatomic, assign)BOOL statusFlag;

@property (nonatomic, assign)BOOL triggerCount;

@property (nonatomic, assign)BOOL deviceID;

@property (nonatomic, assign)BOOL firmwareType;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL txPower;

@end



@protocol mk_bv_bxpTagContentProtocol <mk_bv_baseContentProtocol>

@property (nonatomic, assign)BOOL sensorStatus;

@property (nonatomic, assign)BOOL hallCount;

@property (nonatomic, assign)BOOL motionCount;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL tagID;

@property (nonatomic, assign)BOOL deviceName;

@end




@protocol mk_bv_otherTypeBlockDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.1~29.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.minIndex~29.
@property (nonatomic, assign)NSInteger maxIndex;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_bv_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-40),
 @"peripheral":peripheral,
 @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
 @"deviceType":@"00",
 @"txPower":txPower,
 @"battery":@"100",
 @"voltage":@"3.333V",
 @"needPassword":@(YES),
 @"temperature":@"10.05",
 @"humidity":@"-10.22",
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 }
 */
- (void)mk_bv_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_bv_startScan;

/// Stops scanning equipment.
- (void)mk_bv_stopScan;

@end

@protocol mk_bv_storageDataDelegate <NSObject>

- (void)mk_bv_receiveStorageData:(NSString *)content;

@end


@protocol mk_bv_centralManagerLogDelegate <NSObject>

- (void)mk_bv_receiveLog:(NSString *)deviceLog;

@end
