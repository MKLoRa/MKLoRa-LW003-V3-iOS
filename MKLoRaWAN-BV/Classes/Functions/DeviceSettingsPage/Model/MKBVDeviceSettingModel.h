//
//  MKBVDeviceSettingModel.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVDeviceSettingModel : NSObject

@property (nonatomic, assign)NSInteger timeZone;

@property (nonatomic, assign)BOOL lowPowerPayload;

@property (nonatomic, assign)NSInteger prompt;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
