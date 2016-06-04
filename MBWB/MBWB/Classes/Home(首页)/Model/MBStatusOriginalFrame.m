//
//  NBStatusOriginalFrame.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusOriginalFrame.h"
#import "MBStatus.h"
#import "MBUser.h"
#import "MBStatusPhotosView.h"

@implementation MBStatusOriginalFrame

- (void)setStatus:(MBStatus *)status{
    
    _status = status;
    
    //头像
    CGFloat iconX = MBStatusCellInset;
    CGFloat iconY = MBStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame)+ MBStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:MBStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //会员图标  计算会员图标的位置
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame)+MBStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    //正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame)+ MBStatusCellInset * 0.5;
    CGFloat maxW = theWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:MBStatusOrginalTextFont constrainedToSize:maxSize];
//    CGSize textSize = [status.attributedText boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX,textY},textSize};
    
    //配图相册
    CGFloat h = 0;//自己的高度
    if (status.pic_urls.count) {//有配图
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame)+MBStatusCellInset * 0.5;
//        int count = (int)status.pic_urls.count;
        CGSize photosSize = [MBStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame  = (CGRect){{photosX,photosY},photosSize};
        
//        NSLog(@"origin.photosFrame.y = %f",self.photosFrame.origin.y);
//        NSLog(@"origin.photosFrame.height = %f",self.photosFrame.size.height);
        
        h = CGRectGetMaxY(self.photosFrame)+ MBStatusCellInset;
    }else{
        h = CGRectGetMaxY(self.textFrame)+ MBStatusCellInset;
    }
    
    //自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = theWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end
