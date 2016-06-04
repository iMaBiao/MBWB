//
//  MBCommonViewController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBCommonViewController.h"
#import "MBCommonCell.h"
#import "MBCommonGroup.h"
#import "MBCommonItem.h"
#import "MBCommonArrowItem.h"
#import "MBCommonLabelItem.h"
#import "MBCommonSwitchItem.h"

@interface MBCommonViewController ()
@property(nonatomic,strong)NSMutableArray *groups;
@end

@implementation MBCommonViewController
- (NSMutableArray *)groups{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}
/** 屏蔽tableView的样式 */
- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = MBColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = MBStatusCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(MBStatusCellMargin-35,0 , 0, 0);
    
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
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    MBCommonGroup *group = self.groups[section];
    return group.footer;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MBCommonGroup *group = self.groups[section];
    return group.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    取出这行对应的item模型
    MBCommonGroup *group = self.groups[indexPath.section];
    MBCommonItem *item = group.items[indexPath.row];
    
//    判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc =[[item.destVcClass alloc]init];
        destVc.title = item.title;
        destVc.view.backgroundColor = MBRandomColor;
        [self.navigationController pushViewController:destVc animated:YES];
    }
//    判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
    
}
@end
