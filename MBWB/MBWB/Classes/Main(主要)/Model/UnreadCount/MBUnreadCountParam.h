//
//  MBUnreadCountParam.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBBaseParam.h"

@interface MBUnreadCountParam : MBBaseParam
/** false	int64	需要查询的用户ID。*/
@property(nonatomic,copy) NSString *uid;

@end
