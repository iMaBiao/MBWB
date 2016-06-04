//
//  MBEmotionListView.m
//  MBWB
//
//  Created by 浩渺 on 16/5/20.
//  Copyright © 2016年 haomiao. All rights reserved.
//
#import "MBEmotionListView.h"
#import "MBEmotionGridView.h"

@interface MBEmotionListView()<UIScrollViewDelegate>
/** 显示所有表情的UIScrollView */
@property(nonatomic,weak)UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property(nonatomic,weak)UIPageControl *pageControl;

@end

@implementation MBEmotionListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        
         // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;

        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
         // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    // 设置总页数
    int totalPages = (emotions.count + MBEmotionMaxCountPerPage -1) / MBEmotionMaxCountPerPage;
    
    int currentGridViewCount = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = totalPages <= 1;
    
    // 决定scrollView显示多少页表情
    for (int i = 0; i < totalPages; i ++) {
        MBEmotionGridView *gridView = nil;
        if (i > currentGridViewCount) {
            //说明MBEmotionGridView的个数不够
            gridView = [[MBEmotionGridView alloc]init];
            [self.scrollView addSubview:gridView];
        }else{
            //说明MBEmotionGridView的个数足够，从self.scrollView.subViews中取出MBEmotionGridView
            gridView = self.scrollView.subviews[i];
        }
        
        //给MBEmotionGridView设置表情数据
        int loc = i * MBEmotionMaxCountPerPage;
        int len = MBEmotionMaxCountPerPage;
        
        if (loc + len > emotions.count) {
            //对越界进行判断处理
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionRange  = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionRange];
        gridView.emotions  = gridViewEmotions;
        gridView.hidden = NO;
    }
    
    //隐藏后面的不需要用到的gridView
    for (int i = totalPages ; i < currentGridViewCount; i++) {
        MBEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    //重新布局子控件
    [self setNeedsLayout];
    
    //表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y ;
    
    //设置UIScrollView的内部控件尺寸
    int count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    
    for (int i = 0; i < count; i++) {
        MBEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //四舍五入
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
