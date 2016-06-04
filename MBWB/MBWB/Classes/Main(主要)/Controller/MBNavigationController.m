//
//  MBNavigationController.m
//  MBWeiBo
//
//  Created by 浩渺 on 16/5/12.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBNavigationController.h"

@implementation MBNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  第一次使用这个类的使用调用一次
 */
+ (void)initialize{
    
    [self setNavigationBarTheme];
    
    [self setBarButtonItemTheme];
    
}

+ (void)setBarButtonItemTheme{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    highTextAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    //设置不可用状态的文字属性
    NSMutableDictionary *disabledTextAttrs = [NSMutableDictionary dictionary];
    disabledTextAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    disabledTextAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:disabledTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

}

+ (void)setNavigationBarTheme{

    UINavigationBar *appearance = [UINavigationBar appearance];
    
    if (iOS7) {
        [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:20];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigation_back" highImageName:@"navigation_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigation_more" highImageName:@"navigation_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:animated];
}


#warning 这里用的是self, 因为self就是当前正在使用的导航控制器
- (void)back{
    [self popViewControllerAnimated:YES];
}
- (void)more{
    [self popToRootViewControllerAnimated:YES];
}

@end
