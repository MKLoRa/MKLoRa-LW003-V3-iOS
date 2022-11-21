//
//  Target_LoRaWANBV_Module.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANBV_Module.h"

#import "MKBVScanController.h"
//
#import "MKBVAboutController.h"

@implementation Target_LoRaWANBV_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANBV_Module_ScanController:(NSDictionary *)params {
    return [[MKBVScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANBV_Module_AboutController:(NSDictionary *)params {
    return [[MKBVAboutController alloc] init];
}

@end
