//
//  MKBVFilterSettingModel.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/25.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVFilterSettingModel.h"

#import "MKMacroDefines.h"

#import "MKBVInterface.h"
#import "MKBVInterface+MKBVConfig.h"

@interface MKBVFilterSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBVFilterSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readDuplicateDataFilter]) {
            [self operationFailedBlockWithMsg:@"Read Duplicate Data Filter Error" block:failedBlock];
            return;
        }
        if (![self readFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Read Filter Rssi Error" block:failedBlock];
            return;
        }
        if (![self readPHYMode]) {
            [self operationFailedBlockWithMsg:@"Read PHY Mode Error" block:failedBlock];
            return;
        }
        if (![self readFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Read Filter Relationship Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configDuplicateDataFilter]) {
            [self operationFailedBlockWithMsg:@"Config Duplicate Data Filter Error" block:failedBlock];
            return;
        }
        if (![self configFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Config Filter Rssi Error" block:failedBlock];
            return;
        }
        if (![self configPHYMode]) {
            [self operationFailedBlockWithMsg:@"Config PHY Mode Error" block:failedBlock];
            return;
        }
        if (![self configFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Config Filter Relationship Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readDuplicateDataFilter {
    __block BOOL success = NO;
    [MKBVInterface bv_readDuplicateDataFilterWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dataFilter = [returnData[@"result"][@"filter"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDuplicateDataFilter {
    __block BOOL success = NO;
    [MKBVInterface bv_configDuplicateDataFilter:self.dataFilter sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterRssi {
    __block BOOL success = NO;
    [MKBVInterface bv_readRssiFilterValueWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi = [returnData[@"result"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRssi {
    __block BOOL success = NO;
    [MKBVInterface bv_configRssiFilterValue:self.rssi sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPHYMode {
    __block BOOL success = NO;
    [MKBVInterface bv_readScanningPHYTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.phy = [returnData[@"result"][@"phyType"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPHYMode {
    __block BOOL success = NO;
    [MKBVInterface bv_configScanningPHYType:self.phy sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterRelationship {
    __block BOOL success = NO;
    [MKBVInterface bv_readFilterRelationshipWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.relationship = [returnData[@"result"][@"relationship"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRelationship {
    __block BOOL success = NO;
    [MKBVInterface bv_configFilterRelationship:self.relationship sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"BleFixParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (self.rssi < -127 || self.rssi > 0) {
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("BluetoothFilterSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
