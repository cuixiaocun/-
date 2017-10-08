//
//  EditKnowledgeVC.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "EditKnowledgeVC.h"
#import "YBImgPickerViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AKGallery.h"
#import "CXCPickView.h"
@interface EditKnowledgeVC ()<YBImgPickerViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CXCPickerViewDelegate>
{
    TPKeyboardAvoidingScrollView *bgScrollView;
    int timeCount;//上传图片请求
    UIView *bottomView;
    UIView *topView;
    NSInteger indx;
    
}
@property(strong, nonatomic) CXCPickView*myPickerView;
@property(nonatomic,strong)NSArray*oneDataArray;
@property(nonatomic,strong)NSArray*twoDataArray;

@end

@implementation EditKnowledgeVC


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
    [navTitle setText:@"发帖"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tupian:) name:@"tupian" object:nil];
    _uploadImageVArray =[[NSMutableArray alloc]init];
    
    _picArr =[[NSMutableArray alloc]init];
    _picUrlArr =[[NSMutableArray alloc]init];
    _picIdArr =[[NSMutableArray alloc]init];
    [self mainView];
    }
-(void)tureBtnAction:(NSString *)componentstring forRow:(NSString *)rowString
{
    //选择
    UILabel *typeLabel =[self.view viewWithTag:41];
    typeLabel.text =componentstring;
    typeLabel.textColor =[UIColor blackColor];

}
- (void)cancelBtnAction:(NSString *)componentstring forRow:(NSString *)rowString
{
    //选择
    UILabel *typeLabel =[self.view viewWithTag:41];
    typeLabel.text =componentstring;
    typeLabel.textColor =[UIColor blackColor];


}
- (void)returnBtnAction
{
    [_pickview remove];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)mainView
{
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus+20*Width, CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    //bgScrollView.backgroundColor =[UIColor redColor];
    bgScrollView.scrollEnabled = YES;
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth,410*Width )];
    topView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:topView];
    NSArray*leftArr =@[@"标题",@"帖子分类",@"",] ;
    NSArray*rightArr =@[@"请填写标题",@"选择分类",@""] ;
    
    for (int i=0; i<3; i++) {
        
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
        
        if (i==0) {
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
            _titleTextField =inputText;
        }else if(i==1)
        {
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
            if ( [rightLabel.text isEqualToString:@"选择分类"]) {
                rightLabel.textColor = TextGrayGrayColor;
            }else
            {
                rightLabel.textColor = [UIColor blackColor];
            }
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 35*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
        }else
        {
            bgview.frame =CGRectMake(0,100*i*Width, CXCWidth, 210*Width);
            //活动内容
            self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(25*Width,0, 700*Width, 210*Width)];
            self.contentTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
            self.contentTextView.text=NSLocalizedString(@"发帖内容", nil);//提示语
            self.contentTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
            self.contentTextView.delegate = self;
            self.contentTextView.font = [UIFont fontWithName:@"Arial" size:15];
            self.contentTextView.backgroundColor = [UIColor clearColor];
            [bgview addSubview:self.contentTextView];
            
        }
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,98.5*Width, CXCWidth, 1.5*Width);
        
        if (i==2) {
            xian.frame =CGRectMake(0,218.5*Width, CXCWidth, 1.5*Width);
        }
        
        
    }
    //中间信息
    UIView *zhongView = [[UIView alloc]init];
    [bgScrollView addSubview:zhongView];
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
    [bgScrollView addSubview:bottomView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,106*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.cornerRadius = 44*Width;
    [bottomView.layer addSublayer:layer];
    layer.shadowColor = NavColor.CGColor;

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




- (void)sureDrawls
{
    
    
}








- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //oneDay > anotherDay
        return 1;
    }
    else if (result == NSOrderedAscending){
        //oneDay < anotherDay
        return -1;
    }
    //oneDay = anotherDay
    return 0;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];//进入照相界面
            
        }
            break;
        case 1:
        {
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            [self presentViewController:pickerImage animated:YES completion:nil];//进入照相界面
        }
            break;
            
        default:
            break;
    }
}
//
//

- (void)tupian:(NSNotification *)not
{
    _picIdArr = not.object;
    
    [self xianshi];
    
    
    [self zhuanhuanTupian];
    
}

- (void)xuanzhong
{
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)shanchu:(UIButton *)btn
{
    [_picIdArr removeObjectAtIndex:btn.tag-44400];
    [self xianshi];
    
    
}
- (void)initPictureView
{
    
    
}
- (void)choose:(UIButton*)btn{
    [_pickview remove];
//    _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"开工大吉",@"水电改造",@"泥瓦工阶段",@"木工阶段",@"油漆阶段",@"安装",@"验收完成",@"",@"",@""] isHaveNavControler:NO];
//    _pickview.delegate=self;
//    _pickview .tag = 103;
//    [_pickview show];
    [_myPickerView removeFromSuperview];
    _myPickerView =[[CXCPickView alloc ]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)withArr:@[@{@"name1":@"不限",@"name2":@[@"不限"]},
                            @{@"name1":@"家居设计",@"name2":@[@"不限",@"装修枫树",@"检品",@"风格",@"检品",@"客厅"]},
  @{@"name1":@"家居设计",@"name2":@[@"不限",@"装修枫树",@"检品"]},
  @{@"name1":@"材料设计",@"name2":@[@"不限",@"装修枫树",@"检品"]},
  @{@"name1":@"产品设计",@"name2":@[@"不限",@"风格",@"检品",@"客厅"]},
  @{@"name1":@"家居设计",@"name2":@[@"不限",@"风格",@"检品",@"客厅",@"装修枫树",@"检品"]},

                                                                
                                                                                                     
                                                                                                     
                                                                                                     
                                                                                                     ]];

    _myPickerView.delegate=self;
    [self.view addSubview:_myPickerView];
    indx =0;

    //隐藏键盘
    [_contentTextView resignFirstResponder];
    [_titleTextField resignFirstResponder];
    //切换状态
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    //选择日期
    UILabel *typeLabel =[self.view viewWithTag:41];
    typeLabel.text =resultString;
    typeLabel.textColor = [UIColor blackColor];

    
    
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
{
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"发帖内容", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"发帖内容", nil);
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
            textView.text=NSLocalizedString(@"发帖内容", nil);
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
        textView.text=NSLocalizedString(@"发帖内容", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -

//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        [MBProgressHUD hideHUDForView:self.view];
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
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
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
    UIView *zhong= (UIView*)[self.view viewWithTag:501];
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
            [bgScrollView setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+CXCWidth*0.2)];
            
            
        }else if(i<6&&i>2)
        {
            zhong.frame =CGRectMake(0,topView.bottom+Width*10,CXCWidth, 470*Width);
            bottomView.frame =CGRectMake(0,zhong.bottom,CXCWidth, 520*Width);
            [bgScrollView setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+CXCWidth*0.2)];
            
        }else
        {
            zhong.frame =CGRectMake(0,topView.bottom+Width*10,CXCWidth, 690*Width);
            bottomView.frame =CGRectMake(0,zhong.bottom,CXCWidth, 520*Width);
            [bgScrollView setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+CXCWidth*0.2)];
            
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
    [self presentViewController:gallery animated:flag completion:completion];
    
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
