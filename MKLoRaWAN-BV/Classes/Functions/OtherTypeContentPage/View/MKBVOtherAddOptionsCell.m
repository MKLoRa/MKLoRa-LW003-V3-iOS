//
//  MKBVOtherAddOptionsCell.m
//  MKLoRaWAN-BV_Example
//
//  Created by aa on 2022/11/2.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBVOtherAddOptionsCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

@interface MKBVOtherAddOptionsCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *addButton;

@end

@implementation MKBVOtherAddOptionsCellModel
@end

@implementation MKBVOtherAddOptionsCell

+ (MKBVOtherAddOptionsCell *)initCellWithTableView:(UITableView *)tableView {
    MKBVOtherAddOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBVOtherAddOptionsCellIdenty"];
    if (!cell) {
        cell = [[MKBVOtherAddOptionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBVOtherAddOptionsCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.addButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.addButton.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)addButtonPressed {
    if ([self.delegate respondsToSelector:@selector(bv_otherAddOptionsCellAddPressed:)]) {
        [self.delegate bv_otherAddOptionsCellAddPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKBVOtherAddOptionsCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKBVOtherAddOptionsCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:LOADICON(@"MKLoRaWAN-BV", @"MKBVOtherAddOptionsCell", @"bv_addIcon.png") forState:UIControlStateNormal];
        [_addButton addTarget:self
                       action:@selector(addButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
