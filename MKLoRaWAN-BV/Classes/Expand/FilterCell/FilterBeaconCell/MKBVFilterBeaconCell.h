//
//  MKBVFilterBeaconCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKBVFilterBeaconCellDelegate <NSObject>

- (void)mk_bv_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_bv_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKBVFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKBVFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKBVFilterBeaconCellDelegate>delegate;

+ (MKBVFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
