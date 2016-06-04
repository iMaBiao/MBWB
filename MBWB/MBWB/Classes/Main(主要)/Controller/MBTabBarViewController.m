//
//  MBTabBarViewController.m
//  MBWeiBo
//
//  Created by 浩渺 on 16/5/12.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBTabBarViewController.h"
#import "MBHomeViewController.h"
#import "MBMessageViewController.h"
#import "MBDiscoverViewController.h"
#import "MBProfileViewController.h"
#import "MBNavigationController.h"
#import "MBTabBar.h"
#import "MBComposeController.h"

#import "MBUserTool.h"
#import "MBAccount.h"
#import "MBAccountTool.h"
#import "MBUnreadCountParam.h"

@interface MBTabBarViewController ()<MBTabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic,weak)MBHomeViewController *home;
@property(nonatomic,weak)MBMessageViewController *message;
@property(nonatomic,weak)MBProfileViewController *profile;
@property(nonatomic,weak)UIViewController *lastSelectedViewController;

@end

@implementation MBTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
      // 添加所有的子控制器
    [self addAllChildViewControllers];
    // 创建自定义tabbar
    [self addCustomTabBar];
    
    // 利用定时器获得用户的未读数
    NSTimer *timer  = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}
/**
 *  获取未读数的个数
 */
- (void)getUnreadCount{
    //请求参数
    MBUnreadCountParam *param = [MBUnreadCountParam param];
    param.uid = [MBAccountTool account].uid;
    //获取未读数
    [MBUserTool unreadCountWithParam:param success:^(MBUnreadCountResult *result) {
        //显示status未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        }else{
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        }
        //显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        }else{
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        }
        //显示follwer未读数
        if (result.follwer == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        }else{
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follwer];
        }
        
        //在图标上显示所有未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        NSLog(@"获取未读数失败--%@",error);
    }];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController{
    
    //选中的viewController就是UINavigationController
    UIViewController *VC = [viewController.viewControllers firstObject];
    if ([VC isKindOfClass:[MBHomeViewController class]]) {
        [self.home homeRefresh:YES];
    }else{
        [self.home homeRefresh:YES];
    }
    
    //设置选择的控制器
    self.lastSelectedViewController = VC;
    
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar{
     // 创建自定义tabbar
    MBTabBar *customTabBar = [[MBTabBar alloc]init];
    // 更换系统自带的tabbar(利用KVC的机制)
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    customTabBar.tabBardelegate = self;
}

#pragma mark MBTabBarDelegate 点击了加号按钮
- (void)tabBarDidClickPlusButton:(MBTabBar *)tabBar{
    
    //弹出Compose控制器
    MBComposeController *compose = [[MBComposeController alloc]init];
    MBNavigationController *nav = [[MBNavigationController alloc]initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildViewControllers{
    //添加子控制器
    MBHomeViewController *home = [[MBHomeViewController alloc]init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedViewController = home;
    
    MBMessageViewController *message = [[MBMessageViewController alloc]init];
    [self addOneChildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    MBDiscoverViewController *discover = [[MBDiscoverViewController alloc]init];
    [self addOneChildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    MBProfileViewController *profile = [[MBProfileViewController alloc]init];
    [self addOneChildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}
/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器
 *  @param title             子控制器标题
 *  @param imageName         子控制器图标
 *  @param selectedImageName 子控制器选中时图标
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
//    childVc.view.backgroundColor = MBRandomColor;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textArrts = [NSMutableDictionary dictionary];
    textArrts[UITextAttributeTextColor] = [UIColor blackColor];
    textArrts[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textArrts forState:UIControlStateNormal];
    
     // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextArrts = [NSMutableDictionary dictionary];
    selectedTextArrts[UITextAttributeTextColor] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextArrts forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    MBNavigationController *nav = [[MBNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
@end
