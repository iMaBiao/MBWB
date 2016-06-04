//
//  MBStatusOriginalView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBStatusOriginalView.h"
#import "MBStatusOriginalFrame.h"
#import "MBStatus.h"
#import "MBUser.h"
#import "UIImageView+WebCache.h"
#import "MBStatusPhotosView.h"


@interface MBStatusOriginalView()
/** 昵称 */
@property(nonatomic,weak)UILabel *nameLabel;
/** 正文 */
@property(nonatomic,weak)UILabel *textLabel;
/** 来源 */
@property(nonatomic,weak)UILabel *sourceLabel;
/** 时间 */
@property(nonatomic,weak)UILabel *timeLabel;
/** 头像 */
@property(nonatomic,weak)UIImageView *iconView;

/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图相册 */
@property(nonatomic,weak)MBStatusPhotosView *photosView;

@end
@implementation MBStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    if (self) {
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = MBStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //正文
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = MBStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        //时间
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = MBStatusOrginalTimeFont;
        timeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:timeLabel];
        self.timeLabel  = timeLabel;
        
        //来源
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = MBStatusOrginalSourceFont;
        sourceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        //头像
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        //会员图标
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //配图相册
        MBStatusPhotosView *photosView = [[MBStatusPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
    }
    return self;
}
- (void)setOriginalFrame:(MBStatusOriginalFrame *)originalFrame{
    
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    // 取出微博数据
    MBStatus *status = originalFrame.status;
    // 取出用户数据
    MBUser *user = status.user;
    
    //昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    
    if (user.isVip) {//是会员
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    //正文
    self.textLabel.text = status.text;
    self.textLabel.frame = originalFrame.textFrame;
    
    //    时间
#warning 需要时刻根据现在的时间字符串来计算时间label的frame
    NSString *time = status.created_at;
    self.timeLabel.text = time;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame)+ MBStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:MBStatusOrginalTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    //    来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame)+ MBStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MBStatusOrginalSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //    头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    //配图相册
//    NSLog(@"originalFrame-status.pic_urls = %ld",status.pic_urls.count);
    
    if (status.pic_urls.count) {
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
//        NSLog(@"originalFrame--self.photosView.frame = %f",self.photosView.frame.origin.y);
    }else{
        self.photosView.hidden = YES;
    }
    
}

@end
