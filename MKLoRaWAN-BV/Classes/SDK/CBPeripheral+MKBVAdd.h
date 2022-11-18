//
//  CBPeripheral+MKBVAdd.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKBVAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bv_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bv_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bv_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bv_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bv_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *bv_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *bv_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *bv_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *bv_storageData;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *bv_log;

- (void)bv_updateCharacterWithService:(CBService *)service;

- (void)bv_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)bv_connectSuccess;

- (void)bv_setNil;

@end

NS_ASSUME_NONNULL_END
