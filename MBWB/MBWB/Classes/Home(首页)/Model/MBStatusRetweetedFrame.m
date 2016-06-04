//
//  MBStatusRetweetedFrame.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusRetweetedFrame.h"
#import "MBStatus.h"
#import "MBUser.h"
#import "MBStatusPhotosView.h"

@implementation MBStatusRetweetedFrame

- (void)setRetweetedStatus:(MBStatus *)retweetedStatus{
    _retweetedStatus = retweetedStatus;
    
    //昵称
    CGFloat nameX = MBStatusCellInset;
    CGFloat nameY = MBStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@",retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:MBStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX = MBStatusCellInset;
    CGFloat textY = CGRectGetMaxY(self.nameFrame)+ MBStatusCellInset * 0.5;
    CGFloat maxW = theWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize  = [retweetedStatus.text sizeWithFont:MBStatusRetweetedTextFont constrainedToSize:maxSize];
//    CGSize textSize  = [retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX,textY},textSize};
    
    //配图相册
    CGFloat h = 0;
    
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame)+ MBStatusCellInset * 0.5;
        CGSize photosSize = [MBStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        
        self.photosFrame = (CGRect){{photosX, photosY},photosSize};
        
//        NSLog(@"retweetedStatus.photosFrame.y = %f",self.photosFrame.origin.y);
//        NSLog(@"retweetedStatus.photosFrame.height = %f",self.photosFrame.size.height);
        
        h = CGRectGetMaxY(self.photosFrame) + MBStatusCellInset;
    }else{
        h = CGRectGetMaxY(self.textFrame)+ MBStatusCellInset;
    }
    
    
    //自己
    CGFloat x = 0 ;
    CGFloat y = 0;
    CGFloat w = theWidth;
    self.frame = CGRectMake(x, y ,  w , h );
}
@end
