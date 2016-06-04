//
//  MBDiscoverViewController.m
//  MBWeiBo
//
//  Created by 浩渺 on 16/5/12.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBDiscoverViewController.h"
#import "MBSearchBar.h"
#import "MBCommonCell.h"
#import "MBCommonItem.h"
#import "MBCommonGroup.h"
#import "MBCommonArrowItem.h"
#import "MBCommonLabelItem.h"
#import "MBCommonSwitchItem.h"

@interface MBDiscoverViewController ()
//@property(nonatomic,strong)NSMutableArray *groups;

@end

@implementation MBDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBSearchBar *searchBar = [MBSearchBar searchBar];
    searchBar.width = 335;
    searchBar.height = 30;
    searchBar.placeholder = @"大家正在搜：10大手机支付习惯";
    searchBar.font = [UIFont systemFontOfSize:12];
    self.navigationItem.titleView = searchBar;
    
    //初始化模型数据
    [self setGroups];
}
/**
 *  初始化模型数据
 */
- (void)setGroups{
    [self setGroup0];
    [self setGroup1];
    [self setGroup2];
}
- (void)setGroup0{
    //创建组
    MBCommonGroup  *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    //设置组的基本数据
    group.header = @"the zero group header";
    group.footer = @"the zero group footer";
    
    //设置组的所有行数据
    MBCommonArrowItem *hotStatus = [MBCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"全站最热微博尽搜喽";
    hotStatus.destVcClass = [UIViewController class];
    hotStatus.hiddenArrow = YES;
    MBCommonArrowItem *findPeople = [MBCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    findPeople.hiddenArrow = YES;
//    findPeople.badgeValue = @"N";
    
    findPeople.destVcClass = [UIViewController class];
    
    group.items = @[hotStatus,findPeople];
    
}
- (void)setGroup1{
    //创建组
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonArrowItem *webHoter = [MBCommonArrowItem itemWithTitle:@"530网络红人节" icon:@"hot_status"];
    webHoter.subtitle = @"直播.爆款.造星，530狂欢不打烊";
    webHoter.hiddenArrow = YES;
    
    //设置组的所有行数据
    MBCommonItem *gameCenter = [MBCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.destVcClass  = [UIViewController class];
    
     MBCommonLabelItem *near = [MBCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.destVcClass = [UIViewController class];
    near.text = @"This is a test text";
    
//     MBCommonSwitchItem *app = [MBCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
//    app.destVcClass  = [UIViewController class];
//    app.badgeValue = @"10";

    group.items = @[webHoter,gameCenter,near];
    
}
- (void)setGroup2{
    //创建组
    MBCommonGroup  *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    //设置组的所有行数据
    MBCommonArrowItem *suishoupai = [MBCommonArrowItem itemWithTitle:@"随手拍" icon:@"hot_status"];
    suishoupai.subtitle = @"网红征集令>>发照片/视频,赢奖金";
    suishoupai.hiddenArrow = YES;
    
    MBCommonArrowItem *ticket = [MBCommonArrowItem itemWithTitle:@"股票" icon:@"hot_status"];
    ticket.subtitle = @"直播解盘让你在股市赚翻";
    ticket.hiddenArrow = YES;
    
    MBCommonArrowItem *movie = [MBCommonArrowItem itemWithTitle:@"电影" icon:@"movie"];
    movie.subtitle = @"优惠电影票就在这里";
    movie.hiddenArrow = YES;
    
    MBCommonArrowItem *redMan = [MBCommonArrowItem itemWithTitle:@"红人淘" icon:@"movie"];
    redMan.subtitle = @"5.23-5.27，女神压箱好货限时抢";
    redMan.hiddenArrow = YES;
    
    MBCommonArrowItem *zhibo = [MBCommonArrowItem itemWithTitle:@"直播" icon:@"video"];
    zhibo.subtitle = @"女神明星视频直播中";
    zhibo.hiddenArrow = YES;
    
    MBCommonArrowItem *toutiao = [MBCommonArrowItem itemWithTitle:@"微博头条" icon:@"video"];
    toutiao.subtitle = @"随时随地一起看新闻";
    toutiao.hiddenArrow = YES;
    
    MBCommonArrowItem *more = [MBCommonArrowItem itemWithTitle:@"更多频道" icon:@"more"];
    more.hiddenArrow = YES;
    group.items = @[suishoupai,ticket,movie,redMan,zhibo,toutiao,more];
//    MBCommonSwitchItem *video = [MBCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
//    video.operation = ^{
//        NSLog(@"video");
//    };
//    MBCommonSwitchItem *music = [MBCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
//    
//    MBCommonItem *movie = [MBCommonItem itemWithTitle:@"电影" icon:@"movie"];
//    movie.operation = ^{
//        NSLog(@"movie");
//    };
//    
//    MBCommonLabelItem *cast = [MBCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
//    cast.operation = ^{
//        NSLog(@"cast");
//    };
//    cast.badgeValue = @"5";
//    cast.subtitle = @"(10)";
//    cast.text = @"abcdefg";
//    
//    MBCommonItem *more = [MBCommonItem itemWithTitle:@"更多" icon:@"more"];
//    group.items = @[video,music,movie,cast,more];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    MBCommonGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    MBCommonCell *cell = [MBCommonCell cellWithTableView:tableView];
    
    MBCommonGroup *group = self.groups[indexPath.section];
    
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    NSLog(@"groups.items.count = %ld",group.items.count);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
