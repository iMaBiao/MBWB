//
//  UIImage+Extension.h
//  MBWeiBo
//
//  Created by 浩渺 on 16/5/12.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名自动加载适配iOS6\7的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizeImage:(NSString *)name;


@end
