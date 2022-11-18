//
//  MKBVDebuggerCell.h
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBVDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKBVDebuggerCellDelegate <NSObject>

- (void)bv_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKBVDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKBVDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKBVDebuggerCellDelegate>delegate;

+ (MKBVDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
