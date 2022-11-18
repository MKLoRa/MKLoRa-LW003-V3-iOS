//
//  MKBVOtherTypeContentCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/31.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVOtherTypeContentCellModel : NSObject

/// 当前cell所处Block号
@property (nonatomic, assign)NSInteger blockNumber;

/// 当前cell在blockNumber中的index
@property (nonatomic, assign)NSInteger blockIndex;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *dataType;

@property (nonatomic, copy)NSString *startIndex;

@property (nonatomic, copy)NSString *endIndex;

@property (nonatomic, copy)NSString *unitMsg;

@end

@protocol MKBVOtherTypeContentCellDelegate <NSObject>

- (void)bv_otherCellDeletedWithNumber:(NSInteger)blockNumber
                           blockIndex:(NSInteger)blockIndex;

- (void)bv_otherCellDataTypeChanged:(NSString *)dataType
                        blockNumber:(NSInteger)blockNumber
                         blockIndex:(NSInteger)blockIndex;

- (void)bv_otherCellStartIndexChanged:(NSString *)startIndex
                          blockNumber:(NSInteger)blockNumber
                           blockIndex:(NSInteger)blockIndex;

- (void)bv_otherCellEndIndexChanged:(NSString *)endIndex
                        blockNumber:(NSInteger)blockNumber
                         blockIndex:(NSInteger)blockIndex;

@end

@interface MKBVOtherTypeContentCell : MKBaseCell

@property (nonatomic, weak)id <MKBVOtherTypeContentCellDelegate>delegate;

@property (nonatomic, strong)MKBVOtherTypeContentCellModel *dataModel;

+ (MKBVOtherTypeContentCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
