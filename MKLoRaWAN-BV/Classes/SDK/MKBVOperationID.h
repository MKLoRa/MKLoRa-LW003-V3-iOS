
typedef NS_ENUM(NSInteger, mk_bv_taskOperationID) {
    mk_bv_defaultTaskOperationID,
    
#pragma mark - Read
    mk_bv_taskReadDeviceModelOperation,        //读取产品型号
    mk_bv_taskReadFirmwareOperation,           //读取固件版本
    mk_bv_taskReadHardwareOperation,           //读取硬件类型
    mk_bv_taskReadSoftwareOperation,           //读取软件版本
    mk_bv_taskReadManufacturerOperation,       //读取厂商信息
    mk_bv_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 密码特征
    mk_bv_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 系统参数
    mk_bv_taskReadBatteryVoltageOperation,              //读取电池电压
    mk_bv_taskReadPCBAStatusOperation,              //读取产测状态
    mk_bv_taskReadSelftestStatusOperation,          //读取自检故障原因
    mk_bv_taskReadBatteryConsumptionTimeOperation,      //读取电池消耗时间统计
    mk_bv_taskReadTimeZoneOperation,            //读取时区
    mk_bv_taskReadLowPowerPromptOperation,      //读取低电状态百分比
    mk_bv_taskReadLowPowerPayloadStatusOperation,               //读取低电信息包开关
    mk_bv_taskReadTurnOffDeviceByButtonStatusOperation,         //读取按键关机功能
    mk_bv_taskReadShutDownPayloadStatusOperation,               //读取关机信息包开关
    mk_bv_taskReadBluetoothEventNotifyStatusOperation,          //读取广播事件信息包开关
    mk_bv_taskReadRepoweredDefaultModeOperation,                //读取设备重新上电运行状态
    mk_bv_taskReadContinuityTransferFunctionStatusOperation,        //定期断点续传功能开关
    mk_bv_taskReadTHFunctionStatusOperation,                    //读取温湿度采样开关
    mk_bv_taskReadTHSampleRateOperation,                        //读取温湿度采样间隔
    mk_bv_taskReadHeartbeatIntervalOperation,   //读取心跳间隔
    mk_bv_taskReadIndicatorSettingsOperation,   //读取指示灯开关
    mk_bv_taskReadMacAddressOperation,          //读取Mac地址
    
#pragma mark - 存储数据协议
    mk_bv_taskReadNumberOfDaysStoredDataOperation,      //读取多少天本地存储的数据
    mk_bv_taskClearAllDatasOperation,                   //清除存储的所有数据
    mk_bv_taskPauseSendLocalDataOperation,              //暂停/恢复数据传输
    
#pragma mark - 蓝牙参数
    mk_bv_taskReadDeviceNameOperation,          //读取广播名称
    mk_bv_taskReadAdvIntervalOperation,         //读取广播间隔
    mk_bv_taskReadTxPowerOperation,             //读取Tx Power
    mk_bv_taskReadBroadcastTimeoutOperation,    //读取广播超时时长
    mk_bv_taskReadPasswordOperation,            //读取连接密码
    mk_bv_taskReadConnectationNeedPasswordOperation,    //读取是否需要连接密码
    
#pragma mark - 设备LoRa参数读取
    mk_bv_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_bv_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_bv_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_bv_taskReadLorawanClassTypeOperation,        //读取LoRaWAN ClassType
    mk_bv_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_bv_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_bv_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_bv_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_bv_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_bv_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_bv_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_bv_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_bv_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_bv_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_bv_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    mk_bv_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_bv_taskReadMulticaseGroupStatusOperation,            //读取组播开关
    mk_bv_taskReadMcAddrOperation,                          //读取组播地址
    mk_bv_taskReadMcAppSkeyOperation,                       //读取组播APPSKEY
    mk_bv_taskReadMcNwkSkeyOperation,                        //读取组播NWKSKEY
    mk_bv_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_bv_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    mk_bv_taskReadDeviceInfoMessageTypeOperation,       //读取设备信息包上行配置
    mk_bv_taskReadEventMessageTypeOperation,            //读取事件信息包上行配置
    mk_bv_taskReadBeaconMessageTypeOperation,           //读取beacon信息包上行配置
    mk_bv_taskReadHeartbeatMessageTypeOperation,        //读取心跳包上行配置
    
#pragma mark - 扫描参数
    mk_bv_taskReadScanReportStrategiesOperation,        //读取扫描上报策略
    mk_bv_taskReadTimingScanImmediatelyReportDurationOperation,                 //读取定时扫描&立即上报扫描时长
    mk_bv_taskReadTimingScanImmediatelyReportTimePointOperation,                //读取定时扫描&立即上报定时扫描时间
    mk_bv_taskReadPeriodicScanImmediatelyReportParamsOperation,                 //读取定期扫描&立即上报扫描参数
    mk_bv_taskReadScanAlwaysOnPeriodicReportIntervalOperation,                  //读取扫描常开&定期上报上报间隔
    mk_bv_taskReadPeriodicScanPeriodicReportParamsOperation,                    //读取定期扫描定期上报扫描参数
    mk_bv_taskReadScanAlwaysOnTimingReportTimePointOperation,                   //读取扫描常开&定时上报定时上报时间
    mk_bv_taskReadTimingScanTimingReportDurationOperation,                      //读取定时扫描&定时上报扫描时长
    mk_bv_taskReadTimingScanTimingReportScanTimePointOperation,                 //读取定时扫描&定时上报定时扫描时间
    mk_bv_taskReadTimingScanTimingReportReportTimePointOperation,               //读取定时扫描&定时上报定时上报时间
    mk_bv_taskReadPeriodicScanTimingReportParamsOperation,                      //读取定期扫描&定时上报扫描参数
    mk_bv_taskReadPeriodicScanTimingReportReportTimePointOperation,             //读取定期扫描&定时上报定时上报时间
    mk_bv_taskReadBeaconContentOperation,               //读取iBeacon上报内容
    mk_bv_taskReadUIDContentOperation,                  //读取UID上报内容
    mk_bv_taskReadURLContentOperation,                  //读取URL上报内容
    mk_bv_taskReadTLMContentOperation,                  //读取TLM上报内容
    mk_bv_taskReadBXPBeaconContentOperation,            //读取BXP-iBeacon上报内容
    mk_bv_taskReadBXPDeviceInfoContentOperation,        //读取BXP-DeviceInfo上报内容
    mk_bv_taskReadBXPACCContentOperation,               //读取BXP-ACC上报内容
    mk_bv_taskReadBXPTHContentOperation,                //读取BXP-T&H上报内容
    mk_bv_taskReadBXPButtonContentOperation,            //读取BXP-Button上报内容
    mk_bv_taskReadBXPTagContentOperation,               //读取BXP-Tag上报内容
    mk_bv_taskReadOtherTypeContentOperation,            //读取Other Type Content
    mk_bv_taskReadOtherBlockOptionsOperation,           //读取Ohter Type Block Options
    mk_bv_taskReadDataRetentionStrategyOperation,       //读取扫描数据保留策略
    mk_bv_taskReadReportDataMaxLengthOperation,         //读取扫描数据最大上报长度
    
#pragma mark - 扫描过滤参数
    mk_bv_taskReadDuplicateDataFilterOperation,         //读取重复数据过滤规则
    mk_bv_taskReadScanningPHYTypeOperation,             //读取扫描PHY过滤
    mk_bv_taskReadRssiFilterValueOperation,             //读取扫描RSSI过滤
    mk_bv_taskReadFilterRelationshipOperation,          //读取扫描过滤逻辑
    mk_bv_taskReadFilterByMacPreciseMatchOperation, //读取精准过滤MAC开关
    mk_bv_taskReadFilterByMacReverseFilterOperation,    //读取反向过滤MAC开关
    mk_bv_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_bv_taskReadFilterByAdvNamePreciseMatchOperation, //读取精准过滤ADV Name开关
    mk_bv_taskReadFilterByAdvNameReverseFilterOperation,    //读取反向过滤ADV Name开关
    mk_bv_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_bv_taskReadFilterTypeStatusOperation,            //读取过滤设备类型开关
    mk_bv_taskReadFilterByBeaconStatusOperation,        //读取iBeacon类型过滤开关
    mk_bv_taskReadFilterByBeaconMajorRangeOperation,    //读取iBeacon类型Major范围
    mk_bv_taskReadFilterByBeaconMinorRangeOperation,    //读取iBeacon类型Minor范围
    mk_bv_taskReadFilterByBeaconUUIDOperation,          //读取iBeacon类型UUID
    mk_bv_taskReadFilterByUIDStatusOperation,                //读取UID类型过滤开关
    mk_bv_taskReadFilterByUIDNamespaceIDOperation,           //读取UID类型过滤的Namespace ID
    mk_bv_taskReadFilterByUIDInstanceIDOperation,            //读取UID类型过滤的Instance ID
    mk_bv_taskReadFilterByURLStatusOperation,               //读取URL类型过滤开关
    mk_bv_taskReadFilterByURLContentOperation,              //读取URL过滤的内容
    mk_bv_taskReadFilterByTLMStatusOperation,               //读取TLM过滤开关
    mk_bv_taskReadFilterByTLMVersionOperation,              //读取TLM过滤类型
    mk_bv_taskReadFilterByBXPBeaconStatusOperation,      //读取BXP-iBeacon类型过滤开关
    mk_bv_taskReadFilterByBXPBeaconMajorRangeOperation,    //读取BXP-iBeacon类型Major范围
    mk_bv_taskReadFilterByBXPBeaconMinorRangeOperation,    //读取BXP-iBeacon类型Minor范围
    mk_bv_taskReadFilterByBXPBeaconUUIDOperation,          //读取BXP-iBeacon类型UUID
    mk_bv_taskReadBXPButtonFilterStatusOperation,           //读取BXP-Button过滤条件开关
    mk_bv_taskReadBXPButtonAlarmFilterStatusOperation,      //读取BXP-Button报警过滤开关
    mk_bv_taskReadFilterByBXPTagIDStatusOperation,         //读取BXP-TagID类型开关
    mk_bv_taskReadPreciseMatchTagIDStatusOperation,        //读取BXP-TagID类型精准过滤tagID开关
    mk_bv_taskReadReverseFilterTagIDStatusOperation,    //读取读取BXP-TagID类型反向过滤tagID开关
    mk_bv_taskReadFilterBXPTagIDListOperation,             //读取BXP-TagID过滤规则
    mk_bv_taskReadFilterByOtherStatusOperation,         //读取Other过滤条件开关
    mk_bv_taskReadFilterByOtherRelationshipOperation,   //读取Other过滤条件的逻辑关系
    mk_bv_taskReadFilterByOtherConditionsOperation,     //读取Other的过滤条件列表
    
#pragma mark - 系统参数配置
    mk_bv_taskPowerOffOperation,                //设备关机
    mk_bv_taskRestartDeviceOperation,           //设备重启
    mk_bv_taskFactoryResetOperation,            //恢复出厂设置
    mk_bv_taskWorkingTimeResetOperation,        //清零电池消耗时间统计
    mk_bv_taskConfigDeviceTimeOperation,        //配置时间
    mk_bv_taskConfigTimeZoneOperation,          //配置时区
    mk_bv_taskConfigLowPowerPromptOperation,    //配置低电状态百分比
    mk_bv_taskConfigLowPowerPayloadStatusOperation,                 //配置低电信息包开关
    mk_bv_taskConfigTurnOffDeviceByButtonStatusOperation,           //配置按键关机功能开关
    mk_bv_taskConfigShutDownPayloadStatusOperation,                 //配置关机信息包开关
    mk_bv_taskConfigBluetoothEventNotifyStatusOperation,            //配置广播事件信息包开关
    mk_bv_taskConfigRepoweredDefaultModeOperation,                  //配置设备重新上电运行状态
    mk_bv_taskConfigContinuityTransferFunctionStatusOperation,      //配置断电续传功能
    mk_bv_taskConfigTHFunctionStatusOperation,              //读取温湿度采样开关
    mk_bv_taskConfigTHSampleRateOperation,                  //读取温湿度采样频率
    mk_bv_taskConfigHeartbeatIntervalOperation, //配置心跳间隔
    mk_bv_taskConfigIndicatorSettingsOperation,             //配置指示灯开关
    
#pragma mark - 蓝牙参数
    mk_bv_taskConfigDeviceNameOperation,                //读取广播名称
    mk_bv_taskConfigAdvIntervalOperation,               //读取广播间隔
    mk_bv_taskConfigTxPowerOperation,                   //读取Tx Power
    mk_bv_taskConfigBroadcastTimeoutOperation,          //读取广播超时时长
    mk_bv_taskConfigPasswordOperation,                  //读取蓝牙连接密码
    mk_bv_taskConfigNeedPasswordOperation,              //读取蓝牙密码开关
    
#pragma mark - 设备LoRa参数配置
    mk_bv_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_bv_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_bv_taskConfigClassTypeOperation,                 //配置LoRaWAN ClassType
    mk_bv_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_bv_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_bv_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_bv_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_bv_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_bv_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_bv_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_bv_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_bv_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_bv_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_bv_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
    mk_bv_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_bv_taskConfigMulticaseGroupStatusOperation,      //配置组播开关
    mk_bv_taskConfigMcADDROperation,                    //配置组播地址
    mk_bv_taskConfigMcAPPSKEYOperation,                 //配置组播APPSKEY
    mk_bv_taskConfigMcNWKSKEYOperation,                 //配置组播NWKSKEY
    mk_bv_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_bv_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    mk_bv_taskConfigDeviceInfoPayloadTypeOperation,     //配置设备信息包上行参数
    mk_bv_taskConfigEventPayloadTypeOperation,          //配置事件信息包上行参数
    mk_bv_taskConfigBeaconPayloadTypeOperation,         //配置beacon信息包上行参数
    mk_bv_taskConfigHeartbeatPayloadTypeOperation,      //配置心跳包上行参数
    
#pragma mark - 扫描参数
    mk_bv_taskConfigScanReportStrategyOperation,        //配置扫描上报策略
    mk_bv_taskConfigTimingScanImmediatelyReportDurationOperation,           //配置定时扫描&立即上报扫描时长
    mk_bv_taskConfigTimingScanImmediatelyReportTimePointOperation,          //配置定时扫描&立即上报定时扫描时间
    mk_bv_taskConfigPeriodicScanImmediatelyReportParamsOperation,           //配置定期扫描&立即上报参数
    mk_bv_taskConfigScanAlwaysOnPeriodicReportIntervalOperation,           //配置扫描常开&定期上报上报间隔
    mk_bv_taskConfigPeriodicScanPeriodicReportParamsOperation,              //配置定期扫描定期上报扫描参数
    mk_bv_taskConfigScanAlwaysOnTimingReportTimePointOperation,             //配置扫描常开&定时上报定时上报时间
    mk_bv_taskConfigTimingScanTimingReportDurationOperation,                //配置定时扫描&定时上报扫描时长
    mk_bv_taskConfigTimingScanTimingReportScanTimePointOperation,           //配置定时扫描&定时上报定时扫描时间
    mk_bv_taskConfigTimingScanTimingReportReportTimePointOperation,         //配置定时扫描&定时上报定时上报时间
    mk_bv_taskConfigPeriodicScanTimingReportParamsOperation,                //配置定期扫描&定时上报扫描参数
    mk_bv_taskConfigPeriodicScanTimingReportReportTimePointOperation,       //配置定期扫描&定时上报定时上报时间
    mk_bv_taskConfigBeaconContentOperation,             //配置iBeacon上报内容
    mk_bv_taskConfigUIDContentOperation,                //配置UID上报内容
    mk_bv_taskConfigURLContentOperation,                //配置URL上报内容
    mk_bv_taskConfigTLMContentOperation,                //配置TLM上报内容
    mk_bv_taskConfigBXPBeaconContentOperation,          //配置BXP-iBeacon
    mk_bv_taskConfigBXPDeviceInfoContentOperation,      //配置BXP-Device Info
    mk_bv_taskConfigBXPACCContentOperation,             //配置BXP-ACC
    mk_bv_taskConfigBXPTHContentOperation,              //配置BXP-TH
    mk_bv_taskConfigBXPButtonContentOperation,          //配置BXP-Button
    mk_bv_taskConfigBXPTagContentOperation,             //配置BXP-Tag
    mk_bv_taskConfigOtherTypeContentOperation,          //配置Other Type Content
    mk_bv_taskConfigOtherBlockOptionsOperation,         //配置Other Block Data
    mk_bv_taskConfigDataRetentionStrategyOperation,     //配置扫描数据保留策略
    mk_bv_taskConfigReportDataMaxLengthOperation,       //配置扫描数据最大上报长度
    
#pragma mark - 扫描过滤参数
    mk_bv_taskConfigDuplicateDataFilterOperation,               //配置重复数据过滤规则
    mk_bv_taskConfigScanningPHYTypeOperation,                   //配置扫描PHY过滤
    mk_bv_taskConfigRssiFilterValueOperation,                   //配置扫描RSSI过滤
    mk_bv_taskConfigFilterRelationshipOperation,                //配置扫描过滤逻辑
    mk_bv_taskConfigFilterByMacPreciseMatchOperation,   //配置精准过滤MAC开关
    mk_bv_taskConfigFilterByMacReverseFilterOperation,  //配置反向过滤MAC开关
    mk_bv_taskConfigFilterMACAddressListOperation,      //配置MAC过滤规则
    mk_bv_taskConfigFilterByAdvNamePreciseMatchOperation,   //配置精准过滤Adv Name开关
    mk_bv_taskConfigFilterByAdvNameReverseFilterOperation,  //配置反向过滤Adv Name开关
    mk_bv_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_bv_taskConfigFilterByBeaconStatusOperation,          //配置iBeacon类型过滤开关
    mk_bv_taskConfigFilterByBeaconMajorOperation,           //配置iBeacon类型过滤的Major范围
    mk_bv_taskConfigFilterByBeaconMinorOperation,           //配置iBeacon类型过滤的Minor范围
    mk_bv_taskConfigFilterByBeaconUUIDOperation,            //配置iBeacon类型过滤的UUID
    mk_bv_taskConfigFilterByUIDStatusOperation,                 //配置UID类型过滤的开关状态
    mk_bv_taskConfigFilterByUIDNamespaceIDOperation,            //配置UID类型过滤的Namespace ID
    mk_bv_taskConfigFilterByUIDInstanceIDOperation,             //配置UID类型过滤的Instance ID
    mk_bv_taskConfigFilterByURLStatusOperation,                 //配置URL类型过滤的开关状态
    mk_bv_taskConfigFilterByURLContentOperation,                //配置URL类型过滤的内容
    mk_bv_taskConfigFilterByTLMStatusOperation,                 //配置TLM过滤开关
    mk_bv_taskConfigFilterByTLMVersionOperation,                //配置TLM过滤数据类型
    mk_bv_taskConfigFilterByBXPBeaconStatusOperation,          //配置BXP-iBeacon类型过滤开关
    mk_bv_taskConfigFilterByBXPBeaconMajorOperation,           //配置BXP-iBeacon类型过滤的Major范围
    mk_bv_taskConfigFilterByBXPBeaconMinorOperation,           //配置BXP-iBeacon类型过滤的Minor范围
    mk_bv_taskConfigFilterByBXPBeaconUUIDOperation,            //配置BXP-iBeacon类型过滤的UUID
    mk_bv_taskConfigFilterByBXPDeviceInfoStatusOperation,   //配置过滤BXP-DeviceInfo开关
    mk_bv_taskConfigBXPAccFilterStatusOperation,            //配置过滤BXP-ACC开关
    mk_bv_taskConfigBXPTHFilterStatusOperation,             //配置过滤BXP-TH开关
    mk_bv_taskConfigFilterByBXPButtonStatusOperation,           //配置BXP-Button过滤开关
    mk_bv_taskConfigFilterByBXPButtonAlarmStatusOperation,      //配置BXP-Button类型过滤内容
    mk_bv_taskConfigFilterByBXPTagIDStatusOperation,            //配置BXP-TagID类型过滤开关
    mk_bv_taskConfigPreciseMatchTagIDStatusOperation,           //配置BXP-TagID类型精准过滤Tag-ID开关
    mk_bv_taskConfigReverseFilterTagIDStatusOperation,          //配置BXP-TagID类型反向过滤Tag-ID开关
    mk_bv_taskConfigFilterBXPTagIDListOperation,                //配置BXP-TagID过滤规则
    mk_bv_taskConfigFilterByOtherStatusOperation,           //配置Other过滤关系开关
    mk_bv_taskConfigFilterByOtherRelationshipOperation,     //配置Other过滤条件逻辑关系
    mk_bv_taskConfigFilterByOtherConditionsOperation,       //配置Other过滤条件列表

};
