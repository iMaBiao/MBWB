//
//  MBAccountTool.h
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  MBAccount;

@interface MBAccountTool : NSObject

/**
 *  存储账号
 */
+ (void)save:(MBAccount *)account;
/**
 *  读取账号
 */
+(MBAccount *)account;

@end
