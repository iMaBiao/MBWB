//
//  MBEmotionView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBEmotionView.h"
#import "MBEmotion.h"

@implementation MBEmotionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(MBEmotion *)emotion{
    _emotion = emotion;
    
    if (emotion.code) {// emoji表情
        // emoji的大小取决于字体大小
        // emotion.code == 0x1f603 --> \u54367
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        
        //再次开启动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView setAnimationsEnabled:YES];
        });
    }else{// 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png];
        UIImage *image = [UIImage imageWithName:icon];
        
        if (iOS7) {//不需要进行蓝色的渲染
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        [self setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];        
    }
    
}

@end
