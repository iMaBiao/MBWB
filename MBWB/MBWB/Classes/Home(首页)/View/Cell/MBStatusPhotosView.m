//
//  MBStatusPohotsView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/19.
//  Copyright © 2016年 haomiao. All rights reserved.
//
#define MBStatusPhotosMaxCount 9
#define MBStatusPhotoW 100
#define MBStatusPhotoMargin 10
//最大列数（有四张图片就两行，不然就三行）
#define MBStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)

#import "MBStatusPhotosView.h"
#import "MBStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "MBPhoto.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation MBStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        // 预先创建9个图片控件
        for (int i =0; i <MBStatusPhotosMaxCount; i ++) {
            MBStatusPhotoView *photoView = [[MBStatusPhotoView alloc]init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}
/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer{
    
    // 1.创建图片浏览器
    MJPhotoBrowser *browser  = [[MJPhotoBrowser alloc]init];
    
    //    设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    
    int count = (int)self.pic_urls.count;
    
    for (int i=0; i < count ; i ++) {
        
        MBPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc]init];
        
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
//    设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
//    显示浏览器
    [browser show];
    
}


- (void)setPic_urls:(NSArray *)pic_urls{
    
    _pic_urls = pic_urls;
    
    for (int i = 0; i < MBStatusPhotosMaxCount; i++) {
        
        MBStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) {//显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.pic_urls.count;
    NSUInteger maxCols = MBStatusPhotosMaxCols(count);
    
    for (int i =0; i < count; i ++) {
        
        MBStatusPhotoView *photoView = self.subviews[i];
        photoView.width = MBStatusPhotoW;
        photoView.height = MBStatusPhotoW;
        photoView.x = (i % maxCols) * (MBStatusPhotoW + MBStatusPhotoMargin * 2);
        photoView.y = (i / maxCols) * (MBStatusPhotoW + MBStatusPhotoMargin);
    }
}

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount{
    
    // 一行最多几列
    int maxCol = MBStatusPhotosMaxCols(photosCount);
    
    // 总列数(超过3张就按3列算)
    int totalCol = photosCount >= maxCol ? maxCol : photosCount;
    
    // 总行数
    int totalRow = (photosCount + maxCol -1) / maxCol;
    
    // 计算尺寸
    CGFloat photosW = totalCol * MBStatusPhotoW + (totalCol -1)*MBStatusPhotoMargin;
    CGFloat photosH = totalRow * MBStatusPhotoW + (totalRow -1)*MBStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    
}
@end
