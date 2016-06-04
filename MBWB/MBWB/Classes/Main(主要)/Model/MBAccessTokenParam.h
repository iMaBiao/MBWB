//
//  MBAccessTokenParam.h
//  MBWB
//
//  Created by 浩渺 on 16/5/18.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBAccessTokenParam : NSObject

/**	true	string	申请应用时分配的AppKey。*/
@property (nonatomic, copy) NSString *client_id;

/**		true	string	申请应用时分配的AppSecret。*/
@property(nonatomic,copy)NSString *client_secret;

/**		true	string	请求的类型，填写authorization_code*/
@property(nonatomic,copy)NSString *grant_type;

/**		true	string	调用authorize获得的code值。*/
@property(nonatomic,copy)NSString *code;

/**		true	string	回调地址，需需与注册应用里的回调地址一致。*/
@property(nonatomic,copy)NSString *redirect_uri;



@end
