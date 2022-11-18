//
//  MKBVLoRaPageModel.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/3/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVLoRaPageModel.h"

#import "MKMacroDefines.h"

#import "MKBVInterface.h"

@interface MKBVLoRaPageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBVLoRaPageModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readModem]) {
            [self operationFailedBlockWithMsg:@"Read Modem Error" block:failedBlock];
            return;
        }
        if (![self readRegion]) {
            [self operationFailedBlockWithMsg:@"Read Region Error" block:failedBlock];
            return;
        }
        if (![self readClassType]) {
            [self operationFailedBlockWithMsg:@"Read Class Type Error" block:failedBlock];
            return;
        }
        if (![self readNetworkStatus]) {
            [self operationFailedBlockWithMsg:@"Read Network Status Error" block:failedBlock];
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
- (BOOL)readModem {
    __block BOOL success = NO;
    [MKBVInterface bv_readLorawanModemWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.modem = ([returnData[@"result"][@"modem"] integerValue] == 1) ? @"ABP" : @"OTAA";
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRegion {
    __block BOOL success = NO;
    [MKBVInterface bv_readLorawanRegionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSDictionary *regionDic = [self RegionDic];
        self.region = regionDic[returnData[@"result"][@"region"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readClassType {
    __block BOOL success = NO;
    [MKBVInterface bv_readLorawanClassTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger classType = [returnData[@"result"][@"classType"] integerValue];
        if (classType == 2) {
            self.classType = @"Class C";
        }else {
            self.classType = @"Class A";
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNetworkStatus {
    __block BOOL success = NO;
    [MKBVInterface bv_readLorawanNetworkStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger type = [returnData[@"result"][@"status"] integerValue];
        if (type == 0) {
            self.networkStatus = @"Connecting";
        }else {
            self.networkStatus = @"Connected";
        }
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
        NSError *error = [[NSError alloc] initWithDomain:@"loraParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}
- (NSDictionary *)RegionDic {
    return @{
        @"0":@"AS923",
        @"1":@"AU915",
        @"2":@"CN470",
        @"3":@"CN779",
        @"4":@"EU433",
        @"5":@"EU868",
        @"6":@"KR920",
        @"7":@"IN865",
        @"8":@"US915",
        @"9":@"RU864"
    };
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
        _readQueue = dispatch_queue_create("LoRaQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
