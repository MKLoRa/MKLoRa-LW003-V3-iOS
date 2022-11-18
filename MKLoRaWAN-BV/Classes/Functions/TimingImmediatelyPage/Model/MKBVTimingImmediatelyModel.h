//
//  MKBVTimingImmediatelyModel.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MKBVScanTimePointModel;
@interface MKBVTimingImmediatelyModel : NSObject

@property (nonatomic, copy)NSString *duration;

@property (nonatomic, strong)NSArray <MKBVScanTimePointModel *>*pointList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configData:(NSArray <MKBVScanTimePointModel *>*)pointList
          sucBlock:(void (^)(void))sucBlock
       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
