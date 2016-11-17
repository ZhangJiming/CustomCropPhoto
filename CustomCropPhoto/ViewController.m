//
//  ViewController.m
//  CustomCropPhoto
//
//  Created by 张继明 on 2016/11/17.
//  Copyright © 2016年 Rain. All rights reserved.
//

#import "ViewController.h"
#import "ImagePickerCropViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)choosePhotot:(id)sender {
    
     UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
     imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//     imagePickerController.allowsEditing = true; 如果为true，就不会展现我们自己的裁剪视图了，就无法自定义了
     imagePickerController.delegate = self;
     
     [self presentViewController:imagePickerController animated:true completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originImage = info[@"UIImagePickerControllerOriginalImage"];
    ImagePickerCropViewController *vc = [[ImagePickerCropViewController alloc] init];
    vc.originImage = originImage;
    [picker pushViewController:vc animated:true];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}


@end
