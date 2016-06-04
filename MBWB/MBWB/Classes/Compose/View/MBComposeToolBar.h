//
//  MBComposeToolBar.h
//  MBWB
//
//  Created by 浩渺 on 16/5/17.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    MBComposeToolBarButtonTypeCamera,   //照相机
    MBComposeToolBarButtonTypePicture,  //相册
    MBComposeToolBarButtonTypeMention,  //提到的@
    MBComposeToolBarButtonTypeTrend,    //话题
    MBComposeToolBarButtonTypeEmotion   //表情
    
}MBComposeToolBarButtonType;

@class MBComposeToolBar;
@protocol MBComposeToolBarDelegate <NSObject>

@optional
- (void)composeTool:(MBComposeToolBar *)toolBar didClickButton:(MBComposeToolBarButtonType)buttonType;
@end

@interface MBComposeToolBar : UIView
@property(nonatomic,weak)id<MBComposeToolBarDelegate> delegate;


/**
 *  是否要显示表情按钮
 */
@property(nonatomic,assign,getter=isShowEmotionButton)BOOL showEmotionButton;
@end
