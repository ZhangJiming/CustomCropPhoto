//
//  ImagePickerCropViewController.m
//  CustomCropPhoto
//
//  Created by 张继明 on 2016/11/17.
//  Copyright © 2016年 Rain. All rights reserved.
//

#import "ImagePickerCropViewController.h"

@interface ImagePickerCropViewController ()

@property (nonatomic, strong) UIImageView *cropImageView;

@end

@implementation ImagePickerCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = item;
    
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    
    self.cropImageView = [[UIImageView alloc] initWithFrame:frame];
    _cropImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cropImageView setImage:self.originImage];
    _cropImageView.userInteractionEnabled = true;
    [self.view addSubview:_cropImageView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.cropImageView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.cropImageView addGestureRecognizer:pinch];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    maskView.center = self.view.center;
    maskView.backgroundColor = [UIColor clearColor];
    maskView.layer.borderWidth = 0.5;
    maskView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:maskView];
    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    CGFloat scale = recognizer.scale;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    recognizer.scale = 1.0;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint center = self.cropImageView.center;
        self.cropImageView.center = CGPointMake(center.x + translation.x, center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

- (UIImage *)captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(img.CGImage, CGRectMake((self.view.center.x-100)*2+2, (self.view.center.y-100)*2+2, 400-4, 400-4))];
    UIGraphicsEndImageContext();
    return img;
}

- (void)save {
    UIImageWriteToSavedPhotosAlbum([self captureScreen], nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
