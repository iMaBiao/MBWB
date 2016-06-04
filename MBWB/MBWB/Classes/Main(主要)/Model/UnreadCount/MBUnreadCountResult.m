//
//  MBUnreadCountResult.m
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBUnreadCountResult.h"

@implementation MBUnreadCountResult

- (int)messageCount{
    return  self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount{
    return self.messageCount + self.status + self.follwer;
}
@end
