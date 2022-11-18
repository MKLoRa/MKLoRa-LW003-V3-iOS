//
//  MKBVSDKDataAdopter.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBVSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBVSDKDataAdopter : NSObject

+ (NSString *)fetchRepoweredDefaultModeString:(mk_bv_repoweredDefaultMode)mode;

+ (NSString *)fetchLowPowerPromptString:(mk_bv_lowPowerPrompt)prompt;

+ (NSString *)lorawanRegionString:(mk_bv_loraWanRegion)region;

+ (NSString *)fetchTxPower:(mk_bv_txPower)txPower;

/// 实际值转换为0dBm、4dBm等
/// @param content content
+ (NSString *)fetchTxPowerValueString:(NSString *)content;

+ (NSString *)fetchMessageTypeString:(mk_bv_messageType)messageType;

+ (NSString *)fetchDataRetentionStrategyString:(mk_bv_dataRetentionStrategy)strategy;

+ (NSString *)fetchReportDataMaxLengthString:(mk_bv_reportDataMaxLengthType)level;

+ (NSString *)fetchScanReportStrategyString:(mk_bv_scanReportStrategy)strategy;

+ (NSArray <NSDictionary *>*)parseScanTimePoint:(NSString *)content;

+ (NSString *)fetchScanTimePoint:(NSArray <mk_bv_scanTimePointProtocol>*)dataList;

+ (NSString *)fetchDuplicateDataFilter:(mk_bv_duplicateDataFilter)filter;

+ (NSString *)fetchPHYTypeString:(mk_bv_PHYMode)mode;

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content;

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList;

+ (NSString *)parseOtherRelationship:(NSString *)other;

+ (NSArray *)parseOtherFilterConditionList:(NSString *)content;

+ (NSString *)parseOtherRelationshipToCmd:(mk_bv_filterByOther)relationship;

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_bv_BLEFilterRawDataProtocol>)protocol;

+ (NSString *)fetchBeaconContentString:(id <mk_bv_beaconContentProtocol>)protocol;

+ (NSString *)fetchUIDContentString:(id <mk_bv_uidContentProtocol>)protocol;

+ (NSString *)fetchURLContentString:(id <mk_bv_urlContentProtocol>)protocol;

+ (NSString *)fetchTLMContentString:(id <mk_bv_tlmContentProtocol>)protocol;

+ (NSString *)fetchBXPBeaconContentString:(id <mk_bv_bxpBeaconContentProtocol>)protocol;

+ (NSString *)fetchBXPDeviceInfoContentString:(id <mk_bv_bxpDeviceInfoContentProtocol>)protocol;

+ (NSString *)fetchBXPACCContentString:(id <mk_bv_bxpACCContentProtocol>)protocol;

+ (NSString *)fetchBXPTHContentString:(id <mk_bv_bxpTHContentProtocol>)protocol;

+ (NSString *)fetchBXPButtonContentString:(id <mk_bv_bxpButtonContentProtocol>)protocol;

+ (NSString *)fetchBXPTagContentString:(id <mk_bv_bxpTagContentProtocol>)protocol;

+ (NSString *)fetchOtherTypeContentString:(id <mk_bv_baseContentProtocol>)protocol;

+ (BOOL)isConfirmOtherBlockProtocol:(id <mk_bv_otherTypeBlockDataProtocol>)protocol;

+ (NSArray *)parseOtherBlockOptionList:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
