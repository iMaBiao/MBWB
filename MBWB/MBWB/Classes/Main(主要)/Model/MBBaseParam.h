//
//  MBBaseParam.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBaseParam : NSObject
/**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property(nonatomic,copy)NSString *access_token;

+ (instancetype)param;

@end
