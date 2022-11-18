//
//  MKBVBleGatewaySettingsModel.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVBleGatewaySettingsModel : NSObject

/// Heartbeat Interval:1 - 14400 Mins.
@property (nonatomic, copy)NSString *interval;

/// Report Data Max Length 0:Level 1 1:Level 2
@property (nonatomic, assign)NSInteger dataLen;

/// Data Retention Strategy. 0:Current Cycle Priority  1:Next Cycle Priority 
@property (nonatomic, assign)NSInteger strategy;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
