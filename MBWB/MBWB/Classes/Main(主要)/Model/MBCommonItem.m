//
//  MBCommonItem.m
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBCommonItem.h"

@implementation MBCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    MBCommonItem *item = [[self alloc]init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

@end
