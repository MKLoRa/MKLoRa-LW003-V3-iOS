//
//  MKBVOtherAddOptionsCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/11/2.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVOtherAddOptionsCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKBVOtherAddOptionsCellDelegate <NSObject>

- (void)bv_otherAddOptionsCellAddPressed:(NSInteger)index;

@end

@interface MKBVOtherAddOptionsCell : MKBaseCell

@property (nonatomic, weak)id <MKBVOtherAddOptionsCellDelegate>delegate;

@property (nonatomic, strong)MKBVOtherAddOptionsCellModel *dataModel;

+ (MKBVOtherAddOptionsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
