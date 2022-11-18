//
//  MKBVTimingModeAddCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVTimingModeAddCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKBVTimingModeAddCellDelegate <NSObject>

- (void)bv_addButtonPressed:(NSInteger)index;

@end

@interface MKBVTimingModeAddCell : MKBaseCell

@property (nonatomic, strong)MKBVTimingModeAddCellModel *dataModel;

@property (nonatomic, weak)id <MKBVTimingModeAddCellDelegate>delegate;

+ (MKBVTimingModeAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
