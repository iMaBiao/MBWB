//
//  MBBaseTool.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBBaseTool.h"
#import "MJExtension.h"
#import "MBHttpTool.h"
@implementation MBBaseTool
+ (void)getWithUrl:(NSString *)url param:(id )param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure{
    NSDictionary *params = [param mj_keyValues];
    
    [MBHttpTool get:url params:params success:^(id responseObject) {
        
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObject];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)postWithUrl:(NSString *)url param:(id )param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure{
    
    NSDictionary *params = [param mj_keyValues];
    
    [MBHttpTool post:url params:params success:^(id responseObject) {
        
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObject];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
