//
//  MBComposePhotosView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/17.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBComposePhotosView.h"

@implementation MBComposePhotosView

- (void)addImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    // 一行的最大列数
    int maxCloPerRow = 4;
    // 每个图片之间的间距
    CGFloat margin = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxCloPerRow + 1)*margin) / maxCloPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i= 0; i < count; i++) {
        int row = i % maxCloPerRow; //行号
        int col = i / maxCloPerRow; //列号
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height= imageViewH;
        imageView.x = (imageViewW + margin)*row + margin;
        imageView.y = (imageViewH + margin)*col ;
    }
    
}

- (NSArray *)images{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView];
    }
    return array;
}


@end
