//
//  MBCommonCell.m
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBCommonCell.h"
#import "MBCommonItem.h"
#import "MBBadgeView.h"
#import "MBCommonArrowItem.h"
#import "MBCommonSwitchItem.h"
#import "MBCommonLabelItem.h"
#import "MBCommonCenterItem.h"

@interface MBCommonCell()
/***  箭头*/
@property(nonatomic,strong)UIImageView *rightArrow;
/***  开关*/
@property(nonatomic,strong)UISwitch *rightSwitch;
/***  标签*/
@property(nonatomic,strong)UILabel *rightLabel;
/***  提醒数字*/
@property(nonatomic,strong)MBBadgeView *badgeView;


@end

@implementation MBCommonCell
#pragma mark --懒加载右边的View
- (UIImageView *)rightArrow{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc]init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc]init];
    }
    return _rightLabel;
}

- (MBBadgeView *)badgeView{
    if (_badgeView == nil) {
        self.badgeView = [[MBBadgeView alloc]init];
    }
    return _badgeView;
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows{
    
    //取出背景
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
//    NSLog(@"selectedBackgroundView = %@",self.selectedBackgroundView);
//    selectedBackgroundView = <UITableViewCellSelectedBackground: 0x127fab770; frame = (0 -0.5; 320 44.5); opaque = NO; layer = <CALayer: 0x127fab910>>
    
    //设置背景图
    if (rows == 1) {
        bgView.image = [UIImage resizeImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizeImage:@"common_card_background_highlighted"];
    }else if (indexPath.row == 0){//首行
        bgView.image = [UIImage resizeImage:@"common_card_top_background"];
//        selectedBgView.image = [UIImage resizeImage:@"common_card_top_background_highlighted"];

    }else if (indexPath.row == rows -1){//末行
        bgView.image = [UIImage resizeImage:@"common_card_bottom_background"];
//        selectedBgView.image = [UIImage resizeImage:@"common_card_bottom_background_highlighted"];
    }else{  //中间
        bgView.image = [UIImage resizeImage:@"common_card_middle_background"];
//        selectedBgView.image = [UIImage resizeImage:@"common_card_middle_background_highlighted"];
    }
}



+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"commom";
    MBCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MBCommonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题的文字
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc]init];
        self.selectedBackgroundView = [[UIImageView alloc]init];
    }
    return  self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
    
}

- (void)setItem:(MBCommonItem *)item{
    _item = item;
    
    //设置基本的数据
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    //设置右边的内容
    if (item.badgeValue) {
        self.badgeView.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeView;
    }else if ([item isKindOfClass:[MBCommonArrowItem class]]){
        self.accessoryView = self.rightArrow;
    }else if ([item isKindOfClass:[MBCommonSwitchItem class]]){
        self.accessoryView = self.rightSwitch;
    }else if ([item isKindOfClass:[MBCommonLabelItem class]]){

        MBCommonLabelItem *labelItem = (MBCommonLabelItem *)item;
        self.rightLabel.text = labelItem.text;
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font];
        self.accessoryView = self.rightLabel;
    }else{
        self.accessoryView = nil;
    }
    
    if (item.hiddenArrow) {
        self.rightArrow.hidden = YES;
    }else{
        self.rightArrow.hidden = NO;
    }
}

@end
