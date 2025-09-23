//
//  MKBVLoRaSettingAccountCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2025/3/3.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVLoRaSettingAccountCellModel : NSObject

@property (nonatomic, copy)NSString *account;

@end

@protocol MKBVLoRaSettingAccountCellDelegate <NSObject>

- (void)bv_loRaSettingAccountCell_logoutBtnPressed;

@end

@interface MKBVLoRaSettingAccountCell : MKBaseCell

@property (nonatomic, strong)MKBVLoRaSettingAccountCellModel *dataModel;

@property (nonatomic, weak)id <MKBVLoRaSettingAccountCellDelegate>delegate;

+ (MKBVLoRaSettingAccountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
