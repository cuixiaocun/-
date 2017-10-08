//
//  AccoutSetVC.m
//  家装
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AccoutSetVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IsTureAlterView.h"
#import "MOFSPickerManager.h"
#import "ZHPickView.h"
#import "ManageAddressTableVC.h"
@interface AccoutSetVC ()<UITextFieldDelegate,ZHPickViewDelegate,UIActionSheetDelegate,IsTureAlterViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    //底部scrollview
    TPKeyboardAvoidingScrollView *bgScrollView;
    UIImage *imgToFWD;


}
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation AccoutSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"账户管理"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    UIButton *  withDrawlsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withDrawlsBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    withDrawlsBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [withDrawlsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [withDrawlsBtn setTitle:@"保存" forState:UIControlStateNormal];
    [withDrawlsBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:withDrawlsBtn];

    [self mainView];





}
- (void)saveBtnAction
{
    NSString *logintype =@"1";
    UILabel *addressLabel =[self.view viewWithTag:41];
    UILabel *sexLabel =[self.view viewWithTag:42];
    UILabel *friendLabel =[self.view viewWithTag:43];
    NSString *sexString=0;
    if ([sexLabel.text isEqualToString:@"男"]) {
        sexString =@"1";
    }else if ([sexLabel.text isEqualToString:@"女"]) {
        sexString =@"2";
    }else  if ([sexLabel.text isEqualToString:@"全部"]) {
        sexString =@"0";
    }
    NSString *friendString=@"";
    if ([friendLabel.text isEqualToString:@"好友"]) {
        friendString =@"1";
    }else if ([friendLabel.text isEqualToString:@"群组"]) {
        friendString =@"2";
    }else  if ([friendLabel.text isEqualToString:@"全部"]) {
        friendString =@"3";
    }
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
//    [dic1 setDictionary:@{
//                          @"memberId":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]],
//                          @"logintype":logintype,
//                          @"title":titleTF.text,
//                          @"content":[NSString stringWithFormat:@"%@",detailTV.text],
//                          @"num":[NSString stringWithFormat:@"%@",numberTF.text],
//                          @"city":[NSString stringWithFormat:@"%@",addressLabel.text],
//                          @"sex":[NSString stringWithFormat:@"%@",sexString],
//                          @"option":[NSString stringWithFormat:@"%@",friendString],
//                          @"isPush":[NSString stringWithFormat:@"%@",isPushString],
//                          @"img":address,
//                          }];
//    if(_dic)
//    {
//        [dic1 setObject:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"id"]] forKey:@"id"];
//        
//    }
//    NSLog(@"%@",dic1);
//    //    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
//    NSString *url;
//    
//    if (_dic) {
//        url =[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Advert/editAdvert"];
//        
//    }else
//    {
//        url =[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Advert/addAdvert"];
//        
//    }
//    //    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];//当加密的时候用
//    NSMutableDictionary*parameter =[NSMutableDictionary dictionary];
//    int num = (arc4random() % 10000);
//    NSString*  randomNumber = [NSString stringWithFormat:@"%.4d", num];
//    NSLog(@"%@", randomNumber);
//    
//    [parameter setDictionary:dic1];
//    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
//        
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"上传成功JSON:%@", JSON);
//        if ([ [NSString stringWithFormat:@"%@",[JSON objectForKey:@"code"]]isEqualToString:@"0"])
//        {
//            [self.navigationController popViewControllerAnimated:YES];
//            [self.delegate needReloadDataEdit];
//        }else
//        {
//            [ProgressHUD dismiss];
//            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"msg"]] ToView:self.view];
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD hideHUDForView:self.view];
//        [MBProgressHUD showError:@"加载出错" ToView:self.view];
//        NSLog(@"请求失败:%@", error.description);
//    }];
    
}
- (void)returnBtnAction
{
    [_pickview remove];
    [self.navigationController popViewControllerAnimated:YES];


}
- (void)mainView
{
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight-Frame_NavAndStatus )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1610*Width)];
    NSArray*leftArr =@[@"头像",@"姓名",@"性别",@"生日",@"手机号",@"邮箱",@"城市",@"地址管理",@"修改密码",@"关于",@"",@"",] ;
    NSArray *rightArr =@[@"头像",@"姓名",@"性别",@"生日",@"手机号",@"邮箱",@"城市",@"",@"",@"",@"",];
    //列表
    for (int i=0; i<10; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i==1||i==4||i==5) {
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            if(i==4)
            {
                [inputText setKeyboardType:UIKeyboardTypePhonePad];
            }
            if(i==5)
            {
                [inputText setKeyboardType:UIKeyboardTypeEmailAddress];
            }

            [inputText setPlaceholder:rightArr[i]];
            [inputText setDelegate:self];
            inputText.textAlignment =NSTextAlignmentRight;
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:[UIColor blackColor]];
            [inputText setFrame:CGRectMake(290*Width, 0,420*Width,106*Width)];
            [bgview addSubview:inputText];
        }else
        {
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(290*Width, 0,580*Width,106*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(choosenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                //头像
                UIImageView* photoImgV = [[UIImageView alloc]initWithFrame:CGRectMake(324*Width, 22*Width,64*Width , 64*Width)];
                photoImgV.tag =20+i;
                photoImgV.layer.cornerRadius =32*Width;
                photoImgV.layer.masksToBounds = YES;

                photoImgV.image =[UIImage imageNamed:@"zhanghu_icon_head"];
                [chooseBtn addSubview:photoImgV];
                
            }else
            {
                //文字
                UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,390*Width , 106*Width)];
                wzlabe.text = rightArr[i];
                wzlabe.tag =20+i;
                wzlabe.font = [UIFont systemFontOfSize:16];
                wzlabe.textColor = TextGrayGrayColor;
                [chooseBtn addSubview:wzlabe];
                wzlabe.textAlignment =NSTextAlignmentRight;

            
            }
           
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 35*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
            
            
        }
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,104*Width, CXCWidth, 2*Width);
        
        if (i<4) {
            bgview.frame =CGRectMake(0, 20*Width+i*106*Width, CXCWidth, 106*Width);
            
        }else if(i<8&&i>3)
        {
            bgview.frame =CGRectMake(0, 40*Width+i*106*Width, CXCWidth, 106*Width);
        }else{
            bgview.frame =CGRectMake(0, 60*Width+i*106*Width, CXCWidth, 106*Width);
        }
    }
//    //下一步按钮
//    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [nextBtn setFrame:CGRectMake(0*Width,106*10*Width+80*Width , CXCWidth, 106*Width)];
//    [nextBtn setBackgroundColor:NavColorWhite];
//    [nextBtn.layer setCornerRadius:4];
//    [nextBtn.layer setMasksToBounds:YES];
//    [nextBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
//    [bgScrollView addSubview:nextBtn];
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (textField.tag==14) {
        if (existedLength - selectedLength + replaceLength >= 12) {
            [textField resignFirstResponder];
            return NO;
            }
        
    }

    
    
    return YES;
    
}
- (void)choosenBtnAction:(UIButton*)btn
{
    UITextField *nameText =[self.view viewWithTag:11];
    UITextField *phoneText =[self.view viewWithTag:14];
    UITextField *emailText =[self.view viewWithTag:15];
    
    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [emailText resignFirstResponder];
     if (btn.tag==10)
     {//头像
         [self photoUpLoad];
    
    }else if (btn.tag==12)
    {//性别
        UILabel *addLabel =[self.view viewWithTag:22];
        
        NSArray *arr =@[@"男",@"女"];
        //选择银行
        SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"选择性别" cancelTitle:@"取消" destructiveTitle:nil withNumber:@"3" withLineNumber:@"1" otherTitles:arr otherImages:nil selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
            if (index<0||index>arr.count-1) {
                return;
            }
            addLabel.text =[NSString stringWithFormat:@"%@",arr[index]];
            NSLog(@"%zd----%@", index,addLabel.text);
            addLabel.textColor =TextColor;

        }];
        
        [actionSheet show];

        
    }else if (btn.tag==13)
    {//生日
        NSDate *date=[NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *comps = nil;
        comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        [adcomps setYear:0];
        [adcomps setMonth:0];
        [adcomps setDay:0];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];

        _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = btn.tag-100;
        [_pickview show];
        
        
    }else if (btn.tag==16)
    {//城市
        UILabel*addressLabel = [self.view viewWithTag:26];
        
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:nil numberOfComponents:2 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
            NSArray *array = [address
                              componentsSeparatedByString:@"-"];//字符串按照-分隔成数组
            NSLog(@"array=%@=",array);
            addressLabel.text = array[1];
            addressLabel.textColor =TextColor;
        } cancelBlock:^{
            
        }];


    }else if (btn.tag==17)
    {//地址
        ManageAddressTableVC *mange =[[ManageAddressTableVC alloc]init];
        [self.navigationController pushViewController:mange animated:YES];
        
    }else if (btn.tag==18)
    {//密码

        
    }else if (btn.tag==19)
    {//关于

        
    }
        
    
    
    
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
        UILabel *timeLabel = [self.view viewWithTag:23];
        if ([resultString isEqualToString:@"0"]) {
//            timeLabel.text =resultString;
            
        }else
        {
            //选择日期
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *cellDate =[dateFormatter dateFromString:resultString];
            NSLog(@"%@",cellDate);
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSTimeInterval timr  = [cellDate timeIntervalSince1970];
            
            NSInteger time1 = timr;
            
            //当前时间
            NSDate *  senddate=[NSDate date];
            NSDateFormatter  *dateformat=[[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"yyyy-MM-dd"];
            NSTimeInterval timer  = [senddate timeIntervalSince1970];
            NSInteger time2 = timer;
            
            if(time1>time2+60){
                
                [ProgressHUD showError:@"生日错误"];
                return;
                
            }else
            {
                timeLabel.text =[resultString substringToIndex:11];
                timeLabel.textColor =TextColor;

            }
            

        }
        
    
}

- (void)nextStep
{
    IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要退出吗？"];
    isture.delegate =self;
    isture.tag =180;
    [self.view addSubview:isture];
    
    NSLog(@"showalert");

}
-(void)cancelBtnActinAndTheAlterView:(UIView *)alter
{
    IsTureAlterView *isture = [self.view viewWithTag:180];
    [isture removeFromSuperview];
    NSLog(@"取消");
    
}
-(void)tureBtnActionAndTheAlterView:(UIView *)alter
{
    
    
//    IsTureAlterView *isture = [self.view viewWithTag:180];
//    [isture removeFromSuperview];
//    
//    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
//    [dic1 setDictionary:@{
//                          //                              @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]]
//                          }];
//    
//    [PublicMethod AFNetworkPOSTurl:@"Home/Login/exitlogin" paraments:dic1  addView:self.view success:^(id responseDic) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
//            
//            
//            
//            NSLog(@"确认");
            [[self rdv_tabBarController] setSelectedIndex:0];
            
            //删除
            [PublicMethod removeObjectForKey: @"IsLogin"];
            [PublicMethod removeObjectForKey: member];
            [PublicMethod removeObjectForKey: shopingCart];
            [PublicMethod removeObjectForKey: @"zhangyue_searchJiLu"];
            [PublicMethod removeObjectForKey: @"wantSearch"];
            
//            
//        }
//        
//    } fail:^(NSError *error) {
//        
//    }];
//    
    
}
- (void)photoUpLoad
{
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
//IOS7以上的都要调用方法，选择完成后调用该方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 把头像图片存到本地
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];// 保存文件的名称
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    [imageData writeToFile:filePath atomically:YES];
    
    UIImage *img =[[UIImage alloc] initWithContentsOfFile:filePath];
    UIImage *savedImage =[self image:img rotation:(img.imageOrientation) ] ;
    UIImageView *photoImg =[self.view viewWithTag:20];
    [photoImg setImage:savedImage];
    
    imgToFWD =savedImage;
    
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
- (void)photoUpLoadToFWQ
{
    if (imgToFWD==nil) {
        [MBProgressHUD  showError:@"请上传图片或选择文字信息" ToView:self.view];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url=[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Login/upidcard"];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(imgToFWD, 0.5);
        //使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData :imageData name :@"upimg" fileName : fileName mimeType : @"image/jpg/png/jpeg" ];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"图片请求成功JSON:%@", JSON);
        if ([ [NSString stringWithFormat:@"%@",[JSON objectForKey:@"code"]]isEqualToString:@"0"])
        {
            
        }else
        {
            [ProgressHUD dismiss];
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"msg"]] ToView:self.view];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
    
    
    
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
