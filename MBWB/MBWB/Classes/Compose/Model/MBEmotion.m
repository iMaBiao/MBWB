//
//  MBEmotion.m
//  MBWB
//
//  Created by 浩渺 on 16/5/20.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBEmotion.h"
#import "NSString+Emoji.h"
@implementation MBEmotion

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ - %@ - %@",self.chs,self.png,self.code];
}

- (void)setCode:(NSString *)code{
    _code = [code copy ];
    if (code == nil) return;
    
    self.emoji = [NSString emojiWithStringCode:code];
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
    }
    return self;
}
/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.directory forKey:@"directory"];
}

- (BOOL)isEqual:(MBEmotion *)object{
    
    if (self.code) {       //emoji表情
        return [self.code isEqualToString:object.code];
        
    }else{                  //图片表情
        return [self.png isEqualToString:object.png]&&[self.chs isEqualToString:object.chs];
    }
}
@end
