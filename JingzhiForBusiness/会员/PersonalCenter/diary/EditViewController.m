//
//  EditViewController.m
//  baoke
//
//  Created by Admin on 2017/8/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "EditViewController.h"
#import "MOFSPickerManager.h"
#import "ChooseCommunityOrCompany.h"
#import "ZHPickView.h"
@interface EditViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChooseDelegate,ZHPickViewDelegate>
{
    UITextField *titleTF;
    UILabel *xqlabel;
    UIButton *upLoadBtn;
    UIButton *xBtn;
    UIView *centerView;
//    UIView *bottomView;
    UIView *topView;
    UIImage *imgToFWD;
    UITextField *numberTF;
    UIButton* isPushBtn;
}
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation EditViewController

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
    [navTitle setText:_navString];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    

    [self  mainView];
}
- (void)mainView
{
    //底部scrollview
    TPKeyboardAvoidingScrollView *bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus+20*Width,CXCWidth, CXCHeight-Frame_NavAndStatus-20*Width )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1400*Width)];
    bgScrollView.showsVerticalScrollIndicator =NO;
    
    
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth,800*Width )];
    topView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:topView];

   
    NSArray*leftArr =@[@"标题",@"小区",@"承接公司",@"空间户型",@"装修方式",@"合同总价",@"开工日期",@"完工日期",] ;
    NSArray*rightArr =@[@"请标题",@"选择小区",@"选择公司",@"选择户型",@"选择装修方式",@"合同总价",@"选择开工日期",@"选择完工日期",] ;
    for (int i=0; i<8; i++) {
        
        UIView *bgview =[[UIView alloc]init];
        bgview.frame =CGRectMake(0,100*i*Width, CXCWidth, 100*Width);

        bgview.backgroundColor =[UIColor whiteColor];
        [topView addSubview:bgview];
        UILabel* leftLabe = [[UILabel alloc]initWithFrame:CGRectMake(100*Width,20*Width ,200*Width , 40*Width)];
        leftLabe.text = leftArr[i];
        leftLabe.font = [UIFont systemFontOfSize:15];
        leftLabe.textColor = BlackColor;
        [bgview addSubview:leftLabe];
        leftLabe.frame = CGRectMake(32*Width,20*Width ,200*Width , 40*Width);
        if (i==0||i==5) {
            //右边
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+70];
            [inputText setDelegate:self];
            inputText.placeholder =rightArr[i];
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:[UIColor blackColor]];
            [inputText setFrame:CGRectMake(200*Width, 0,520*Width,99*Width)];
            inputText.textAlignment =NSTextAlignmentRight;
            [bgview addSubview:inputText];
            numberTF =inputText;
        }else{
            UIButton* deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteBtn.frame = CGRectMake(300*Width, 0*Width, 450*Width, 99*Width);
            [deleteBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            deleteBtn.tag = 90+i;
            [bgview addSubview:deleteBtn];
            
            UILabel*rightLabel  =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350*Width, 99*Width)];
            rightLabel.text = rightArr[i];
            rightLabel.font = [UIFont systemFontOfSize:15];
            rightLabel.textColor = BlackColor;
            rightLabel.tag =40+i;
            rightLabel.textAlignment =NSTextAlignmentRight;
            [deleteBtn addSubview:rightLabel];
            
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 35*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
        }
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,98.5*Width, CXCWidth, 1.5*Width);
        
        
    }

    centerView =[[UIView alloc]initWithFrame:CGRectMake(0*Width, 800*Width, CXCWidth, 190*Width)];
    centerView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:centerView];
    
    upLoadBtn= [[UIButton alloc]initWithFrame:CGRectMake(30*Width, 30*Width, 130*Width, 130*Width)];
    [upLoadBtn setBackgroundImage:[UIImage imageNamed:@"icon_addpic"] forState:UIControlStateNormal];
    upLoadBtn.selected   =NO;
    [upLoadBtn addTarget:self action:@selector(photoUpLoad) forControlEvents:UIControlEventTouchUpInside];
    [centerView   addSubview:upLoadBtn];
   
    xBtn = [[UIButton alloc]initWithFrame:CGRectMake(140*Width, 30*Width, 30*Width, 30*Width)];
    UIImage *img =[UIImage imageNamed:@"icon_close_corner"];
    [xBtn setImage:img forState:UIControlStateNormal];
    [xBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];


    [xBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [centerView   addSubview:xBtn];
//    centerView.hidden =YES;
    xBtn.hidden =YES;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,1070*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.cornerRadius = 10;
    layer.shadowColor = NavColor.CGColor;

    [bgScrollView.layer addSublayer:layer];

    UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addAddressBtn setFrame:CGRectMake(40*Width,1070*Width , 670*Width, 88*Width)];
    [addAddressBtn setBackgroundColor:NavColor];
    [addAddressBtn.layer setCornerRadius:4];
    [addAddressBtn.layer setMasksToBounds:YES];
    
    [addAddressBtn setTitle:@"提交" forState:UIControlStateNormal];
    [addAddressBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [addAddressBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [addAddressBtn addTarget:self action:@selector(addDiaryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:addAddressBtn];
    
    
}
- (void)addDiaryBtnAction
{


}
- (void)choosePush:(UIButton *)btn
{
    btn.selected =!btn.selected;

}
- (void)delete
{
    upLoadBtn.selected=NO;
    xBtn.hidden  =YES;
    imgToFWD =nil;
    [upLoadBtn setBackgroundImage:[UIImage imageNamed:@"icon_addpic"] forState:UIControlStateNormal];

    

}

- (void)choose:(UIButton*)btn
{
    [titleTF resignFirstResponder];
    [numberTF resignFirstResponder];
    NSDate *date=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    [_pickview  remove];

    if(btn.tag ==91)
    {
        ChooseCommunityOrCompany *choose =[[ChooseCommunityOrCompany alloc]init];
        choose.communityOrCompany  =@"小区";
        choose.delegate =self;
        [self.navigationController presentViewController:choose animated:YES completion:^{
            
        }];
    
    }
    if(btn.tag ==92)
    {
        ChooseCommunityOrCompany *choose =[[ChooseCommunityOrCompany alloc]init];
        choose.communityOrCompany  =@"公司";
        choose.delegate =self;
        [self.navigationController presentViewController:choose animated:YES completion:^{
            
        }];


    }
    if(btn.tag ==93)
    {
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"四室以上",@"四室两厅",@"四室一厅",@"三室两厅",@"三室一厅",@"两室两厅",@"两室一厅",@"一室一厅"] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 103;
        [_pickview show];

    }
    if(btn.tag ==94)
    {
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"清包",@"半包",@"全包"] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 104;
        [_pickview show];
        
    }
    if(btn.tag ==96)
    {
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 106;
        [_pickview show];
        
        
    }
    if(btn.tag ==97)
    {
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 107;
        [_pickview show];
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if(pickView.tag==103)
    {
        UILabel *typeLabel =[self.view viewWithTag:43];
        typeLabel.text =resultString;
    }else if (pickView.tag ==104)
    {
        UILabel *typeLabel =[self.view viewWithTag:44];
        typeLabel.text =resultString;
    
    }else if (pickView.tag ==106)
    {
        if ([resultString isEqualToString:@"0"]) {
            return;
            
        }
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
        
//        if(time1>time2+60){
//            
//            [ProgressHUD showError:@"时间不能晚于今天"];
//            return;
//            
//        }else
//        {
            UILabel *timeLabel =[self.view viewWithTag:46];
        timeLabel.text =[resultString substringToIndex:11];
//        }
        

        
    }
    else if (pickView.tag ==107)
    {
        if ([resultString isEqualToString:@"0"]) {
                       return;
        }
        
        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        NSInteger time1 = timr;
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
//        if(time1>time2+60){
//            
//            
//            [ProgressHUD showError:@"时间不能晚于今天"];
//            return;
//            
//        }else
//        {
            UILabel *timeLabel =[self.view viewWithTag:47];
        timeLabel.text =[resultString substringToIndex:11];

//        }

        
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)returnBtnAction
{

    [self.navigationController popViewControllerAnimated:YES];
    

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
    upLoadBtn.selected   =YES;
    xBtn.hidden  =NO;

    [upLoadBtn setBackgroundImage:savedImage forState:UIControlStateNormal];
    
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
            NSString *addressStr =[NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"url"]];
            
            [self  editToFWQ:addressStr];
            
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
- (void)editToFWQ:(NSString*)address
{
    
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
    
    NSString *isPushString=0;
    if (isPushBtn.selected==YES) {
        isPushString =@"1";
    }else if (isPushBtn.selected==NO) {
        isPushString =@"2";
    }
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"memberId":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]],
                          @"title":titleTF.text,
                          @"num":[NSString stringWithFormat:@"%@",numberTF.text],
                          @"city":[NSString stringWithFormat:@"%@",addressLabel.text],
                          @"sex":[NSString stringWithFormat:@"%@",sexString],
                          @"option":[NSString stringWithFormat:@"%@",friendString],
                          @"isPush":[NSString stringWithFormat:@"%@",isPushString],
                          @"img":address,
                          }];
    if(_dic)
    {
        [dic1 setObject:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"id"]] forKey:@"id"];
        
    }
    NSLog(@"%@",dic1);
//    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url;

    if (_dic) {
        url =[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Advert/editAdvert"];
 
    }else
    {
       url =[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Advert/addAdvert"];

    }
    //    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];//当加密的时候用
    NSMutableDictionary*parameter =[NSMutableDictionary dictionary];
    int num = (arc4random() % 10000);
    NSString*  randomNumber = [NSString stringWithFormat:@"%.4d", num];
    NSLog(@"%@", randomNumber);
    
    [parameter setDictionary:dic1];
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"上传成功JSON:%@", JSON);
        if ([ [NSString stringWithFormat:@"%@",[JSON objectForKey:@"code"]]isEqualToString:@"0"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate needReloadDataEdit];
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
-(void)cellActionCommunityName:(NSString *)communityName withId:(NSString *)nameId andIscompanyOrcommunity:(NSString *)companyOrcommunity
{

    UILabel *comLable =[self.view viewWithTag:41];
    comLable.text =communityName;
}
- (void)cellActionCompanyName:(NSString *)companyName withId:(NSString *)nameId andIscompanyOrcommunity:(NSString *)companyOrcommunity
{
    UILabel *comLable =[self.view viewWithTag:42];
    comLable.text =companyName;
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
