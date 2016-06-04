//
//  MBBadgeView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBBadgeView.h"

@implementation MBBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resizeImage:@"main_badge"] forState:UIControlStateNormal];
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    //设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    //根据文字计算自己的尺寸
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (titleSize.width < bgW) {
        self.width = bgW;
    }else{
        self.width = titleSize.width + 10;
    }
}

@end
