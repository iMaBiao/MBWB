//
//  MBHomeViewController.m
//  MBWeiBo
//
//  Created by 浩渺 on 16/5/12.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBHomeViewController.h"
#import "MBTitleButton.h"
#import "MBPopMenu.h"

#import "MBAccountTool.h"
#import "MBAccount.h"
#import "UIImageView+WebCache.h"
#import "MBUser.h"
#import "MBStatus.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBHttpTool.h"
#import "MBStatusTool.h"
//#import "MBHomeStatusesResult.h"
//#import "MBHomeStatusesParam.h"
#import "MBUserTool.h"

#import "MBStatusCell.h"
#import "MBStatusFrame.h" 



@interface MBHomeViewController ()<MBPopMenuDelegate>

/***  微博数组(存放着所有的微博数据)*/
@property(nonatomic,strong)NSMutableArray *statusFrames;

@property(nonatomic,weak)MBTitleButton *titleButton;
@end

@implementation MBHomeViewController

- (NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIAlertController *logout = [UIAlertController alertControllerWithTitle:@"有新版本啦" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"前去更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"前去更新");
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"稍后再说");
//    }];
//    UIAlertAction *cancel1 = [UIAlertAction actionWithTitle:@"了解详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"了解详情");
//    }];
//    [logout addAction:alert];
//    [logout addAction:cancel];
//    [logout addAction:cancel1];
//    [self presentViewController:logout animated:YES completion:nil];
    
    self.tableView.backgroundColor = MBColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏按钮
    [self setNavigationBar];
    
    //集成刷新
    [self setRefresh];
    
    //获取用户信息
    [self setUserInfo];
    
}

/**
 *  获取用户信息
 */
- (void)setUserInfo{
    //    封装请求参数
    MBUserInfoParam *param = [MBUserInfoParam param];
    param.uid = [MBAccountTool account].uid;
   
    //发送请求
    [MBUserTool userInfoWithParam:param success:^(MBUserInfoResult *result) {
        
        // 设置用户的昵称为标题
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        
        // 存储帐号信息
        MBAccount *account = [MBAccountTool account];
        account.name = result.name;
        [MBAccountTool save:account];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败error= %@",error);
    }];
}

/**
 *  集成刷新
 */
- (void)setRefresh{
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshNewStatus];
    }];
    
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreStatuses];
    }];
 
    //一进来就刷新一次
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark 刷新

- (void)homeRefresh:(BOOL)fromSelf{
    if (self.tabBarItem.badgeValue) {//有数字
        //开始刷新
        [self.tableView.mj_header beginRefreshing];
        //刷新数据
        [self refreshNewStatus];
        
        
    }else if(fromSelf){//没有数字
        // 让表格回到最顶部
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

/**
 *  上拉加载更多数据
 */
- (void)loadMoreStatuses{

//    1、封装请求参数
    MBHomeStatusesParam *param = [[MBHomeStatusesParam alloc]init];
    MBStatusFrame *lastStatusFrame  = [self.statusFrames lastObject];
    MBStatus *lastStatus = lastStatusFrame.status;
    
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    //2、加载status数据
    [MBStatusTool homeStatusesWithParma:param success:^(MBHomeStatusesResult *result) {
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        [self.statusFrames addObjectsFromArray:newFrames];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

/**
 *  下拉加载刷新最新数据
 */
- (void)refreshNewStatus{

    //    1、封装请求参数
    MBHomeStatusesParam *param = [[MBHomeStatusesParam alloc]init];
    MBStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    MBStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    //2、加载status数据
    [MBStatusTool homeStatusesWithParma:param success:^(MBHomeStatusesResult *result) {
        // 获得最新的微博frame数组

        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        //将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusCount:newFrames.count];
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}
/**
 *  根据微博模型数组 转成 微博frame模型数据
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses{
    
    NSMutableArray *frames = [NSMutableArray array];
    for (MBStatus *status in statuses) {
        MBStatusFrame *frame = [[MBStatusFrame alloc]init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}
/**
 *  提示用户最新的微博数量
 *  @param count 最新的微博数量
 */
- (void)showNewStatusCount:(NSInteger)count{
    
//    清零提醒数字
    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.intValue;
    self.tabBarItem.badgeValue = nil;
    
    //创建显示的UILabel
    UILabel *label = [[UILabel alloc]init];
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%ld条新的数据",count];
    }else{
        label.text = @"没有新的数据";
    }
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    //设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
//    添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //添加动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:delay animations:^{
           // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            
        }completion:^(BOOL finished) {
            //删除控件
            [label removeFromSuperview];
        }];
    }];
}



/**
 *  设置导航栏按钮
 */
- (void)setNavigationBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 设置导航栏中间的标题按钮
    MBTitleButton *titleButton = [[MBTitleButton alloc]init];

    // 设置图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 设置背景
    [titleButton setBackgroundImage:[UIImage imageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    titleButton.width = 180;
    titleButton.height = 35;
    
    //设置文字
    NSString *name = [MBAccountTool account].name;
    
    [titleButton setTitle: name ? name : @"首页" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //监听按钮点击
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}

/**
 *  点击了标题按钮
 */
- (void)titleButtonClick:(UIButton *)titleButton{
    //换成向上的箭头
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    //弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    
    MBPopMenu *menu = [MBPopMenu popWithContentView:button];
    [menu showInRect:CGRectMake(150, 60, 100, 100)];
    menu.arrowPosition = MBPopMenuArrowPositionLeft;
    menu.dimBackground = YES;
    menu.delegate = self;
}

#pragma mark - MBPopMenuDelegate弹出菜单协议
- (void)popMenuDidDismissed:(MBPopMenu *)popMenu{
    MBTitleButton *titleButton =  (MBTitleButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}


/**
 *  点击了遮盖
 */
- (void)coverClick{
    NSLog(@"coverClick");
}
- (void)friendSearch{
    NSLog(@"MBHomeViewController-----friendSearch");
}
- (void)pop{
    NSLog(@"MBHomeViewController ----- pop");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBStatusCell *cell = [MBStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MBStatusFrame *frame  = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}
@end
