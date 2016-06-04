//
//  MBStatusRetweetedFrame.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBStatus;

@interface MBStatusRetweetedFrame : NSObject
/** 昵称 */
@property(nonatomic,assign)CGRect nameFrame;
/** 正文 */
@property(nonatomic,assign)CGRect textFrame;

/** 自己的frame */
@property(nonatomic,assign)CGRect frame;

/** 转发微博的数据 */
@property(nonatomic,strong)MBStatus  *retweetedStatus;

/** 配图相册  */
@property(nonatomic,assign)CGRect photosFrame;

@end
