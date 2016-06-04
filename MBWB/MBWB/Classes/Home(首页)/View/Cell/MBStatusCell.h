//
//  MBStatusCell.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//微博cell

#import <UIKit/UIKit.h>

@class MBStatusFrame;

@interface MBStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)MBStatusFrame *statusFrame;

@end
