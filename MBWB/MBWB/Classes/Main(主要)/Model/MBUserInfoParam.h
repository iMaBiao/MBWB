//
//  MBUserInfoParam.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBBaseParam.h"

@interface MBUserInfoParam : MBBaseParam

///**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
//@property(nonatomic,copy)NSString *access_token;

/** false	int64	需要查询的用户ID。*/
@property(nonatomic,copy)NSString *uid;

@end
