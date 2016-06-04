//
//  MBUnreadCountResult.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBUnreadCountResult : NSObject
/**
 *  新status未读数
 */
@property(nonatomic,assign)int  status;

/**
 *  新粉丝数
 */
@property(nonatomic,assign)int follwer;

/**
 *  新评论数
 */
@property(nonatomic,assign)int cmt;

/**
 *  新私信数
 */
@property(nonatomic,assign)int  dm;

/**
 *  新提及我的微博数
 */
@property(nonatomic,assign)int mention_cmt;

/**
 *  新提及我的评论数
 */
@property(nonatomic,assign)int  mention_status;

/**
 *  消息未读数
 */
- (int)messageCount;

/**
 *  所有未读数
 */
- (int)totalCount;
@end
