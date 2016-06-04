//
//  MBEmotionGridView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/24.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBEmotionGridView.h"
#import "MBEmotionView.h"
#import "MBEmotion.h"
#import "MBEmotionPopView.h"
#import "MBEmotionTool.h"

@interface MBEmotionGridView()

@property(nonatomic,weak)UIButton *deleteButton;

@property(nonatomic,strong)NSMutableArray *emotionViews;

@property(nonatomic,strong)MBEmotionPopView *popView;


@end
@implementation MBEmotionGridView

- (MBEmotionPopView *)popView{
    if (!_popView) {
        self.popView = [MBEmotionPopView popView];
    }
    return _popView;
}

- (NSMutableArray *)emotionViews{
    if (!_emotionViews) {
        self.emotionViews  = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加删除按钮
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        //给自己添加一个长按手势
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

/**
 *  根据触摸点返回对应的表情控件
 */
- (MBEmotionView *)emotionViewWithPoint:(CGPoint)point{
    
    __block MBEmotionView *foundEmotionView = nil;
    
    //遍历emotionViews数组，查找emotionView是否包含这个point
    [self.emotionViews enumerateObjectsUsingBlock:^(MBEmotionView *emotionView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(emotionView.frame , point)) {
            foundEmotionView = emotionView;
            *stop = YES;
        }
    }];
    return foundEmotionView;
}
/**
 *  长按手势
 */
- (void)longPress:(UILongPressGestureRecognizer *)recognizer{
    //捕捉触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    //检测触摸点落在哪个表情上
    MBEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {//手松开了
        //移除表情弹出控件
        [self.popView dismiss];
        //选中表情
        [self selecteEmotion:emotionView.emotion];
        
    }else{//手没松开
        //显示表情弹出控件
        [self.popView showFromEmotionView:emotionView];
    }
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    //添加新的表情
    int count = emotions.count;
    int currentEmotionViewcount = self.emotionViews.count;
    for (int i = 0; i < count; i++) {
        MBEmotionView *emotionView = nil;
        if (i >= currentEmotionViewcount) {//emotionView不够用
            emotionView = [[MBEmotionView alloc]init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        }else{ //够用
            emotionView = self.emotionViews[i];
        }
        //传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    //多余的emotionView隐藏起来
    for (int i= count; i < currentEmotionViewcount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

/**
 *  监听表情的单击
 */
- (void)emotionClick:(MBEmotionView *)emotionView{
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
    
    //选中表情
    [self selecteEmotion:emotionView.emotion];
}
/**
 *  选中表情
 */
- (void)selecteEmotion:(MBEmotion *)emotion{
    if (emotion == nil) return;
    
    //保持使用记录
    [MBEmotionTool addRecentEmotion:emotion];
    
    //发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MBEmotionDidSelectedNotification" object:nil userInfo:@{@"MBSelectedEmotion": emotion}];
}

- (void)deleteClick{
    
    //发出一个删除表情的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MBEmotionDidDeletedNotification" object:nil userInfo:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    //排列所有的表情
    int count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2* leftInset)/MBEmotionMaxCols;
    CGFloat emotionViewH  = (self.width - topInset) /MBEmotionMaxRows;
    for (int i = 0; i <count ; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % MBEmotionMaxCols ) * emotionViewW;
        emotionView.y = topInset + (i / MBEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    //删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}
@end
