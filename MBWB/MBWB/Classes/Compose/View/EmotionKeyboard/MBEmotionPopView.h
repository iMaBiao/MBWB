//
//  MBEmotionPopView.h
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBEmotionView;

@interface MBEmotionPopView : UIView

+ (instancetype)popView;

/**
 *  显示表情弹出的控件
 *
 *  @param fromEmotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(MBEmotionView *)fromEmotionView;

- (void)dismiss;

@end
