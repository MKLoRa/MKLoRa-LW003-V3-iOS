//
//  MKBVDevEUICell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2025/3/5.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVDevEUICellModel : NSObject

@property (nonatomic, copy)NSString *devEUI;

@end

@interface MKBVDevEUICell : MKBaseCell

@property (nonatomic, strong)MKBVDevEUICellModel *dataModel;

+ (MKBVDevEUICell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
