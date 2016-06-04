//
//  MBComposeToolBar.m
//  MBWB
//
//  Created by 浩渺 on 16/5/17.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBComposeToolBar.h"

@interface MBComposeToolBar()
@property(nonatomic,weak)UIButton *emotionButton;
@end

@implementation MBComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
         // 添加所有的子控件
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted"tag:MBComposeToolBarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted"tag:MBComposeToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:MBComposeToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted"tag:MBComposeToolBarButtonTypeEmotion];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted"tag:MBComposeToolBarButtonTypeMention];
        
    }
    return self;
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton{
    _showEmotionButton = showEmotionButton;
    
    if (showEmotionButton) {// 显示表情按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateSelected];
    }else{// 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateSelected];
    }
}

/**
 *  添加一个按钮
 */
- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(MBComposeToolBarButtonType)tag{
    
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [self addSubview:button];
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickButton:)]) {
        [self.delegate composeTool:self didClickButton:button.tag];
    }
}

/**
 *  布局子控件（按钮）
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i =0; i < count; i++) {
        //取出self的子控件（只有按钮）
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.height = buttonH;
        button.width = buttonW;
        button.x = i * buttonW;
    }
}



@end
