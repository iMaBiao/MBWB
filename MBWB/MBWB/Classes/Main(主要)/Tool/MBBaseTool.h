//
//  MBBaseTool.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//  最基本的业务工具类

#import <Foundation/Foundation.h>

@interface MBBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id )param resultClass:(Class)resultClass success:(void(^)(id ))success failure:(void(^)(NSError *))failure;


+ (void)postWithUrl:(NSString *)url param:(id )param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure;


@end
