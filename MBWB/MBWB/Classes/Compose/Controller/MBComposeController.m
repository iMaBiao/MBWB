//
//  MBComposeController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/14.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBComposeController.h"
#import "MBTextView.h"
#import "MBComposeToolBar.h"
#import "MBComposePhotosView.h"

#import "MBAccountTool.h"
#import "MBAccount.h"
#import "MBProgressHUD.h"
#import "MBHttpTool.h"

#import "MBProgressHUD.h"
#import "MBStatusTool.h"
#import "MBEmotionKeyboard.h"
#import "MBEmotion.h"
#import "MBEmotionTextView.h"

@interface MBComposeController ()<MBComposeToolBarDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,weak)MBEmotionTextView *textView;
@property(nonatomic,weak)MBComposeToolBar *toolBar;
@property(nonatomic,weak)MBComposePhotosView *photosView;
@property(nonatomic,strong)MBEmotionKeyboard *keyboard;
/** *  是否正在切换键盘*/
@property(nonatomic,assign,getter=isChangingKeyboard)BOOL changingKeyboard;

@end

@implementation MBComposeController

- (MBEmotionKeyboard *)keyboard{
    if (!_keyboard) {
        self.keyboard = [MBEmotionKeyboard keyboard];
        self.keyboard.width = theWidth;
        self.keyboard.height = 258;
    }
    return _keyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"compose Status";
    
    // 设置导航条内容
    [self setNavigationBar];
    
    //设置输入控件
    [self setTextView];
    
    // 添加工具条
    [self setToolBar];
    
    // 添加显示图片的相册控件
    [self setPhotosView];
    
}

/**
 *  添加显示图片的相册控件
 */
- (void)setPhotosView{
    MBComposePhotosView *photosView = [[MBComposePhotosView alloc]init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  添加工具条
 */
- (void)setToolBar{
    MBComposeToolBar *toolBar = [[MBComposeToolBar alloc]init];
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.delegate = self;
    self.toolBar = toolBar;
    
    //显示
//    self.textView.inputAccessoryView = toolBar;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
}

#pragma mark MBComposeToolBarDelegate -- 监听toolbar内部按钮的点击
- (void)composeTool:(MBComposeToolBar *)toolBar didClickButton:(MBComposeToolBarButtonType)buttonType{
    switch (buttonType) {
        case MBComposeToolBarButtonTypeCamera:
            NSLog(@"MBComposeToolBarButtonTypeCamera");
            [self openCamera];
            break;
            
        case MBComposeToolBarButtonTypePicture:
            NSLog(@"MBComposeToolBarButtonTypePicture");
            [self openAlbum];
            break;
            
        case MBComposeToolBarButtonTypeEmotion:
            NSLog(@"MBComposeToolBarButtonTypeEmotion");
            [self openEmotion];
            break;
            
        default:
            break;
    }
}
/**
 *  打来照相机
 */
- (void)openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return;
    }
    UIImagePickerController *pickController = [[UIImagePickerController alloc]init];
    pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickController.delegate = self;
    [self presentViewController:pickController animated:YES completion:nil];
    
}
/**
 *  打开相册
 */
- (void)openAlbum{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        return;
    }
    UIImagePickerController *pickController = [[UIImagePickerController alloc]init];
    pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickController.delegate = self;
    [self presentViewController:pickController animated:YES completion:nil];
}
/**
 *  打开Emotion
 */
- (void)openEmotion{
//    NSLog(@"openEmotion");
    
    // 正在切换键盘
    self.changingKeyboard = YES;
    
    if (self.textView.inputView) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textView.inputView  = nil;
        // 显示表情图片
        self.toolBar.showEmotionButton = YES;
    }else{// 当前显示的是系统自带的键盘，切换为自定义键盘
         // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textView.inputView = self.keyboard;
         // 不显示表情图片
        self.toolBar.showEmotionButton = NO;
    }
    //关闭键盘
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //打开键盘
        [self.textView becomeFirstResponder];
    });
}

/**
 *  当选中表情的时候调用
 */
- (void)emotionDidSelected:(NSNotification *)note{
    MBEmotion *emotion = note.userInfo[@"SelectedEmotion"];
    //拼接表情
    [self.textView appendEmotion:emotion];
    
    //检测文字长度
    [self textViewDidChange:self.textView];
}
/**
 *  当单击表情键盘的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    //往回删除
    [self.textView deleteBackward];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    添加图片到相册中
    [self.photosView addImage:image];
}

/**
 *  设置输入控件
 */
- (void)setTextView{
    MBTextView *textView = [[MBTextView alloc]init];
    textView.alwaysBounceVertical = YES;   // 垂直方向上拥有有弹簧效果
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
    
//    设置提醒文字（占位文字)
    textView.placehoder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
//    textView.placehoderColor = [UIColor ]
    
//    监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note{
//    键盘弹出需要的时间
//    NSLog(@"Hide ----note = %@",note);
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}
/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note{
//    NSLog(@"Show -- note = %@",note);
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
//view即将消失的时候也退出键盘
- (void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


/**
 *  设置导航条内容
 */
- (void)setNavigationBar{
    
    NSString *name = [MBAccountTool account].name;
    if (name) {
        //构建文字
        NSString *prefix = @"compose";
        NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:[text rangeOfString:name]];
        
        //创建label
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.title = @"compose";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"send" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send{
    if (self.photosView.images.count) {
//        发表有图片的status
        [self sendStatusWithImage];
    }else{
//        发表无图片的status
        [self sendStatusWithoutImage];
    }
//    关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  发表有图片的status
 */
- (void)sendStatusWithImage{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"access_token"] = [MBAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //    发送POST请求https://api.weibo.com/2/statuses/update.json
    
//    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        UIImage *image  = [self.photosView.images firstObject];
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//       
//        // 拼接文件参数
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
//        hud.labelText = @"发表成功";
//        [hud show:YES];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
//        hud.labelText = @"发表失败";
//        [hud show:YES];
//    }];
}

/**
 *  发表无图片的status
 */
- (void)sendStatusWithoutImage{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"access_token"] = [MBAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //    发送POST请求https://api.weibo.com/2/statuses/update.json
    [MBHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id responseObject) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        hud.labelText = @"发表成功";
        [hud show:YES];

    } failure:^(NSError *error) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        hud.labelText = @"发表失败";
        [hud show:YES];
    }];
}

@end
