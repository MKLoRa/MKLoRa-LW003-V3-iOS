//
//  Target_LoRaWANBV_Module.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_LoRaWANBV_Module : NSObject

/// 扫描页面
- (UIViewController *)Action_LoRaWANBV_Module_ScanController:(NSDictionary *)params;

/// 关于页面
- (UIViewController *)Action_LoRaWANBV_Module_AboutController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
