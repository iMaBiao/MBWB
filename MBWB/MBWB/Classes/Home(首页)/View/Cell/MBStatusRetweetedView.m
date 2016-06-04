//
//  MBStatusRetweetedView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusRetweetedView.h"
#import "MBStatusRetweetedFrame.h"
#import "MBStatus.h"
#import "MBUser.h"
#import "MBStatusPhotosView.h"

@interface MBStatusRetweetedView ()
/**  昵称 */
@property(nonatomic,weak) UILabel *nameLabel;
/** 正文 */
@property(nonatomic,weak) UILabel *textLabel;
/** 配图相册 */
@property(nonatomic,weak)MBStatusPhotosView *photosView;
@end

@implementation MBStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImage:@"timeline_retweet_background"];
        
        /** 配图相册 */
        MBStatusPhotosView *photosView = [[MBStatusPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = MBColor(74, 102, 105);
        nameLabel.font = MBStatusRetweetedNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //正文
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = MBStatusRetweetedTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        

    }
    return self;
}

- (void)setRetweetedFrame:(MBStatusRetweetedFrame *)retweetedFrame{
    
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    MBStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
    MBUser *user = retweetedStatus.user;
    
    //昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    
    //正文
    self.textLabel.text = retweetedStatus.text;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    //配图相册
//    NSLog(@"retweetedStatus = %ld",retweetedStatus.pic_urls.count);
    
    if (retweetedStatus.pic_urls.count != 0) {
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls  = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
        
//        NSLog(@"retweetedStatus.photosFrame = %f",self.retweetedFrame.photosFrame.origin.y);
    }else{
        self.photosView.hidden = YES;
    }
}




@end
