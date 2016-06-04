//
//  MBTextView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/17.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBTextView.h"

@interface MBTextView()<UITextViewDelegate>
@property(nonatomic,weak)UILabel *placehoderLabel;
@end
@implementation MBTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel *placehoderLabel = [[UILabel alloc]init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        
        // 设置默认的占位文字颜色
        self.placehoderLabel.textColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
        // 当用户通过键盘修改了self的文字，self就会自动发出一个UITextViewTextDidChangeNotification通知
        // 一旦发出上面的通知，就会调用self的textDidChange方法
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange{
    self.placehoderLabel.hidden = (self.text.length != 0);
}
#pragma mark - 公共方法
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    
     // 设置文字
    self.placehoderLabel.text = placehoder;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
    
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placehoderLabel.font = font;
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placehoderLabel.y = 8;
    self.placehoderLabel.x = 5;
    self.placehoderLabel.width = self.width - 2* self.placehoderLabel.x;

    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width,MAXFLOAT);
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLabel.font constrainedToSize:maxSize];

//    CGRect placehoderRect = [self.placehoder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    
    self.placehoderLabel.height = placehoderSize.height;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
