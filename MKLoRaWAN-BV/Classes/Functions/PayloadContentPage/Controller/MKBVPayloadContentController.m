//
//  MKBVPayloadContentController.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/10/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVPayloadContentController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKSettingTextCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKBVBeaconContentController.h"
#import "MKBVUIDContentController.h"
#import "MKBVURLContentController.h"
#import "MKBVTLMContentController.h"
#import "MKBVBXPBeaconContentController.h"
#import "MKBVBXPInfoContentController.h"
#import "MKBVBXPAccContentController.h"
#import "MKBVBXPTHContentController.h"
#import "MKBVBXPButtonContentController.h"
#import "MKBVBXPTagContentController.h"
#import "MKBVOtherTypeContentController.h"

@interface MKBVPayloadContentController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)NSMutableArray *headerList;

@end

@implementation MKBVPayloadContentController

- (void)dealloc {
    NSLog(@"MKBVPayloadContentController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *header = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    header.headerModel = self.headerList[section];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //iBeaocn Content
        MKBVBeaconContentController *vc = [[MKBVBeaconContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Eddystone-UID Content
        MKBVUIDContentController *vc = [[MKBVUIDContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Eddystone-URL Content
        MKBVURLContentController *vc = [[MKBVURLContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Eddystone-TLM Content
        MKBVTLMContentController *vc = [[MKBVTLMContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //BXP-iBeaocn Content
        MKBVBXPBeaconContentController *vc = [[MKBVBXPBeaconContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //BXP-Device Info Content
        MKBVBXPInfoContentController *vc = [[MKBVBXPInfoContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        //BXP-ACC Content
        MKBVBXPAccContentController *vc = [[MKBVBXPAccContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 7) {
        //BXP-T&H Content
        MKBVBXPTHContentController *vc = [[MKBVBXPTHContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 8) {
        //BXP-Button Content
        MKBVBXPButtonContentController *vc = [[MKBVBXPButtonContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 9) {
        //BXP-Tag Content
        MKBVBXPTagContentController *vc = [[MKBVBXPTagContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 10) {
        //Other Type Content
        MKBVOtherTypeContentController *vc = [[MKBVOtherTypeContentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"iBeacon Content";
    [self.dataList addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Eddystone-UID";
    [self.dataList addObject:cellModel2];
    
    MKSettingTextCellModel *cellModel3 = [[MKSettingTextCellModel alloc] init];
    cellModel3.leftMsg = @"Eddystone-URL Content";
    [self.dataList addObject:cellModel3];
    
    MKSettingTextCellModel *cellModel4 = [[MKSettingTextCellModel alloc] init];
    cellModel4.leftMsg = @"Eddystone-TLM Content";
    [self.dataList addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"BXP-iBeacon Content";
    [self.dataList addObject:cellModel5];
    
    MKSettingTextCellModel *cellModel6 = [[MKSettingTextCellModel alloc] init];
    cellModel6.leftMsg = @"BXP-Device Info Content";
    [self.dataList addObject:cellModel6];
    
    MKSettingTextCellModel *cellModel7 = [[MKSettingTextCellModel alloc] init];
    cellModel7.leftMsg = @"BXP-ACC Content";
    [self.dataList addObject:cellModel7];
    
    MKSettingTextCellModel *cellModel8 = [[MKSettingTextCellModel alloc] init];
    cellModel8.leftMsg = @"BXP-T&H Content";
    [self.dataList addObject:cellModel8];
    
    MKSettingTextCellModel *cellModel9 = [[MKSettingTextCellModel alloc] init];
    cellModel9.leftMsg = @"BXP-Button Content";
    [self.dataList addObject:cellModel9];
    
    MKSettingTextCellModel *cellModel10 = [[MKSettingTextCellModel alloc] init];
    cellModel10.leftMsg = @"BXP-Tag";
    [self.dataList addObject:cellModel10];
    
    MKSettingTextCellModel *cellModel11 = [[MKSettingTextCellModel alloc] init];
    cellModel11.leftMsg = @"Other Type";
    [self.dataList addObject:cellModel11];
    
    for (NSInteger i = 0; i < 1; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Payload Content Selection";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

@end
