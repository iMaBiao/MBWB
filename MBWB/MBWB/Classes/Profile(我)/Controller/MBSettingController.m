//
//  MBSettingController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/26.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBSettingController.h"

#import "MBCommonItem.h"
#import "MBCommonGroup.h"
#import "MBCommonArrowItem.h"
#import "MBCommonLabelItem.h"
#import "MBCommonSwitchItem.h"
#import "MBGeneralSettingController.h"

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@interface MBSettingController ()
@property(nonatomic,strong)MBCommonLabelItem *cache;

@end

@implementation MBSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self setGroups];
    
    [self setFooter];
}

- (void)setGroups{
    [self setGroup0];
    [self setGroup1];
    [self setGroup2];
}

- (void)setGroup0{
    MBCommonGroup *group = [MBCommonGroup group];
//    group.footer = @"tail";
    [self.groups addObject:group];
    
    MBCommonArrowItem *account= [MBCommonArrowItem itemWithTitle:@"账号管理"];
    MBCommonArrowItem *security= [MBCommonArrowItem itemWithTitle:@"账号安全"];
    
    group.items = @[account,security];
    
}

- (void)setGroup1{
    MBCommonGroup *group = [MBCommonGroup group];
//    group.header = @"header";
    [self.groups addObject:group];
    
    MBCommonArrowItem *notification= [MBCommonArrowItem itemWithTitle:@"通知"];
    
    MBCommonArrowItem *privary= [MBCommonArrowItem itemWithTitle:@"隐私"];
    
    MBCommonArrowItem *generalSetting = [MBCommonArrowItem itemWithTitle:@"通用设置"];
    generalSetting.destVcClass = [MBGeneralSettingController class];
    
    group.items = @[notification,privary,generalSetting];
}

- (void)setGroup2{
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonLabelItem *cache = [MBCommonLabelItem itemWithTitle:@"清理缓存"];
    self.cache = cache;
    //缓存大小
    double size = [[SDImageCache sharedImageCache]getSize]/1024;
    NSLog(@"siz = %f",size);
    
    if (size >= 1024) {
        cache.text = [NSString stringWithFormat:@"%.1fM",size/1024];
    }else if (size ==0){
        cache.text = @"";
    }else{
        cache.text = [NSString stringWithFormat:@"%.2fK",size];
    }
    
    MBCommonArrowItem *opinion= [MBCommonArrowItem itemWithTitle:@"意见反馈"];
    
    MBCommonArrowItem *about= [MBCommonArrowItem itemWithTitle:@"关于微博"];
    
    group.items = @[cache,opinion,about];
    
}
- (void)setFooter{
    UIButton *logout = [[UIButton alloc]init];
    
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [logout setTitleColor:MBColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage: [UIImage resizeImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    //设置尺寸
    logout.height = 44;
    self.tableView.tableFooterView = logout;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)clearCache{
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache cleanDisk];
    
    self.cache.text = @"0M";
}

- (void)logout{
    UIAlertController *logout = [UIAlertController alertControllerWithTitle:@"确定退出？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"退出登录");
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [logout addAction:alert];
    [logout addAction:cancel];
    [self presentViewController:logout animated:YES completion:nil];
    
}
@end
