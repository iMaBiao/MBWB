//
//  MBStatusFrame.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//


#import "MBStatusFrame.h"
#import "MBStatus.h"
#import "MBStatusDetailFrame.h"

@implementation MBStatusFrame

- (void)setStatus:(MBStatus *)status{
    _status = status;
    
    //计算status具体内容
    [self setDetailFrame];
    
    //计算底部工具条
    [self setToolBarFrame];
    
    //计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolBarFrame);
    
//    NSLog(@"cellHeight = %f\n",self.cellHeight);
}

/**
 *  计算status具体内容（微博整体）
 */
- (void)setDetailFrame{
    MBStatusDetailFrame *detailFrame = [[MBStatusDetailFrame alloc]init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
    
//    NSLog(@"detailFrame.y = %f",detailFrame.frame.origin.y);
//    NSLog(@"detailFrame.height = %f",detailFrame.frame.size.height);
}

/**
 *  计算底部工具条
 */
- (void)setToolBarFrame{
    
    CGFloat toolBarX = 0;

    CGFloat toolBarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolBarW = theWidth;
    CGFloat toolBarH = 35;
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW , toolBarH);
//    NSLog(@"toolBarY = %f",toolBarY);
    
    
}
@end
