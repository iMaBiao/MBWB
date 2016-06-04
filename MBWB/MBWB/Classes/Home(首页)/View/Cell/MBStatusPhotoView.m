//
//  MBStatusPhotoView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/19.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusPhotoView.h"
#import "MBPhoto.h"
#import "UIImageView+WebCache.h"

@interface MBStatusPhotoView()

@property(nonatomic,weak)UIImageView *gifView;

@end

@implementation MBStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        //添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(MBPhoto *)photo{
    
    _photo = photo;
    
    //下载图片
//    NSString *s  = @"http://ww3.sinaimg.cn/thumbnail/ad283b20gw1f40uygf9naj20hq0hdgqy.jpg";

    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];


    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height- self.gifView.height;
    
}
@end
