//
//  MBEmotionToolBar.m
//  MBWB
//
//  Created by 浩渺 on 16/5/20.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#define MBEmotionToolbarButtonMaxCount 4

#import "MBEmotionToolBar.h"

@interface MBEmotionToolBar()
/** 记录当前选中的按钮 */
@property(nonatomic,weak)UIButton *selectedButton;
@end

@implementation MBEmotionToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        
        // 1.添加4个按钮
        [self setButton:@"最近" tag:MBEmotionTypeRecent];
        UIButton *defaultButton = [self setButton:@"默认" tag:MBEmotionTypeDefault];
        [self setButton:@"Emoji" tag:MBEmotionTypeEmoji];
        [self setButton:@"浪小花" tag:MBEmotionTypeLxh];
        
        // 2.默认选中“默认”按钮
//        [self ButtonClick:defaultButton];
        
        //监听表情选中的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelected:) name:@"MBEmotionDidSelectedNotification" object:nil];
        
    }
    return self;
}
/**
 *  表情选中
 */
-(void)emotionDidSelected:(NSNotification *)note{
    if (self.selectedButton.tag == MBEmotionTypeRecent) {
        [self buttonClick:self.selectedButton];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  添加按钮
 */
- (UIButton *)setButton:(NSString *)title tag:(MBEmotionType)tag{
    
    UIButton *button = [[UIButton alloc]init];
    button.tag = tag;
    
    //文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];

    //添加按钮
    [self addSubview:button];

    //设置背景图片
    int count = self.subviews.count;

    if (count == 1) {//第一个按钮
        [button setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }else if (count == MBEmotionToolbarButtonMaxCount){//最后一个按钮
        [button setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else{//中间的按钮
        [button setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    return button;
}
/**
 *  监听工具条按钮点击
 */
- (void)buttonClick:(UIButton *)button{
    
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolBar:didSelectedButton:)]) {
        [self.delegate emotionToolBar:self didSelectedButton:button.tag];
    }
}

- (void)setDelegate:(id<MBEmotionToolBarDelegate>)delegate{
    _delegate = delegate;
    
    //获得默认按钮
    UIButton *defaultButton = (UIButton *)[self viewWithTag:MBEmotionTypeDefault];
    //默认选择”默认“按钮
    [self buttonClick:defaultButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.width / MBEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i < MBEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}
@end
