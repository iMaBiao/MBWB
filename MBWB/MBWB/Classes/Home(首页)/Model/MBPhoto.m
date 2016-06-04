//
//  MBPhoto.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBPhoto.h"

@implementation MBPhoto


- (void)setThumbnail_pic:(NSString *)thumbnail_pic{
    
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
