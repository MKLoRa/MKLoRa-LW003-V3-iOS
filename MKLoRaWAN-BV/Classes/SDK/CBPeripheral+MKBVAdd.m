//
//  CBPeripheral+MKBVAdd.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKBVAdd.h"

#import <objc/runtime.h>

static const char *bv_manufacturerKey = "bv_manufacturerKey";
static const char *bv_deviceModelKey = "bv_deviceModelKey";
static const char *bv_hardwareKey = "bv_hardwareKey";
static const char *bv_softwareKey = "bv_softwareKey";
static const char *bv_firmwareKey = "bv_firmwareKey";

static const char *bv_passwordKey = "bv_passwordKey";
static const char *bv_disconnectTypeKey = "bv_disconnectTypeKey";
static const char *bv_customKey = "bv_customKey";
static const char *bv_storageDataKey = "bv_storageDataKey";
static const char *bv_logKey = "bv_logKey";

static const char *bv_passwordNotifySuccessKey = "bv_passwordNotifySuccessKey";
static const char *bv_disconnectTypeNotifySuccessKey = "bv_disconnectTypeNotifySuccessKey";
static const char *bv_customNotifySuccessKey = "bv_customNotifySuccessKey";

@implementation CBPeripheral (MKBVAdd)

- (void)bv_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &bv_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &bv_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &bv_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &bv_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &bv_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &bv_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &bv_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &bv_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &bv_storageDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &bv_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)bv_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &bv_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &bv_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &bv_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)bv_connectSuccess {
    if (![objc_getAssociatedObject(self, &bv_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bv_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bv_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.bv_manufacturer || !self.bv_deviceModel || !self.bv_hardware || !self.bv_software || !self.bv_firmware) {
        return NO;
    }
    if (!self.bv_password || !self.bv_disconnectType || !self.bv_custom || !self.bv_log || !self.bv_storageData) {
        return NO;
    }
    return YES;
}

- (void)bv_setNil {
    objc_setAssociatedObject(self, &bv_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bv_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_storageDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bv_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bv_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)bv_manufacturer {
    return objc_getAssociatedObject(self, &bv_manufacturerKey);
}

- (CBCharacteristic *)bv_deviceModel {
    return objc_getAssociatedObject(self, &bv_deviceModelKey);
}

- (CBCharacteristic *)bv_hardware {
    return objc_getAssociatedObject(self, &bv_hardwareKey);
}

- (CBCharacteristic *)bv_software {
    return objc_getAssociatedObject(self, &bv_softwareKey);
}

- (CBCharacteristic *)bv_firmware {
    return objc_getAssociatedObject(self, &bv_firmwareKey);
}

- (CBCharacteristic *)bv_password {
    return objc_getAssociatedObject(self, &bv_passwordKey);
}

- (CBCharacteristic *)bv_disconnectType {
    return objc_getAssociatedObject(self, &bv_disconnectTypeKey);
}

- (CBCharacteristic *)bv_custom {
    return objc_getAssociatedObject(self, &bv_customKey);
}

- (CBCharacteristic *)bv_storageData {
    return objc_getAssociatedObject(self, &bv_storageDataKey);
}

- (CBCharacteristic *)bv_log {
    return objc_getAssociatedObject(self, &bv_logKey);
}

@end
