//
//  FreeSendLPV.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FreeSendLPV.h"

@implementation FreeSendLPV
- (id)initWithFrame:(CGRect)frame withViewController:(UIViewController *)nav
{
    
    if ( self= [super initWithFrame:frame]) {
    
        [self mainView];
        self.viewController =nav;
    
    }
    return self;

}
- (void)mainView
{
    _uploadImageVArray =[[NSMutableArray alloc]init];
    _picArr =[[NSMutableArray alloc]init];
    _picUrlArr =[[NSMutableArray alloc]init];
    _picIdArr =[[NSMutableArray alloc]init];

    //底部scrollview
    [self isUserInteractionEnabled];
    [self setContentSize:CGSizeMake(CXCWidth, 14000*Width)];
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth,1570*Width )];
    topView.backgroundColor =BGColor;
    [self addSubview:topView];

    NSArray*leftArr =@[@"市/区",@"类型",@"价格",@"小区名称",@"简称",@"均价",@"地址",@"房屋类型",@"联系人",@"联系费电话",@"交房时间",@"开盘时间",@"开发商",@"",@"",@"",@"",@"",@"",@"",] ;
    NSArray*rightArr =@[@"选择市/区",@"选择类型",@"选择价格",@"输入小区名称",@"输入简称",@"输入均价",@"输入地址",@"输入房产类型",@"输入房屋类型",@"输入联系人姓名",@"选择交房时间",@"选择开盘时间",@"输入开发商名称",@"",@"",@"",] ;

    for (int i=0; i<13; i++) {

        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [self addSubview:bgview];
        UILabel* leftLabe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width,30*Width ,200*Width , 40*Width)];
        leftLabe.text = leftArr[i];
        leftLabe.font = [UIFont systemFontOfSize:15];
        leftLabe.textColor = BlackColor;
        [bgview addSubview:leftLabe];
        if ((i>2&&i<10)||i==12) {
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
            inputText.returnKeyType =UIReturnKeyDone;
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
        
        if (i<3) {
            bgview.frame =CGRectMake(0,100*i*Width+20*Width, CXCWidth, 100*Width);

        }else if (i>2&&i<8)
        {
            bgview.frame =CGRectMake(0,100*i*Width+40*Width, CXCWidth, 100*Width);

        }else
        {
            bgview.frame =CGRectMake(0,100*i*Width+60*Width, CXCWidth, 100*Width);

        
        }
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,98.5*Width, CXCWidth, 1.5*Width);
        
        
    }
    
    UIView*contentV =[[UIView alloc]initWithFrame:CGRectMake(0*Width,1300*Width+60*Width, CXCWidth, 210*Width)];
    [topView addSubview:contentV];
    contentV.backgroundColor =[UIColor whiteColor];
    //活动内容
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(25*Width,1300*Width+60*Width, 700*Width, 210*Width)];
    self.contentTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.contentTextView.text=NSLocalizedString(@"描述一下日记文章内容", nil);
    //提示语
    self.contentTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.contentTextView.delegate = self;
    self.contentTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.contentTextView.backgroundColor = [UIColor clearColor];
    [topView addSubview:self.contentTextView];
    
    //中间信息
    UIView *zhongView = [[UIView alloc]init];
    [self addSubview:zhongView];
    zhongView.backgroundColor =[UIColor whiteColor];
    zhongView.userInteractionEnabled =YES;
    zhongView.tag = 501;
    zhongView.frame =CGRectMake(0,topView.bottom+Width*10,CXCWidth , 250*Width);
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*Width, 30*Width, 190*Width, 190*Width)];
    [btn setImage:[UIImage imageNamed:@"icon_addpic"] forState:UIControlStateNormal];
    btn.userInteractionEnabled =YES;
    [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
    btn.tag =200;
    [zhongView addSubview:btn];
    
    //地址及以下
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,zhongView.bottom,CXCWidth, 520*CXCWidth)];
    [self addSubview:bottomView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,106*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.shadowColor = NavColor.CGColor;
    
    layer.cornerRadius = 44*Width;
    [bottomView.layer addSublayer:layer];
    
    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,106*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:44*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(sureDrawls) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:nextBtn];
    
    
    
    
}
- (void)choosePush:(UIButton *)btn
{
    btn.selected =!btn.selected;
    
}
- (void)sureDrawls
{
    
    
}


- (void)choose:(UIButton*)btn
{
    for (int i=3; i<15; i++) {
        UITextField *field =[self viewWithTag:70+i];
        [field  resignFirstResponder];
    }
    [_contentTextView resignFirstResponder];
    
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
    if(btn.tag ==90)
    {
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"寒亭区",@"奎文区",@"潍城区",@"坊子区",@"诸城市",@"安丘市",@"奎文区",@"高密市",@"青州市"] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 200;
        [_pickview show];
    }
    if(btn.tag ==91)
    {
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"四室以上",@"四室两厅",@"四室一厅",@"三室两厅",@"三室一厅",@"两室两厅",@"两室一厅",@"一室一厅"] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 201;
        [_pickview show];
 
    }
    if(btn.tag ==92)
    {
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"1000",@"1000-2000",@"2000-3000",@"1000-2000",@"1000-2000",@"1000-2000",@"1000-2000",@"1000-2000"] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 202;
        [_pickview show];
        
        
    }
       if(btn.tag ==100)
    {
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 210;
        [_pickview show];
        
        
    }
    if(btn.tag ==101)
    {
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 211;
        [_pickview show];
    }
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if(pickView.tag==200)
    {
        UILabel *typeLabel =[self viewWithTag:40];
        typeLabel.text =resultString;
    }else if (pickView.tag ==201)
    {
        UILabel *typeLabel =[self viewWithTag:41];
        typeLabel.text =resultString;
        
    }else if (pickView.tag ==202)
    {
        UILabel *typeLabel =[self viewWithTag:42];
        typeLabel.text =resultString;
        
    }else if (pickView.tag ==210)
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
        UILabel *timeLabel =[self viewWithTag:50];
        timeLabel.text =[resultString substringToIndex:11];
        //        }
        
        
        
    }
    else if (pickView.tag ==211)
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
        UILabel *timeLabel =[self viewWithTag:51];
        timeLabel.text =[resultString substringToIndex:11];
        
        //        }
        
        
    }
    
    
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
                                                [self.viewController presentViewController:imagePickerController animated:YES completion:^{}];
                                            }];
            [alertController addAction:defaultAction];
        }
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.viewController presentViewController:imagePickerController animated:YES completion:^{
                imagePickerController.delegate = self;
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                       {
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:defaultAction1];
        //弹出试图，使用UIViewController的方法
        [self.viewController presentViewController:alertController animated:YES completion:nil];
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
        [sheet showInView:self];
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
    [self.viewController  presentViewController:imagePickerController animated:YES completion:nil];
    
    
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
        [MBProgressHUD  showError:@"请上传图片或选择文字信息" ToView:self];
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
        [MBProgressHUD hideHUDForView:self];
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"图片请求成功JSON:%@", JSON);
        if ([ [NSString stringWithFormat:@"%@",[JSON objectForKey:@"code"]]isEqualToString:@"0"])
        {
            NSString *addressStr =[NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"url"]];
            
            [self  editToFWQ:addressStr];
            
        }else
        {
            [ProgressHUD dismiss];
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"msg"]] ToView:self];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self];
        [MBProgressHUD showError:@"加载出错" ToView:self];
        NSLog(@"请求失败:%@", error.description);
    }];
    
    
    
}
- (void)editToFWQ:(NSString*)address
{
    
    UILabel *addressLabel =[self viewWithTag:41];
    UILabel *sexLabel =[self viewWithTag:42];
    UILabel *friendLabel =[self viewWithTag:43];
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
//    if(_dic)
//    {
//        [dic1 setObject:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"id"]] forKey:@"id"];
//        
//    }
    NSLog(@"%@",dic1);
    //    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url;
    
//    if (_dic) {
//        url =[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Advert/editAdvert"];
//        
//    }else
//    {
//        url =[NSString stringWithFormat:@"%@/%@",SERVERURL,@"index.php/Home/Advert/addAdvert"];
//        
//    }
    //    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];//当加密的时候用
    NSMutableDictionary*parameter =[NSMutableDictionary dictionary];
    int num = (arc4random() % 10000);
    NSString*  randomNumber = [NSString stringWithFormat:@"%.4d", num];
    NSLog(@"%@", randomNumber);
    
    [parameter setDictionary:dic1];
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"上传成功JSON:%@", JSON);
        if ([ [NSString stringWithFormat:@"%@",[JSON objectForKey:@"code"]]isEqualToString:@"0"])
        {
            [self.viewController.navigationController   popViewControllerAnimated:YES];
        }else
        {
            [ProgressHUD dismiss];
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"msg"]] ToView:self];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"加载出错" ToView:self];
        NSLog(@"请求失败:%@", error.description);
    }];
    
}
- (void)tupian:(NSNotification *)not
{
    _picIdArr = not.object;
    
    [self xianshi];
    
    
    [self zhuanhuanTupian];
    
}
- (void)resignFirstResponderAllTextFiled
{
    for (int i=3; i<15; i++) {
        UITextField *field =[self viewWithTag:70+i];
        [field  resignFirstResponder];
    }
    [_contentTextView resignFirstResponder];
    


}
- (void)xuanzhong
{
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    [next showInViewContrller:self.viewController choosenNum:0 delegate:self withArr:_picIdArr];
    
    
    
    
}

-(void)shanchu:(UIButton *)btn
{
    [_picIdArr removeObjectAtIndex:btn.tag-44400];
    [self xianshi];
    
    
}
- (void)initPictureView
{
    
    
}


-(void) postShadowTap:(UITapGestureRecognizer *)sender
{
}
// - - -- - -- -  -- - - - - -- - - -textField或者textView代理 - -- - - - -- - - -- - - -- - - -- - - -- -
//点击return 按钮 去掉

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{    [_pickview  remove];

    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"描述一下日记文章内容", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"描述一下日记文章内容", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if ([textView.text isEqualToString:@""])
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text=NSLocalizedString(@"描述一下日记文章内容", nil);
        }
        
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"描述一下日记文章内容", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{    [_pickview  remove];

    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -

//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击发布按钮
- (void)launchedDidClicked:(UIButton *)sender
{
    [self LaunchedCampaignRequest];
    
}
#pragma mark 发起活动网络请求(先上传图片)
- (void)LaunchedCampaignRequest
{
    timeCount=1;
    for(NSInteger i = 0; i < self.picUrlArr.count; i++)
    {
        NSData * imageData = [self.picUrlArr objectAtIndex: i];
        [_uploadImageVArray addObject:@""];
        
        [self uploadImage:imageData withInt:i];
        
    }
    if(_picIdArr.count==0)
    {
        [self postTheAction ];
        
    }
    
}


#pragma mark 图片上传请求
//上传图片
- (void) uploadImage:(NSData *)imageDate withInt:(NSInteger)index
{
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",@""];
    NSLog(@"postUrl = %@",postUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *eachImgData = UIImageJPEGRepresentation(_picIdArr[index], 0.3);
        //        使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //
        [formData appendPartWithFileData :eachImgData name : @"file" fileName : fileName mimeType : @"image/jpg/png/jpeg" ];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self];
        NSLog(@"请求成功:%@", responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"图片请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [_uploadImageVArray replaceObjectAtIndex:index withObject:[[JSON objectForKey:@"param"] objectForKey:@"url"]];
            
            NSLog(@"%@",self.uploadImageVArray);
            
            if (timeCount==_picIdArr.count) {
                
                
                [self postTheAction];
                
                
            }
            timeCount++;
            
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self];
        [MBProgressHUD showError:@"加载出错" ToView:self];
        NSLog(@"请求失败:%@", error.description);
    }];
}

- (void)postTheAction
{
    
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 把头像图片存到本地
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];   // 保存文件的名称
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:filePath atomically:YES];
    
    CGSize originalSize = image.size;
    
    CGFloat maxSize = 250;
    
    CGFloat width =originalSize.width;
    CGFloat height=originalSize.height ;
    
    
    if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
        width = maxSize;
        height = width*originalSize.height /originalSize.width;
    }
    
    if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
        height = maxSize;
        width= height*originalSize.width /originalSize.height;
    }
    
    
    CGSize newSize = CGSizeMake(width, height);
    
    UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
    
    [_picIdArr addObject:sacelImg];
    [_picUrlArr addObject:imageData];
    
}
-(void)xianshi
{
    UIView *zhong= (UIView*)[self viewWithTag:501];
    for (UIView *buton in  [zhong subviews]) {
        
        if ([buton isKindOfClass:[UIButton class]]) {
            [buton removeFromSuperview];
        }
        
    }
    
    NSLog(@"%lu",(unsigned long)_picIdArr.count);
    for (int i=0; i<_picIdArr.count+1; i++) {
        if (i<3) {
            
            zhong.frame =CGRectMake(0,topView.bottom+Width*10,CXCWidth , 250*Width);
            bottomView.frame =CGRectMake(0,zhong.bottom,CXCWidth, 520*Width);
            [self setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+CXCWidth*0.2)];
            
            
        }else if(i<6&&i>2)
        {
            zhong.frame =CGRectMake(0,topView.bottom+Width*10,CXCWidth, 470*Width);
            bottomView.frame =CGRectMake(0,zhong.bottom,CXCWidth, 520*Width);
            [self setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+CXCWidth*0.2)];
            
        }else
        {
            zhong.frame =CGRectMake(0,topView.bottom+Width*10,CXCWidth, 690*Width);
            bottomView.frame =CGRectMake(0,zhong.bottom,CXCWidth, 520*Width);
            [self setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+CXCWidth*0.2)];
            
        }
        if (i<_picIdArr.count) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*Width+i%3*Width*235, i/3*220*Width+30*Width, 190*Width, 190*Width)];
            [btn setImage:_picIdArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(datu:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag =400+i;
            [ zhong  addSubview:btn];
            
            
            UIButton *xBtn = [[UIButton alloc]initWithFrame:CGRectMake(-40*Width, -40*Width, 80*Width, 80*Width)];
            [xBtn setImage:[UIImage imageNamed:@"me_icon_del"] forState:UIControlStateNormal];
            [xBtn setImageEdgeInsets:UIEdgeInsetsMake(20*Width, 20*Width, 20*Width, 20*Width)];
            xBtn.userInteractionEnabled =YES;
            [xBtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
            xBtn.tag =44400+i;
            [btn addSubview:xBtn];
            
            
            
            
        }else
        {
            if (i<9) {
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*Width+i%3*Width*235,  i/3*220*Width+30*Width, 190*Width, 190*Width)];
                [btn setImage:[UIImage imageNamed:@"icon_addpic"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
                btn.tag =400+i;
                [ zhong  addSubview:btn];
                
                
            }
            
        }
        
    }
    
    
    
}
//选图回来
- (void)YBImagePickerDidFinishWithImages:(NSMutableArray *)imageArray {
    
    [_picIdArr addObjectsFromArray:imageArray ];
    [self xianshi];
    [self zhuanhuanTupian];
    
    
}
- (void)zhuanhuanTupian
{
    _picArr= [[NSMutableArray alloc]init];
    
    _picUrlArr = [[NSMutableArray alloc]init];
    for (int i=0; i<_picIdArr.count; i++) {
        UIImage *image = _picIdArr[i];
        // 把头像图片存到本地
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];   // 保存文件的名称
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [imageData writeToFile:filePath atomically:YES];
        
        CGSize originalSize = image.size;
        
        CGFloat maxSize = 250;
        
        CGFloat width =originalSize.width;
        CGFloat height=originalSize.height ;
        
        
        if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
            width = maxSize;
            height = width*originalSize.height /originalSize.width;
        }
        
        if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
            height = maxSize;
            width= height*originalSize.width /originalSize.height;
        }
        
        
        CGSize newSize = CGSizeMake(width, height);
        
        UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
        
        [_picArr addObject:sacelImg];
        [_picUrlArr addObject:imageData];
        
        
        
    }
    
    
    
    
}
- (NSString*)getMyImage:(UIImage*)image{
    CGSize originalSize = image.size;
    
    CGFloat maxSize = 500;
    
    CGFloat width =originalSize.width;
    CGFloat height=originalSize.height;
    if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
        width = maxSize;
        height = width*originalSize.height /originalSize.width;
    }
    
    if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
        height = maxSize;
        width= height*originalSize.width /originalSize.height;
    }
    
    CGSize newSize = CGSizeMake(width, height);
    UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
    
    // 保存图片至本地，方法见下文
    NSData *dd =UIImageJPEGRepresentation(sacelImg, 1.0);
    return [dd base64EncodedStringWithOptions:0];
    
}
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
- (void)datu:(UIButton *)btn
{
    NSMutableArray  *arr =[[NSMutableArray alloc]init];
    for (int  i = 0; i<_picArr.count; i++) {
        AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:nil img:_picArr[i]];
        [arr addObject:item];
    }
    
    
    AKGallery* gallery = AKGallery.new;
    gallery.items=arr;
    gallery.custUI=AKGalleryCustUI.new;
    gallery.selectIndex=btn.tag-400;
    gallery.completion=^{
        NSLog(@"completion gallery");
    };
    //show gallery
    [self presentAKGallery:gallery animated:YES completion:nil];
    
    
}
-(void)presentAKGallery:(AKGallery *)gallery animated:(BOOL)flag completion:(void (^)(void))completion{
    
    //todo:defaults
    
    [gallery.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    [self.viewController presentViewController:gallery animated:flag completion:completion];
    
}

//
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
