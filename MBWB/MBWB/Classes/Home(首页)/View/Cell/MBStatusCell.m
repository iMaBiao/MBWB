//
//  MBStatusCell.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusCell.h"
#import "MBStatusDetailView.h"
#import "MBStatusToolBar.h"
#import "MBStatusFrame.h"

@interface MBStatusCell()
@property(nonatomic,weak)MBStatusDetailView *detailView;
@property(nonatomic,weak)MBStatusToolBar *toolBar;

@end

@implementation MBStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"statuses";
    MBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MBStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化子控件
        //1、添加status具体内容
        MBStatusDetailView *detailView = [[MBStatusDetailView alloc]init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        //2.添加工具条
        MBStatusToolBar *toolBar = [[MBStatusToolBar alloc]init];
        [self.contentView addSubview:toolBar];
        self.toolBar = toolBar;
        
        //cell的设置
        self.backgroundColor = [UIColor clearColor];
    }
    return  self;
}

- (void)setStatusFrame:(MBStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;

    //微博具体内容的frame数据
    self.detailView.detailFrame  = statusFrame.detailFrame;
    
    //底部工具条的frame数据
    self.toolBar.frame = statusFrame.toolBarFrame;
    self.toolBar.status = statusFrame.status;
}


@end
