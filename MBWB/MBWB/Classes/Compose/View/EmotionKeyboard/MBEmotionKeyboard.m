//
//  MBEmotionKeyboard.m
//  MBWB
//
//  Created by 浩渺 on 16/5/20.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBEmotionKeyboard.h"
#import "MBEmotionListView.h"

#import "MBEmotion.h"
#import "MJExtension.h"
#import "MBEmotionToolBar.h"
#import "MBEmotionTool.h"

@interface MBEmotionKeyboard()<MBEmotionToolBarDelegate>
/** 表情列表 */
@property(nonatomic,weak)MBEmotionListView *listView;
/** 表情工具条 */
@property(nonatomic,weak)MBEmotionToolBar *toolBar;

@end

@implementation MBEmotionKeyboard

+ (instancetype)keyboard{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];
        
        //添加表情列表
        MBEmotionListView *listView = [[MBEmotionListView alloc]init];
        [self addSubview:listView];
        self.listView = listView;
        
        //添加表情工具条
        MBEmotionToolBar *toolBar = [[MBEmotionToolBar alloc]init];
        toolBar.delegate = self;
        [self addSubview:toolBar];
        self.toolBar = toolBar;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置工具条的frame
    self.toolBar.width = self.width;
    self.toolBar.height = 35;
    self.toolBar.y = self.height - self.toolBar.height;
    
    //设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toolBar.y;
}

#pragma mark MBEmotionToolBarDelegate
- (void)emotionToolBar:(MBEmotionToolBar *)toolBar didSelectedButton:(MBEmotionType)emotionType{
    
    switch (emotionType) {
        case MBEmotionTypeDefault: //默认
            self.listView.emotions = [MBEmotionTool defaultEmotions];
            break;
            
        case MBEmotionTypeEmoji:   //Emoji
            self.listView.emotions = [MBEmotionTool emojiEmotions];
            break;
            
        case MBEmotionTypeLxh:    //浪小花
            self.listView.emotions = [MBEmotionTool lxhEmotions];
            break;
        case MBEmotionTypeRecent:   //最近
            self.listView.emotions = [MBEmotionTool recentEmotions];
            break;

    }
}



@end
