//
//  MBAccount.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBAccount.h"

@implementation MBAccount

+ (instancetype)accountWithDict:(NSDictionary *)dictionary{
    MBAccount *account = [[self alloc]init];
    account.access_token = dictionary[@"access_token"];
    account.expires_in = dictionary[@"expires_in"];
    account.uid = dictionary[@"uid"];
    
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.remind_in = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@""];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
