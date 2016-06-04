//
//  MBBaseParam.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBBaseParam.h"
#import "MBAccountTool.h"
#import "MBAccount.h"
@implementation MBBaseParam

- (instancetype)init{
    if (self = [super init]) {
        self.access_token = [MBAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param{
    return  [[self alloc]init];
}
@end
