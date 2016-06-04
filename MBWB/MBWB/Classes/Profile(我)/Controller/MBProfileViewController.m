//
//  MBProfileViewController.m
//  MBWeiBo
//
//  Created by 浩渺 on 16/5/12.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBProfileViewController.h"

#import "MBCommonCell.h"
#import "MBCommonItem.h"
#import "MBCommonGroup.h"
#import "MBCommonArrowItem.h"
#import "MBCommonLabelItem.h"
#import "MBCommonSwitchItem.h"
#import "MBSettingController.h"

@interface MBProfileViewController ()

@end

@implementation MBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"我";
    
    [self setGroups];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
  
}
- (void)setting{
    NSLog(@"MBProfileViewController-----setting");
    MBSettingController *setting = [[MBSettingController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)setGroups{
    [self setGroup0];
    [self setGroup1];
    [self setGroup2];
    [self setGroup3];
}

- (void)setGroup0{
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonArrowItem *newFriend  = [MBCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"5";
    
    MBCommonArrowItem *level= [MBCommonArrowItem itemWithTitle:@"微博等级" icon:@"new_friend"];
    level.subtitle = @"连续登录35天";
    group.items = @[newFriend,level];
}

- (void)setGroup1{
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonArrowItem *album = [MBCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    
    MBCommonArrowItem *collect  = [MBCommonArrowItem itemWithTitle:@"我的点评" icon:@"collect"];
    collect.subtitle = @"(10)";
    collect.badgeValue = @"2";
    
    MBCommonArrowItem *like = [MBCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    like.badgeValue = @"666";
    
    group.items = @[album,collect,like];
}
- (void)setGroup2{
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonArrowItem *pay = [MBCommonArrowItem itemWithTitle:@"微博支付" icon:@"album"];
    pay.subtitle = @"积分好礼换不停";
    
    MBCommonArrowItem *sport = [MBCommonArrowItem itemWithTitle:@"运动" icon:@"like"];
    sport.subtitle = @"奔跑2016搬到这里啦";
    
    group.items = @[pay,sport];

}
- (void)setGroup3{
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonArrowItem *fans = [MBCommonArrowItem itemWithTitle:@"粉丝头条" icon:@"album"];
    fans .subtitle = @"推广博文及账号的利器";
    
    MBCommonArrowItem *fansService = [MBCommonArrowItem itemWithTitle:@"粉丝服务" icon:@"like"];
    fansService.subtitle = @"橱窗、私信、营销、数据中心";
    
    group.items = @[fans,fansService];
}

@end
