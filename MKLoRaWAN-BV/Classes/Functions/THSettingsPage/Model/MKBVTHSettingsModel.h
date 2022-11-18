//
//  MKBVTHSettingsModel.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/11/4.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVTHSettingsModel : NSObject

@property (nonatomic, assign)BOOL functionSwitch;

@property (nonatomic, copy)NSString *sampleRate;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
