//
//  MBEmotionPopView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBEmotionPopView.h"
#import "MBEmotionView.h"

@interface MBEmotionPopView()
@property (weak, nonatomic) IBOutlet MBEmotionView *emotionView;




@end
@implementation MBEmotionPopView

+ (instancetype)popView{
    return [[[NSBundle mainBundle]loadNibNamed:@"MBEmotionPopView" owner:nil options:nil]lastObject];
}

/**
 *  显示表情弹出的控件
 *
 *  @param fromEmotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(MBEmotionView *)fromEmotionView{
    if (fromEmotionView == nil) return;
    
    //显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    //添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    //坐标转换
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
    
    
}

- (void)dismiss{
 
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect{
    [[UIImage imageWithName:@"emoticon_keyboard_magnifier"]drawInRect:rect];
}

@end
