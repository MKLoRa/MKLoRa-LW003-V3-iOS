//
//  MKBVOnOffSettingsModel.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/11/4.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVOnOffSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKBVInterface.h"
#import "MKBVInterface+MKBVConfig.h"

@interface MKBVOnOffSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBVOnOffSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readOFFByButton]) {
            [self operationFailedBlockWithMsg:@"Read OFF By Button Error" block:failedBlock];
            return;
        }
        if (![self readShutDownPayload]) {
            [self operationFailedBlockWithMsg:@"Read Shut-Down Payload Error" block:failedBlock];
            return;
        }
        if (![self readDefaultMode]) {
            [self operationFailedBlockWithMsg:@"Read Default Mode Error" block:failedBlock];
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
        if (![self configOffByButton]) {
            [self operationFailedBlockWithMsg:@"Config OFF By Button Error" block:failedBlock];
            return;
        }
        if (![self configShutDownPayload]) {
            [self operationFailedBlockWithMsg:@"Config Shut-Down Payload Error" block:failedBlock];
            return;
        }
        if (![self configDefaultMode]) {
            [self operationFailedBlockWithMsg:@"Config Default Mode Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interfae
- (BOOL)readOFFByButton {
    __block BOOL success = NO;
    [MKBVInterface bv_readTurnOffDeviceByButtonStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.offByButton = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configOffByButton {
    __block BOOL success = NO;
    [MKBVInterface bv_configTurnOffDeviceByButtonStatus:self.offByButton sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readShutDownPayload {
    __block BOOL success = NO;
    [MKBVInterface bv_readShutDownPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.shutDown = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configShutDownPayload {
    __block BOOL success = NO;
    [MKBVInterface bv_configShutDownPayloadStatus:self.shutDown sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDefaultMode {
    __block BOOL success = NO;
    [MKBVInterface bv_readRepoweredDefaultModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.defaultMode = [returnData[@"result"][@"mode"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDefaultMode {
    __block BOOL success = NO;
    [MKBVInterface bv_configRepoweredDefaultMode:self.defaultMode sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"BleSettingsParams"
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
        _readQueue = dispatch_queue_create("BleSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
