//
//  MKBVMessageTypeModel.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVMessageTypeModel.h"

#import "MKMacroDefines.h"

#import "MKBVInterface.h"
#import "MKBVInterface+MKBVConfig.h"

@interface MKBVMessageTypeModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBVMessageTypeModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBeaconMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Read Beacon Message Type Settings Error" block:failedBlock];
            return;
        }
        if (![self readEventMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Read Event Message Type Settings Error" block:failedBlock];
            return;
        }
        if (![self readDeviceInfoMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Read Device Info Message Type Settings Error" block:failedBlock];
            return;
        }
        if (![self readHeartbeatMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Read Device Info Message Type Settings Error" block:failedBlock];
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
        if (![self configBeaconMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Config Beacon Message Type Settings Error" block:failedBlock];
            return;
        }
        if (![self configEventMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Config Event Message Type Settings Error" block:failedBlock];
            return;
        }
        if (![self configDeviceInfoMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Config Device Info Message Type Settings Error" block:failedBlock];
            return;
        }
        if (![self configHeartbeatMessageTypeSettings]) {
            [self operationFailedBlockWithMsg:@"Config Device Info Message Type Settings Error" block:failedBlock];
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
- (BOOL)readBeaconMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_readBeaconMessageTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.beaconPayload = [returnData[@"result"][@"payloadType"] integerValue];
        self.beaconMaxRetransmission = [returnData[@"result"][@"number"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBeaconMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_configBeaconPayloadType:self.beaconPayload maxRetransmissionTimes:(self.beaconMaxRetransmission + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEventMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_readEventMessageTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.eventPayload = [returnData[@"result"][@"payloadType"] integerValue];
        self.eventMaxRetransmission = [returnData[@"result"][@"number"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEventMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_configEventPayloadType:self.eventPayload maxRetransmissionTimes:(self.eventMaxRetransmission + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDeviceInfoMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_readDeviceInfoMessageTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceInfoPayload = [returnData[@"result"][@"payloadType"] integerValue];
        self.deviceInfoMaxRetransmission = [returnData[@"result"][@"number"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDeviceInfoMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_configDeviceInfoPayloadType:self.deviceInfoPayload maxRetransmissionTimes:(self.deviceInfoMaxRetransmission + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHeartbeatMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_readHeartbeatMessageTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.heartbeatPayload = [returnData[@"result"][@"payloadType"] integerValue];
        self.heartbeatMaxRetransmission = [returnData[@"result"][@"number"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configHeartbeatMessageTypeSettings {
    __block BOOL success = NO;
    [MKBVInterface bv_configHeartbeatPayloadType:self.heartbeatPayload maxRetransmissionTimes:(self.heartbeatMaxRetransmission + 1) sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"MessageTypeParams"
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
        _readQueue = dispatch_queue_create("MessageTypeQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
