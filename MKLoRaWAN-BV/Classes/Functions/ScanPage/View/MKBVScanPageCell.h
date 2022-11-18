//
//  MKBVScanPageCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKBVScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)bv_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKBVScanPageModel;
@interface MKBVScanPageCell : MKBaseCell

@property (nonatomic, strong)MKBVScanPageModel *dataModel;

@property (nonatomic, weak)id <MKBVScanPageCellDelegate>delegate;

+ (MKBVScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
