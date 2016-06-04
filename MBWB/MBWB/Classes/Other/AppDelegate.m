//
//  AppDelegate.m
//  MBWB
//
//  Created by 浩渺 on 16/5/13.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "AppDelegate.h"
#import "MBTabBarViewController.h"
#import "MBNewFeatureController.h"
#import "MBOAuthController.h"
#import "MBAccount.h"
#import "MBAccountTool.h"
#import "MBChooseController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

static NSString *sApplicationShortcutUserInfoIconKey = @"applicationShortcutUserInfoIconKey";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UIApplication sharedApplication].statusBarHidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    
        
    // 2.设置窗口的根控制器
    MBAccount *account = [MBAccountTool account];
    if (account) {
        //有账号，有登录过
        [MBChooseController chooseRootViewController];
    }else{
        // 没有登录过
        self.window.rootViewController = [[MBOAuthController alloc]init];
    }
    
    
    //3DTouch
//    typedef NS_ENUM(NSInteger, UIApplicationShortcutIconType) {
//        UIApplicationShortcutIconTypeCompose, 编辑
//        UIApplicationShortcutIconTypePlay, 播放
//        UIApplicationShortcutIconTypePause, 暂停
//        UIApplicationShortcutIconTypeAdd,
//        UIApplicationShortcutIconTypeLocation,
//        UIApplicationShortcutIconTypeSearch,
//        UIApplicationShortcutIconTypeShare,
//        UIApplicationShortcutIconTypeProhibit       NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeContact        NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeHome           NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeMarkLocation   NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeFavorite       NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeLove           NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeCloud          NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeInvitation     NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeConfirmation   NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeMail           NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeMessage        NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeDate           NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeTime           NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeCapturePhoto   NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeCaptureVideo   NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeTask           NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeTaskCompleted  NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeAlarm          NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeBookmark       NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeShuffle        NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeAudio          NS_ENUM_AVAILABLE_IOS(9_1),
//        UIApplicationShortcutIconTypeUpdate         NS_ENUM_AVAILABLE_IOS(9_1)
//    }

//    // 添加3DTouch元素
//    application.shortcutItems =  @[item1, item2];

    UIApplicationShortcutItem *shortcutItem = [launchOptions objectForKey: UIApplicationLaunchOptionsShortcutItemKey];
    
    NSArray *shortcutItems = application.shortcutItems;
    
    if (shortcutItems.count == 0) {
        
        UIApplicationShortcutItem *shortcut3 = [[UIMutableApplicationShortcutItem alloc] initWithType:[self convertToType:@"Third"] localizedTitle:@"消息" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMessage] userInfo:@{sApplicationShortcutUserInfoIconKey:[NSNumber numberWithInt:UIApplicationShortcutIconTypeMessage]}];
        
        
        UIApplicationShortcutItem *shortcut4 = [[UIMutableApplicationShortcutItem alloc] initWithType:[self convertToType:@"Fourth"] localizedTitle:@"首页" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:@{sApplicationShortcutUserInfoIconKey:[NSNumber numberWithInt:UIApplicationShortcutIconTypeHome]}];
        
        application.shortcutItems = @[shortcut3, shortcut4];
    }
    return YES;
}



/**
 *  3DTouch时的事件处理
 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSString *tpye = shortcutItem.type;
    NSLog(@"shortcutItemType = %@",tpye);
   

    if ([tpye isEqualToString:@"com.haomiao.MBWB.Fourth"]) {
        // 处理相关逻辑
        NSLog(@"Home");
        [MBChooseController chooseTabBarController:0];

       
        completionHandler(YES);
    }else if ([tpye isEqualToString:@"com.haomiao.MBWB.Third"])
    {
        NSLog(@"Message");

        [MBChooseController chooseTabBarController:1];
        
        completionHandler(YES);
        
    }else if ([tpye isEqualToString:@"com.haomiao.MBWB.Second"])
    {
        NSLog(@"Search");
    
        [MBChooseController chooseTabBarController:2];
        
        completionHandler(YES);
        
    }else if ([tpye isEqualToString:@"com.haomiao.MBWB.First"])
    {
        NSLog(@"Contact");
        completionHandler(YES);
        [MBChooseController chooseTabBarController:3];
    }
    else
    {
        NSLog(@"未知");
        completionHandler(NO);
    }
}

/**
 *  拼接bundelIndertifier   com.haomiao.MBWB.Fourth
 */
-(NSString*)convertToType:(NSString*)shortcutIdentifier
{
    return [NSString stringWithFormat:@"%@.%@", [NSBundle mainBundle].bundleIdentifier,shortcutIdentifier];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
