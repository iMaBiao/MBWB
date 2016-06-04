//
//  MBTabBar.h
//  MBWB
//
//  Created by 浩渺 on 16/5/14.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBTabBar;
@protocol MBTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickPlusButton:(MBTabBar *)tabBar;

@end

@interface MBTabBar : UITabBar
@property(nonatomic,weak)id<MBTabBarDelegate> tabBardelegate;

@end
