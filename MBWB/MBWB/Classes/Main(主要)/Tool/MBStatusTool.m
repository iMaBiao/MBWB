//
//  MBStatusTool.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusTool.h"
#import "MJExtension.h"
#import "MBHttpTool.h"
@implementation MBStatusTool

+ (void)homeStatusesWithParma:(MBHomeStatusesParam *)param success:(void (^)(MBHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure{
   
    NSDictionary *params = param.mj_keyValues;
    
    [MBHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObject) {
     
        if (success) {
            MBHomeStatusesResult *results = [MBHomeStatusesResult mj_objectWithKeyValues:responseObject];
            success(results);
        }
    } failure:^(NSError *error) {
     
        if (failure) {
            failure(error);
        }
    }];
}

@end
