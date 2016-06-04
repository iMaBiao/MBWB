//
//  MBAuthenticationController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/27.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBAuthenticationController.h"
#import "MBAccountTool.h"
#import "MBAccount.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "MBTabBarViewController.h"

@interface MBAuthenticationController ()

@end

@implementation MBAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"unlock@2x"]];
    NSString *name = [MBAccountTool account].name;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.frame = CGRectMake(0, 80,self.view.width,44);
    [self.view addSubview:label];
    
    
    UIImageView *unlock = [[UIImageView alloc]init];
    unlock.image = [UIImage imageWithName:@"zhiwen.jpg"];
    unlock.width = 50;
    unlock.height = 75;
    unlock.centerX = self.view.width * 0.5 ;
    unlock.centerY = self.view.height * 0.5 - unlock.height;

    unlock.userInteractionEnabled =  YES;
    
    UITapGestureRecognizer *recognizer  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(unlockClick)];
    [unlock addGestureRecognizer:recognizer];
    unlock.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:unlock];
    //每次进来都默认点击了解锁按钮
    [self unlockClick];
}

/**
 *  指纹解锁
 */
- (void)unlockClick{
    //创建LAContext
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    NSString *result = @"通过Home键验证已有指纹";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                NSLog(@"指纹验证成功");
                
                MBTabBarViewController *viewController = [[MBTabBarViewController alloc]init];
//                //切换控制器
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = viewController;
                
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        //系统取消授权，如其他APP切入
                        NSLog(@"系统取消授权,如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        //用户取消验证Touch ID
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        //授权失败
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        //系统未设置密码
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        //设备Touch ID不可用，例如未打开
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        //设备Touch ID不可用，用户未录入
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        NSLog(@"%@",error.localizedDescription);
    }

}




@end
