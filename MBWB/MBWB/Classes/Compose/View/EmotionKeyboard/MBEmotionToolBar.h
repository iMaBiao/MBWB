//
//  MBEmotionToolBar.h
//  MBWB
//
//  Created by 浩渺 on 16/5/20.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBEmotionToolBar;
typedef enum{
    MBEmotionTypeRecent,    //最近
    MBEmotionTypeDefault,   //默认
    MBEmotionTypeEmoji,     //Emoji
    MBEmotionTypeLxh        //浪小花
}MBEmotionType;

@protocol MBEmotionToolBarDelegate <NSObject>

@optional

- (void)emotionToolBar:(MBEmotionToolBar *)toolBar didSelectedButton:(MBEmotionType)emotionType;

@end

@interface MBEmotionToolBar : UIView
@property(nonatomic,weak)id<MBEmotionToolBarDelegate> delegate;

@end
