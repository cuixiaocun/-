//
//  SetIDNumberVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/1.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "SetIDNumberVC.h"
#import "EGOImageButton.h"
#import "PhotoSampleVC.h"
@interface SetIDNumberVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    NSString *zhengOrfan;
    

}
@end

@implementation SetIDNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topImageView];
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:@"idCard_btn_goBack_red"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //导航栏标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"上传身份证件"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:TextColor];
    [self.view addSubview:navTitle];
    
    [self mainView];
    
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    
    //看拍照示例
    UIButton *seeEG =[[UIButton alloc]init];
    [seeEG addTarget:self action:@selector(seeTheEG) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:seeEG];
    [seeEG setFrame:CGRectMake(260*Width,40*Width , 230*Width, 30*Width)];
    [seeEG setImage:[UIImage imageNamed:@"register_btn_example"] forState:UIControlStateNormal];
    //正面和反面
    for (int i=0; i<2; i++) {
    UIImageView *oppositeImg = [[UIImageView alloc]initWithFrame:CGRectMake(120*Width, 110*Width+365*Width*i, 510*Width, 330*Width)];
    oppositeImg.tag =50+i;
    oppositeImg.userInteractionEnabled = YES;
    oppositeImg.contentMode = UIViewContentModeScaleAspectFit;
        
    oppositeImg.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:oppositeImg];

    EGOImageButton *oppositeBtn =[[EGOImageButton alloc]init];
        if (i==0) {
            [oppositeBtn setImage:[UIImage imageNamed:@"register_btn_front"] forState:UIControlStateNormal];
            
        }else
        {
            [oppositeBtn setImage:[UIImage imageNamed:@"register_btn_back"] forState:UIControlStateNormal];

        
        }
        
    oppositeBtn.frame= CGRectMake(130*Width,75*Width,250*Width, 150*Width);
//        oppositeBtn.backgroundColor =[UIColor redColor];
    oppositeBtn.tag =30+i;
    [oppositeImg addSubview:oppositeBtn];
    [oppositeBtn addTarget:self action:@selector(oppositeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,900*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认上传" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(putUpPhoto) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
    
    
    
}
- (void)putUpPhoto
{
    [self.delegate successUpPhoto];
    [self.navigationController popViewControllerAnimated:YES];
    

}
- (void)seeTheEG
{

    PhotoSampleVC *photoVC=[[PhotoSampleVC alloc]init];
    [self.navigationController   pushViewController:photoVC animated:YES];
    

}
- (void)oppositeBtn:(UIButton *)btn
{
    if(btn.tag==30)
    {
        zhengOrfan =@"zheng";
        
    }else
    {
        
        zhengOrfan=@"fan";
        
    }

        if (IOS7)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //判断是否支持相机，模拟器没有相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                                {
                                                    //相机
                                                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                                                    imagePickerController.delegate = self;
                                                    imagePickerController.allowsEditing = YES;
                                                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                    [self presentViewController:imagePickerController animated:YES completion:^{}];
                                                }];
                [alertController addAction:defaultAction];
            }
            UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //相册
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:^{
                    imagePickerController.delegate = self;
                }];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                           {
                                               
                                           }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:defaultAction1];
            //弹出试图，使用UIViewController的方法
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            UIActionSheet *sheet;
            //判断是否支持相机，模拟器没有相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            }
            else
            {
                sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            }
            [sheet showInView:self.view];
            if(btn.tag==30)
            {
                sheet.tag =40;
                zhengOrfan =@"zheng";
                
            }else
            {
                
                sheet.tag =41;
                zhengOrfan=@"fan";

            }
        }
        
    

 
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourctType = 0;
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex) {
            case 1:
                sourctType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                sourctType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                break;
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            sourctType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    //跳转到相机或者相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourctType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
  
    
}
//保存图片
- (void) savePRImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
//IOS7以上的都要调用方法，选择完成后调用该方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    //保存图片至本地，上传图片到服务器需要使用
    [self savePRImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    UIImage *img =[[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage *savedImage =[self image:img rotation:(img.imageOrientation) ] ;
    
    if ([zhengOrfan isEqualToString:@"zheng"]) {
        UIImageView *imgOne=[self.view viewWithTag:50];
        EGOImageButton *img=[self.view viewWithTag:30];
        [img setImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];
        

        [imgOne setImage:savedImage];
        
        

    }else
    {
        UIImageView *imgOne=[self.view viewWithTag:51];
        EGOImageButton *img=[self.view viewWithTag:31];
        [img setImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];

        [imgOne setImage:savedImage];
        

    
    }
    
    
    
    
    //设置图片显示
//    [self.showPicRepImmage setImage:savedImage];
//    [self.fullScreenRepImmage setImage:savedImage];
//    //上传图片 //异步加载
//    [MBProgressHUD showLoadToView:self.view];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        self.imgageUrl = [CYLRDataReuest uploadImage:savedImage withView:self.view];
//        NSLog(@"self.imageUrl = %@",self.imgageUrl);
//    });
    //    [self uploadImage:savedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{

    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
