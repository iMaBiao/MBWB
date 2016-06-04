//
//  MBAccountTool.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#define  MBAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account.data"]

#import "MBAccountTool.h"
#import "MBAccount.h"
@implementation MBAccountTool

/**
 *  存储账号
 */
+ (void)save:(MBAccount *)account{
    //归档
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:MBAccountFilePath];
}
/**
 *  读取账号
 */
+(MBAccount *)account{
    MBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:MBAccountFilePath];
    
     // 判断帐号是否已经过期
    NSDate *now = [NSDate date];
    if ([now compare:account.remind_in] != NSOrderedAscending ) {  //不是升序 - 过期
        account = nil;
    }
    return  account;
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */
@end
