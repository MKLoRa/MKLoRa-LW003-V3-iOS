//
//  MKBVFilterEditSectionHeaderView.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKBVFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_bv_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_bv_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKBVFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKBVFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKBVFilterEditSectionHeaderViewDelegate>delegate;

+ (MKBVFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
