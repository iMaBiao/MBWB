//
//  MBComposePhotosView.h
//  MBWB
//
//  Created by 浩渺 on 16/5/17.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBComposePhotosView : UIView

/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)images;

@end
