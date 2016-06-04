//
//  MBStatusToolBar.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusToolBar.h"
#import "MBStatus.h"

@interface MBStatusToolBar()
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,strong)NSMutableArray *dividers;

@property(nonatomic,weak)UIButton *repostsButton;
@property(nonatomic,weak)UIButton *commentsButton;
@property(nonatomic,weak)UIButton *attitudesButton;
@end

@implementation MBStatusToolBar
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        self.buttons =[NSMutableArray array];
    }
    return _buttons;
}
- (NSMutableArray *)dividers{
    if (_dividers == nil) {
        self.dividers =  [NSMutableArray array];
    }
    return _dividers;
}

- (void)setStatus:(MBStatus *)status{
    
    _status = status;    
    [self setButtonTitle:self.repostsButton count:status.reposts_count defaultTitle:@"转发"];
    [self setButtonTitle:self.commentsButton count:status.comments_count defaultTitle:@"评论"];
    [self setButtonTitle:self.attitudesButton count:status.attitudes_count defaultTitle:@"赞"];
    
}
/**
 *  设置按钮的文字
 *
 *  @param button       需要显示文字的按钮
 *  @param count        按钮显示的数字
 *  @param defaultTitle 按钮的默认文字
 */
- (void)setButtonTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle{
    
    if (count >=10000) {//[10000 ,无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
         //如果出现整万的， 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count > 0){//(0,10000)
        defaultTitle = [NSString stringWithFormat:@"%d",count];
    }
    //没有数字 就显示默认文字
    [button setTitle:defaultTitle  forState:UIControlStateNormal];
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImage:@"timeline_card_bottom_background"];
        
        self.repostsButton = [self setButtonWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentsButton = [self setButtonWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.attitudesButton = [self setButtonWithIcon:@"timeline_icon_unlike" title:@"赞"];
        
        [self setDividers];
        [self setDividers];
    }
    return self;
}
/**
 *  分割线
 */
- (void)setDividers{
    
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setButtonWithIcon:(NSString *)icon title:(NSString *)title{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置高亮时的背景
    [button setBackgroundImage:[UIImage imageWithName:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    
    //设置间距
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:button];
    
    [self.buttons addObject:button];
    
    return button;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置按钮的frame
    NSInteger buttonCount = self.buttons.count;
    CGFloat buttonW = self.width / buttonCount;
    CGFloat buttonH = self.height;
    for (int i =0; i< buttonCount; i++) {
        UIButton *btn = self.buttons[i];
        btn.width = buttonW;
        btn.height = buttonH;
        btn.y = 0;
        btn.x = i * buttonW;
    }
    
    //设置分割线的frame
    NSInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 4;
        divider.height = buttonH;
        divider.centerX = buttonW * (i +1);
        divider.centerY = buttonH * 0.5;
    }
}



@end
