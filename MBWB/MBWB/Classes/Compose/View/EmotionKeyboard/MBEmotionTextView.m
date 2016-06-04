//
//  MBEmotionTextView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBEmotionTextView.h"
#import "MBEmotion.h"
@implementation MBEmotionTextView

/**
 *  拼接表情到最后
 */
- (void)appendEmotion:(MBEmotion *)emotion{
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    }else{
        [self insertText:emotion.chs];
    }
}

@end
