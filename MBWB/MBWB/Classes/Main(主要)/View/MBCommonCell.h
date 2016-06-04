//
//  MBCommonCell.h
//  MBWB
//
//  Created by 浩渺 on 16/5/25.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBCommonItem;

@interface MBCommonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  cell对应的item数据
 */
@property(nonatomic,strong)MBCommonItem *item;

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;
@end
