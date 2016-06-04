//
//  MBStatusDetailView.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
// 微博的具体内容 = 原创微博 + 转发微博

#import <UIKit/UIKit.h>

@class MBStatusDetailFrame;

@interface MBStatusDetailView : UIImageView

@property(nonatomic,strong)MBStatusDetailFrame *detailFrame;

@end
