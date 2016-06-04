//
//  MBEmotionTextView.h
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBTextView.h"
@class MBEmotion;
@interface MBEmotionTextView : MBTextView

/**
 *  拼接表情到最后
 */
- (void)appendEmotion:(MBEmotion *)emotion;

@end
