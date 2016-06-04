//
//  MBStatus.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatus.h"
//#import "MBUser.h"
#import "MJExtension.h"
#import "MBPhoto.h"
#import "NSDate+MB.h"

@implementation MBStatus

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"pic_urls":[MBPhoto class]};
}

- (void)setSource:(NSString *)source{
    if (source == @"") return;
    
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    //开始截取
    NSString *subSource = [source substringWithRange:range];
    
//    NSLog(@"subSource = %@",subSource);
    
    //头部拼接"来自"
    _source = [NSString stringWithFormat:@"来自%@",subSource];

}

- (NSString *)created_at{
    //    self->_created_at:
    //    Thu May 19 10:58:19 +0800 2016
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *createDate = [formatter dateFromString:_created_at];
    
//    NSLog(@"_created_at = %@",_created_at);
//    NSLog(@"createDate = %@",createDate);
    
    return @"刚刚";
//
//        if (createDate.isThisYear) {//今年
//            if (createDate.isToday) {//今天
//                NSDateComponents *components = [createDate deltaWithNow];
//                if (components.hour >=1) {//至少是1小时前发的
//                    return [NSString stringWithFormat:@"%ld小时前",components.hour];
//                }else if (components.minute >=1){//1~59分钟之前发的
//                    return [NSString stringWithFormat:@"%ld分钟前",components.minute];
//                }else{
//                    return @"刚刚";
//                }
//            }else if (createDate.isYesterday){//昨天
//                formatter.dateFormat = @"昨天 HH:mm";
//                return [formatter stringFromDate:createDate];
//            }else{//至少是前天
//                formatter.dateFormat = @"MM-dd HH:mm";
//                return [formatter stringFromDate:createDate];
//            }
//        }else{//非今年
//            formatter.dateFormat = @"yyy-MM-dd";
//            return [formatter stringFromDate:createDate];
//        }
}

@end
