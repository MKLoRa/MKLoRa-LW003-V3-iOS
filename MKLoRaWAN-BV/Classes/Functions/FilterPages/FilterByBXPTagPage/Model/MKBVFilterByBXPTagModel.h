//
//  MKBVFilterByBXPTagModel.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/8/23.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVFilterByBXPTagModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)BOOL precise;

@property (nonatomic, assign)BOOL reverse;

@property (nonatomic, strong)NSArray *tagIDList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithTagIDList:(NSArray <NSString *>*)tagIDList
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
