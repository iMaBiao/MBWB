//
//  MBChooseController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBChooseController.h"
#import "MBTabBarViewController.h"
#import "MBNewFeatureController.h"
#import "MBAuthenticationController.h"

@implementation MBChooseController

+(void)chooseRootViewController{
    
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) { // 当前版本号 == 上次使用的版本：显示MBTabBarViewController       //  MBAuthenticationController  指纹解锁页面
        window.rootViewController = [[MBTabBarViewController alloc] init];
        
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[MBNewFeatureController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }

}

+ (void)chooseTabBarController:(NSInteger)index{

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MBTabBarViewController *tabBarVC = [[MBTabBarViewController alloc]init];
        tabBarVC.selectedIndex  = index;
        window.rootViewController = tabBarVC;
        

}
@end
