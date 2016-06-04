//
//  MBStatusDetailView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusDetailView.h"
#import "MBStatusOriginalView.h"
#import "MBStatusRetweetedView.h"
#import "MBStatusDetailFrame.h"

@interface MBStatusDetailView()

@property(nonatomic,weak)MBStatusOriginalView *originalView;
@property(nonatomic,weak)MBStatusRetweetedView *retweetedView;

@end
@implementation MBStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子控件
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImage:@"timeline_card_top_background"];
        
        //1、添加原创status
        MBStatusOriginalView *originalView  = [[MBStatusOriginalView alloc]init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        //2、添加转发stauts
        MBStatusRetweetedView *retweetedView = [[MBStatusRetweetedView alloc]init];
        [self addSubview:retweetedView];
        self.retweetedView  = retweetedView;
    }
    return self;
}

- (void)setDetailFrame:(MBStatusDetailFrame *)detailFrame{
    
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 1.原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
        
    // 2.原创转发的frame数据
    self.retweetedView.retweetedFrame  = detailFrame.retweetedFrame;
}

@end
