//
//  MBEmotion.h
//  MBWB
//
//  Created by 浩渺 on 16/5/20.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBEmotion : NSObject<NSCoding>
/** 表情的文字描述 */
@property(nonatomic,copy)NSString *chs;
/** 表情的文字描述 */
@property(nonatomic,copy)NSString *cht;

/** 表情的文png图片名 */
@property(nonatomic,copy)NSString *png;
/** emoji表情的编码 */
@property(nonatomic,copy)NSString *code;
/** emoji表情的字符 */
@property(nonatomic,copy)NSString *emoji;

/** 表情的存放文件夹\目录 */
@property(nonatomic,copy)NSString *directory;



@end
