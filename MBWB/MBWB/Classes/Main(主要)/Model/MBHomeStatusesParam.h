//
//  MBHomeStatusesParam.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//封装加载首页微博数据的请求参数

#import <Foundation/Foundation.h>
#import "MBBaseParam.h"
@interface MBHomeStatusesParam : MBBaseParam

///**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
//@property(nonatomic,copy)NSString *access_token;

/**	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
@property(nonatomic,strong)NSNumber *since_id;

/** false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
@property(nonatomic,strong)NSNumber *max_id;


/** false	int	单页返回的记录条数，最大不超过100，默认为20。*/
@property(nonatomic,strong)NSNumber *count;

@end
