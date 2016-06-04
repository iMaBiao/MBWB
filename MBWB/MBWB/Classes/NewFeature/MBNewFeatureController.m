//
//  MBNewFeatureController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/14.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#define MBNewFeatureImageCount 4

#import "MBNewFeatureController.h"
#import "MBTabBarViewController.h"
@interface MBNewFeatureController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageControl;

@end

@implementation MBNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加ScrollView
    [self addScrollView];
    
    //添加pageControl
    [self addPageControl];
}

- (void)addScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i < MBNewFeatureImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        if (FourInch) {
            name  = [name stringByAppendingString:@"-568h"];
        }
        imageView.image = [UIImage imageWithName:name];
        [scrollView addSubview:imageView];
        
        //设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 给最后一个imageView添加按钮
        if (i == MBNewFeatureImageCount-1) {
            [self setLastImageView:imageView];
        }
    }
    
    //设置其他属性
    scrollView.contentSize = CGSizeMake(MBNewFeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = MBColor(246,246,256);
    
}

/**
 设置最后一个UIImageView中的内容
 */
- (void)setLastImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    //添加开始按钮
    [self addStartButton:imageView];
    //添加分享按钮
    [self addShareButton:imageView];
}
/**
 *  添加开始按钮在imageView上
 */
- (void)addStartButton:(UIImageView *)imageView{
    UIButton *startButton  = [[UIButton alloc]init];
    [imageView addSubview:startButton];
    
    //设置背景图片
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    //设置frame
    startButton.size =  startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.8;
    
    //设置文字
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

- (void)start{
    
    MBTabBarViewController *viewController = [[MBTabBarViewController alloc]init];
    //切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = viewController;
}
/**
 *   添加开始按钮在imageView上
 */
- (void)addShareButton:(UIImageView *)imageView{
    UIButton *shareButton = [[UIButton alloc]init];
    [imageView addSubview:shareButton];
    
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
    
    //设置间距
    shareButton.titleEdgeInsets  = UIEdgeInsetsMake(0, 10, 0, 0);
}
- (void)share:(UIButton *)Button{
    Button.selected = !Button.isSelected;
}

/**
 *  添加pageControl
 */
- (void)addPageControl{
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = MBNewFeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height -30;
    [self.view addSubview:pageControl];

     // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = MBColor(253,98,42);
    pageControl.pageIndicatorTintColor = MBColor(189,189,189);
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    //四舍五入
    int intpage = (int)(doublePage+ 0.5);
    
    //设置页码
    self.pageControl.currentPage = intpage;
}


@end
