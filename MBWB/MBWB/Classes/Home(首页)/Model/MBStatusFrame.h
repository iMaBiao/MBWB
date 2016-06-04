//
//  MBStatusFrame.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
// 一个frame包括一个cell内部所有子控件的fame数据和显示数据

#import <Foundation/Foundation.h>

@class MBStatusDetailFrame, MBStatus;

@interface MBStatusFrame : NSObject

/** 子控件的frame数据 */
@property(nonatomic,assign)CGRect toolBarFrame;

@property(nonatomic,strong)MBStatusDetailFrame *detailFrame;

/** cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

/** 微博数据 */
@property(nonatomic,strong)MBStatus *status;
@end
