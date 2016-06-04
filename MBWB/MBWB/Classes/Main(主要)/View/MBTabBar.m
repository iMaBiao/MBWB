//
//  MBTabBar.m
//  MBWB
//
//  Created by 浩渺 on 16/5/14.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBTabBar.h"

@interface MBTabBar()
@property(nonatomic,weak)UIButton *plusButton;

@end

@implementation MBTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundImage = [UIImage imageWithName:@"tabbar_background"];
        }
        self.backgroundImage  = [UIImage imageWithName:@"navigationbar_button_background"];
        //添加加号按钮
        [self addPlusButton];
    }
    return self;
}

/**
 *  添加加号按钮
 */
-(void)addPlusButton{
    UIButton *plusButton = [[UIButton alloc]init];
    
    // 设置背景
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    // 设置图标
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

- (void)plusButtonClick{
//    NSLog(@"plusButton did click");
    
    if ([self.tabBardelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.tabBardelegate tabBarDidClickPlusButton:self];
    }
}

/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置plusButton的frame
    [self setPlusButtonFrame];
    
    //设置其他按钮的Frame
    [self setAllTabBarButtonFrame];
    
}

/**
 *  设置所有plusButton的frame
 */
- (void)setPlusButtonFrame{
    //plusButton的尺寸设置成当前背景图的尺寸
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}

/**
 *  设置所有tabbarButton的frame
 */
- (void)setAllTabBarButtonFrame{
    
    int index = 0;
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
         // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setTabBarFrame:tabBarButton atIndex:index];
        // 索引增加
        index++;
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setTabBarFrame:(UIView *)tabBarButton atIndex:(int )index{
    
    //计算Button的尺寸
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    tabBarButton.y = 0;
    if ( index >= 2) {
        tabBarButton.x = buttonW * (index +1);
    }else{
        tabBarButton.x = buttonW * index;
    }
}



@end
