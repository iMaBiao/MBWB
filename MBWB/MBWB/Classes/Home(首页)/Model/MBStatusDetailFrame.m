//
//  MBStatusDetailFrame.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusDetailFrame.h"
#import "MBStatus.h"
#import "MBStatusRetweetedFrame.h"
#import "MBStatusOriginalFrame.h"

@implementation MBStatusDetailFrame

- (void)setStatus:(MBStatus *)status{
    
    _status = status;
    
    //计算原创status的frame
    MBStatusOriginalFrame *originalFrame = [[MBStatusOriginalFrame alloc]init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    //计算转发status的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        MBStatusRetweetedFrame *retweetedFrame = [[MBStatusRetweetedFrame alloc]init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        //计算转发status的frame的Y
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame  = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    }else{
        h = CGRectGetMaxY(originalFrame.frame);
    }
    //自己的frame
    CGFloat x  = 0;
    CGFloat y = MBStatusCellMargin;
    CGFloat w = theWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end
