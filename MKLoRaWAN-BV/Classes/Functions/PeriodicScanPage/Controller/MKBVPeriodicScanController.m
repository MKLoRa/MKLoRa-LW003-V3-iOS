//
//  MKBVPeriodicScanController.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVPeriodicScanController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"

#import "MKBVPeriodicScanModel.h"

@interface MKBVPeriodicScanController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKBVPeriodicScanModel *dataModel;

@end

@implementation MKBVPeriodicScanController

- (void)dealloc {
    NSLog(@"MKBVPeriodicScanController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method

- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTextFieldCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel cellHeightWithContentWidth:kViewWidth];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Bluetooth Scan Duration
        self.dataModel.scanDuration = value;
        MKTextFieldCellModel *cellModel = self.dataList[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Bluetooth Scan Interval
        self.dataModel.scanInterval = value;
        MKTextFieldCellModel *cellModel = self.dataList[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 2) {
        //Report Interval
        self.dataModel.reportInterval = value;
        MKTextFieldCellModel *cellModel = self.dataList[2];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Bluetooth Scan Duration";
    cellModel1.msgFont = MKFont(13.f);
    cellModel1.textFieldValue = self.dataModel.scanDuration;
    cellModel1.textPlaceholder = @"3 ~ 65535";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.maxLength = 5;
    cellModel1.unit = @"s";
    [self.dataList addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Bluetooth Scan Interval";
    cellModel2.msgFont = MKFont(13.f);
    cellModel2.textFieldValue = self.dataModel.scanInterval;
    cellModel2.textPlaceholder = @"3 ~ 65535";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.maxLength = 5;
    cellModel2.unit = @"s";
    cellModel2.noteMsg = @"*The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.";
    cellModel2.noteMsgColor = RGBCOLOR(105, 105, 105);
    [self.dataList addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Report Interval";
    cellModel3.msgFont = MKFont(13.f);
    cellModel3.textFieldValue = self.dataModel.reportInterval;
    cellModel3.textPlaceholder = @"3 ~ 65535";
    cellModel3.textFieldType = mk_realNumberOnly;
    cellModel3.maxLength = 5;
    cellModel3.unit = @"s";
    cellModel3.noteMsg = @"*The Report Interval shouldn't be less than Bluetooth Scan Interval.";
    cellModel3.noteMsgColor = RGBCOLOR(105, 105, 105);
    [self.dataList addObject:cellModel3];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Periodic Scan & Periodic Report";
    self.titleLabel.font = MKFont(15.f);
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BV", @"MKBVPeriodicScanController", @"bv_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKBVPeriodicScanModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBVPeriodicScanModel alloc] init];
    }
    return _dataModel;
}

@end

