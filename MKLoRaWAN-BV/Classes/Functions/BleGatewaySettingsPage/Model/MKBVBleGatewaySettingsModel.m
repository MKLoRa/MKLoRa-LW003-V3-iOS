//
//  MKBVBleGatewaySettingsModel.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVBleGatewaySettingsModel.h"

#import "MKMacroDefines.h"

#import "MKBVInterface.h"
#import "MKBVInterface+MKBVConfig.h"

@interface MKBVBleGatewaySettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBVBleGatewaySettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readHeartbeatInterval]) {
            [self operationFailedBlockWithMsg:@"Read Heartbeat Interval Error" block:failedBlock];
            return;
        }
        if (![self readReportDataMaxLength]) {
            [self operationFailedBlockWithMsg:@"Read Report Data Max Length Error" block:failedBlock];
            return;
        }
        if (![self readDataRetentionStrategy]) {
            [self operationFailedBlockWithMsg:@"Read Data Retention Strategy Error" block:failedBlock];
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
        if (![self configHeartbeatInterval]) {
            [self operationFailedBlockWithMsg:@"Config Heartbeat Interval Error" block:failedBlock];
            return;
        }
        if (![self configReportDataMaxLength]) {
            [self operationFailedBlockWithMsg:@"Config Report Data Max Length Error" block:failedBlock];
            return;
        }
        if (![self configDataRetentionStrategy]) {
            [self operationFailedBlockWithMsg:@"Config Data Retention Strategy Error" block:failedBlock];
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
- (BOOL)readHeartbeatInterval {
    __block BOOL success = NO;
    [MKBVInterface bv_readHeartbeatIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configHeartbeatInterval {
    __block BOOL success = NO;
    [MKBVInterface bv_configHeartbeatInterval:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportDataMaxLength {
    __block BOOL success = NO;
    [MKBVInterface bv_readReportDataMaxLengthWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dataLen = [returnData[@"result"][@"level"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReportDataMaxLength {
    __block BOOL success = NO;
    [MKBVInterface bv_configReportDataMaxLength:self.dataLen sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDataRetentionStrategy {
    __block BOOL success = NO;
    [MKBVInterface bv_readDataRetentionStrategyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.strategy = [returnData[@"result"][@"strategy"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDataRetentionStrategy {
    __block BOOL success = NO;
    [MKBVInterface bv_configDataRetentionStrategy:self.strategy sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}
#pragma mark - private method
- (BOOL)validParams {
    if (!ValidStr(self.interval) || [self.interval integerValue] < 1 || [self.interval integerValue] > 14400) {
        return NO;
    }
    return YES;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"GatewaySettings"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("GatewayQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
