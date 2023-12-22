//
//  MKBVTimingImmediatelyController.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVTimingImmediatelyController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKPickerView.h"
#import "MKTableSectionLineHeader.h"

#import "MKBVScanTimePointModel.h"

#import "MKBVTimingImmediatelyModel.h"

#import "MKBVReportTimePointCell.h"
#import "MKBVTimingModeAddCell.h"

@interface MKBVTimingImmediatelyController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKBVTimingModeAddCellDelegate,
MKBVReportTimePointCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKBVTimingImmediatelyModel *dataModel;

@end

@implementation MKBVTimingImmediatelyController

- (void)dealloc {
    NSLog(@"MKBVTimingImmediatelyController销毁");
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
    if (indexPath.section == 0) {
        return 44.f;
    }
    if (indexPath.section == 1) {
        return 30.f;
    }
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *header = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    header.headerModel = self.headerList[section];
    return header;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 1) {
        MKBVTimingModeAddCell *cell = [MKBVTimingModeAddCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKBVReportTimePointCell *cell = [MKBVReportTimePointCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    cell.delegate = self;
    [cell resetFlagForFrame];
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Bluetooth Scan Duration
        self.dataModel.duration = value;
        MKTextFieldCellModel *cellModel = self.section0List[0];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - MKBVTimingModeAddCellDelegate
- (void)bv_addButtonPressed:(NSInteger)index {
    if (index != 0) {
        return;
    }
    if (self.section2List.count >= 48) {
        //最多10组
        [self.view showCentralToast:@"You can set up to 48 time points!"];
        return;
    }
    MKBVReportTimePointCellModel *cellModel = [[MKBVReportTimePointCellModel alloc] init];
    cellModel.type = 0;
    cellModel.index = self.section2List.count;
    cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(self.section2List.count + 1)];
    cellModel.hourIndex = 0;
    cellModel.timeSpaceIndex = 0;
    [self.section2List addObject:cellModel];
    
    [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - MKBVReportTimePointCellDelegate

- (void)bv_cellDeleteButtonPressed:(NSInteger)type index:(NSInteger)index {
    if (type != 0) {
        return;
    }
    if (index > self.section2List.count - 1) {
        return;
    }
    [self.section2List removeObjectAtIndex:index];
    
    for (NSInteger i = 0; i < self.section2List.count; i ++) {
        MKBVReportTimePointCellModel *cellModel = self.section2List[i];
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(i + 1)];
    }
    
    [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
}

/// 用户选择了hour事件
- (void)bv_hourButtonPressed:(NSInteger)type index:(NSInteger)index {
    if (type != 0) {
        return;
    }
    if (![self cellCanSelected]) {
        return;
    }
    [self showTimePointHourPickView:index];
}

/// 用户选择了时间间隔事件
- (void)bv_timeSpaceButtonPressed:(NSInteger)type index:(NSInteger)index {
    if (type != 0) {
        return;
    }
    if (![self cellCanSelected]) {
        return;
    }
    [self showTimePointTimeSpacePickView:index];
}

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)bv_cellResetFrame {
    [self cellCanSelected];
}

- (void)bv_cellTapAction {
    [self cellCanSelected];
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
    NSMutableArray *tempList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.section2List.count; i ++) {
        MKBVReportTimePointCellModel *cellModel = self.section2List[i];
        MKBVScanTimePointModel *pointModel = [[MKBVScanTimePointModel alloc] init];
        pointModel.hour = cellModel.hourIndex;
        pointModel.minuteGear = cellModel.timeSpaceIndex;
        [tempList addObject:pointModel];
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configData:tempList sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method
/**
 当有cell右侧的删除按钮出现时，不能触发点击事件
 
 @return YES可点击，NO不可点击
 */
- (BOOL)cellCanSelected{
    BOOL canSelected = YES;
    NSArray *arrCells = [self.tableView visibleCells];
    for (int i = 0; i < [arrCells count]; i++) {
        UITableViewCell *cell = arrCells[i];
        if ([cell isKindOfClass:MKBVReportTimePointCell.class]) {
            MKBVReportTimePointCell *tempCell = (MKBVReportTimePointCell *)cell;
            if ([tempCell canReset]) {
                [tempCell resetCellFrame];
                canSelected = NO;
            }
        }
    }
    return canSelected;
}

- (void)showTimePointHourPickView:(NSInteger)index {
    MKBVReportTimePointCellModel *cellModel = self.section2List[index];
    
    MKPickerView *pickView = [[MKPickerView alloc] init];
    NSArray *dataList = @[@"00",@"01",@"02",@"03",
                          @"04",@"05",@"06",@"07",
                          @"08",@"09",@"10",@"11",
                          @"12",@"13",@"14",@"15",
                          @"16",@"17",@"18",@"19",
                          @"20",@"21",@"22",@"23"];
    [pickView showPickViewWithDataList:dataList selectedRow:cellModel.hourIndex block:^(NSInteger currentRow) {
        cellModel.hourIndex = currentRow;
        [self.tableView mk_reloadRow:index inSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)showTimePointTimeSpacePickView:(NSInteger)index {
    MKBVReportTimePointCellModel *cellModel = self.section2List[index];
    
    MKPickerView *pickView = [[MKPickerView alloc] init];
    NSArray *dataList = @[@"00",@"10",@"20",@"30",@"40",@"50"];
    [pickView showPickViewWithDataList:dataList selectedRow:cellModel.timeSpaceIndex block:^(NSInteger currentRow) {
        cellModel.timeSpaceIndex = currentRow;
        [self.tableView mk_reloadRow:index inSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Bluetooth Scan Duration";
    cellModel.msgFont = MKFont(13.f);
    cellModel.textPlaceholder = @"3 ~ 65535";
    cellModel.maxLength = 5;
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.textFieldValue = self.dataModel.duration;
    cellModel.unit = @"s";
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKBVTimingModeAddCellModel * cellModel = [[MKBVTimingModeAddCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Bluetooth Scan Time Point";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    for (NSInteger i = 0; i < self.dataModel.pointList.count; i ++) {
        MKBVScanTimePointModel *tempModel = self.dataModel.pointList[i];
        MKBVReportTimePointCellModel *cellModel = [[MKBVReportTimePointCellModel alloc] init];
        cellModel.type = 0;
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(i + 1)];
        cellModel.hourIndex = tempModel.hour;
        cellModel.timeSpaceIndex = tempModel.minuteGear;
        [self.section2List addObject:cellModel];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Timing Scan & Immediately Report";
    self.titleLabel.font = MKFont(15.f);
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BV", @"MKBVTimingImmediatelyController", @"bv_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKBVTimingImmediatelyModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBVTimingImmediatelyModel alloc] init];
    }
    return _dataModel;
}

@end
