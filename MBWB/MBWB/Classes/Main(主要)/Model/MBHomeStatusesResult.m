//
//  MBHomeStatusesResult.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBHomeStatusesResult.h"
#import "MJExtension.h"
#import "MBStatus.h"

@implementation MBHomeStatusesResult

//- (NSDictionary *)objectClassInArray{
//    
//    return @{@"statuses":[MBStatus class]};
//}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"statuses":[MBStatus class]};
}
@end
