//
//  MBStatusDetailFrame.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBStatus,MBStatusOriginalFrame,MBStatusRetweetedFrame;

@interface MBStatusDetailFrame : NSObject

@property(nonatomic,strong)MBStatusOriginalFrame *originalFrame;
@property(nonatomic,strong)MBStatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property(nonatomic,strong)MBStatus  *status;

/**自己的frame*/
@property(nonatomic,assign)CGRect frame;

@end
