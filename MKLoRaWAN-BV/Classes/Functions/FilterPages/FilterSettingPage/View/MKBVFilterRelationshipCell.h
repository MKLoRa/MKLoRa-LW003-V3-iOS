//
//  MKBVFilterRelationshipCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/3/16.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVFilterRelationshipCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray *dataList;

@end

@protocol MKBVFilterRelationshipCellDelegate <NSObject>

- (void)bv_filterRelationshipChanged:(NSInteger)index dataListIndex:(NSInteger)dataListIndex;

@end

@interface MKBVFilterRelationshipCell : MKBaseCell

@property (nonatomic, strong)MKBVFilterRelationshipCellModel *dataModel;

@property (nonatomic, weak)id <MKBVFilterRelationshipCellDelegate>delegate;

+ (MKBVFilterRelationshipCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
