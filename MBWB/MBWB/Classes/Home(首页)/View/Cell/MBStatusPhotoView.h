//
//  MBStatusPhotoView.h
//  MBWB
//
//  Created by 浩渺 on 16/5/19.
//  Copyright © 2016年 haomiao. All rights reserved.
//一个HMStatusPhotoView代表1张配图

#import <UIKit/UIKit.h>
@class MBPhoto;
@interface MBStatusPhotoView : UIImageView

@property(nonatomic,strong)MBPhoto *photo;
@end
