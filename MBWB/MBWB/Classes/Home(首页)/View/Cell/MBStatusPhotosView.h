//
//  MBStatusPohotsView.h
//  MBWB
//
//  Created by 浩渺 on 16/5/19.
//  Copyright © 2016年 haomiao. All rights reserved.
//  微博cell里面的相册 -- 里面包含N个MBStatusPhotoView

#import <UIKit/UIKit.h>

@interface MBStatusPhotosView : UIView
/**
 *  图片数据（里面都是HMPhoto模型）
 */
@property(nonatomic,strong)NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
