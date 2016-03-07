//
//  ImagePicViewController.m
//  DemoList
//
//  Created by luoyan on 16/3/4.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "ImagePicViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"
#import <QuartzCore/QuartzCore.h>
#import "ShowcaseFilterListController.h"

@interface ImagePicViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIImageView *rootImageView;
    UIToolbar *toolBar;
    UISegmentedControl *seg;
    UIImage *currentImage;
    UIImagePickerController *imagePicker;
    NSData *data;
    UIScrollView *scrollerView;
    
    UIImage *rootImage;
    UIImageView *imageView;
    
}

@end

@implementation ImagePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubView
{
    rootImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 64, 240, 320)];
    rootImageView.center = self.view.center;
    
    self.title = @"图片处理";    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"打开" style:UIBarButtonItemStyleBordered target:self action:@selector(open)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)open
{
    [imageView removeFromSuperview];
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"打开图片" delegate:self cancelButtonTitle:@"关闭" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"照相机",@"处理图片",@"2", nil];//关闭按钮在最后
    
    sheet.delegate = self;
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;//样式
    [sheet showInView:self.view];//显示样式
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
        imagePicker = [[UIImagePickerController alloc] init];//图像选取器
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//打开相册
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//过渡类型,有四种
        //        imagePicker.allowsEditing = NO;//禁止对图片进行编辑
        
        [self presentModalViewController:imagePicker animated:YES];//打开模态视图控制器选择图像
        
    }
    if(buttonIndex == 1)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//照片来源为相机
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self presentModalViewController:imagePicker animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备没有照相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (buttonIndex == 2) {
        if (currentImage) {
            rootImageView.image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_heibai];
        }
    }
    
    if (buttonIndex == 3) {
        ShowcaseFilterListController *filterListController = [[ShowcaseFilterListController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:filterListController animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//将拍到的图片保存到相册
    }
    
    currentImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(260, 340)];
    
    rootImageView.image = currentImage;
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 50)];
    rootImage = [UIImage imageNamed:@"110.png"];
    imageView.image = rootImage;
    [scrollerView addSubview:imageView];
    
    seg.userInteractionEnabled = YES;
    [self.view addSubview:rootImageView];
    [self dismissModalViewControllerAnimated:YES];//关闭模态视图控制器
}

-(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    
    UIGraphicsEndImageContext();//关闭当前环境
    
    return newImage;
}
@end
