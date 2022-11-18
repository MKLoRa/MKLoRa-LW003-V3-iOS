//
//  MKBVSelftestModel.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/5/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVSelftestModel : NSObject

@property (nonatomic, copy)NSString *thData;

@property (nonatomic, copy)NSString *flash;

@property (nonatomic, copy)NSString *pcbaStatus;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;;

@end

NS_ASSUME_NONNULL_END
