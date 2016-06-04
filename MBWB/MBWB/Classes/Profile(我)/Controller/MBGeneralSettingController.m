//
//  MBGeneralSettingController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/26.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBGeneralSettingController.h"
#import "MBCommonItem.h"
#import "MBCommonGroup.h"
#import "MBCommonArrowItem.h"
#import "MBCommonLabelItem.h"
#import "MBCommonSwitchItem.h"


@interface MBGeneralSettingController ()

@end

@implementation MBGeneralSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setGroups];
}

- (void)setGroups{
    [self setGroup0];
    [self setGroup1];
    [self setGroup2];
}
- (void)setGroup0{
    MBCommonGroup *group = [MBCommonGroup group];
    [self.groups addObject:group];
    
    MBCommonLabelItem *readMode = [MBCommonLabelItem itemWithTitle:@"阅读模式"];
    readMode.text = @"有图模式";
    group.items = @[readMode];
}
- (void)setGroup1{
    
}

- (void)setGroup2{
    
}



@end
