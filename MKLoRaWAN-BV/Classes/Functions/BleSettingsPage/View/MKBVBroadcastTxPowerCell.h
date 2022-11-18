//
//  MKBVBroadcastTxPowerCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2021/6/15.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVBroadcastTxPowerCellModel : NSObject

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 */
@property (nonatomic, assign)NSInteger txPowerValue;

@end

@protocol MKBVBroadcastTxPowerCellDelegate <NSObject>

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 */
- (void)bv_txPowerValueChanged:(NSInteger)txPower;

@end

@interface MKBVBroadcastTxPowerCell : MKBaseCell

@property (nonatomic, weak)id <MKBVBroadcastTxPowerCellDelegate>delegate;

@property (nonatomic, strong)MKBVBroadcastTxPowerCellModel *dataModel;

+ (MKBVBroadcastTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
