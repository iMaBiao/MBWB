//
//  NBStatusOriginalFrame.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBStatus;

@interface MBStatusOriginalFrame : NSObject
/** 昵称 */
@property(nonatomic,assign)CGRect nameFrame;
/** 正文 */
@property(nonatomic,assign)CGRect textFrame;
/** 头像 */
@property(nonatomic,assign)CGRect iconFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipFrame;

/** 自己的frame */
@property(nonatomic,assign)CGRect frame;


/** 微博数据 */
@property (nonatomic, strong) MBStatus *status;

/** 配图相册  */
@property(nonatomic,assign)CGRect photosFrame;

@end
