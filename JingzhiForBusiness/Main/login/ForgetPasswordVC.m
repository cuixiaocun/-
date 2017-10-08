//
//  ForgetPasswordVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/29.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface ForgetPasswordVC ()
{
    NSInteger listTime;
    NSTimer *huoquTimer;
    UIButton *sendCodeBtn;

    TPKeyboardAvoidingScrollView *bgScrollView;

}
@end

@implementation ForgetPasswordVC
//左侧当行页面
-(void)leftBtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)registerBtnClick
{


}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:navBackarrowWhite ] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"忘记密码"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    [self makeThisView];
    
    
    
    
    
    
    
}

-(void)makeThisView
{
    
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight-Frame_NavAndStatus )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator = FALSE;
    bgScrollView.showsHorizontalScrollIndicator = FALSE;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"账号",@"验证码",@"新密码",@"确认密码",] ;
    NSArray *rightArr =@[@"账号",@"验证码",@"请输入6-16位字母、数字密码",@"请再次输密码"];
    //列表

    for (int i=0; i<4; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        UITextField *inputText = [[UITextField alloc] init];
        [inputText setTag:i+10];
        [inputText setPlaceholder:rightArr[i]];
        [inputText setDelegate:self];
        [inputText setFont:[UIFont systemFontOfSize:15]];
        [inputText setTextColor:[UIColor blackColor]];
        [inputText setFrame:CGRectMake(220*Width, 0,580*Width,106*Width)];
        [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
        [bgview addSubview:inputText];
        [inputText setPlaceholder:rightArr[i]];
        if (i==2||i==3) {
            inputText.secureTextEntry =YES;
                
        }else if(i==0)
        {
            [inputText setKeyboardType:UIKeyboardTypePhonePad];
                
        }else
        {
            inputText.frame =CGRectMake(220*Width, 0*Width,250*Width,106*Width);
            UIButton *butto = [[UIButton alloc]initWithFrame:CGRectMake(520*Width, 13*Width, 200*Width, 80*Width)];
            [butto.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [butto setTitle:@"获取验证码" forState:UIControlStateNormal];
            [butto setTitle:[NSString stringWithFormat:@"%lds",listTime] forState:UIControlStateSelected];
            butto.tag = 345;
            butto.backgroundColor =BGColor;
            [butto setTitleColor:NavColor forState:UIControlStateNormal];
            [butto setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1] forState:UIControlStateSelected];
            [butto addTarget:self action:@selector(yanzhengma:) forControlEvents:UIControlEventTouchUpInside];
            [bgview addSubview:butto];
            

        }
       
        
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,104*Width, CXCWidth, 2*Width);
        
        bgview.frame =CGRectMake(0, 20*Width+i*106*Width, CXCWidth, 106*Width);
        

        }
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,600*Width , 670*Width, 98*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.shadowColor = NavColor.CGColor;
    layer.cornerRadius = 44*Width;
    
    [bgScrollView.layer addSublayer:layer];
    

    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,600*Width , 670*Width, 98*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:44*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
}
- (void)nextStep
{
    UITextField *accountLabel =[self.view viewWithTag:10];
    UITextField *codeLabel =[self.view viewWithTag:11];
    UITextField *passwordLabel =[self.view viewWithTag:12];
    UITextField *passwordTwoLabel =[self.view viewWithTag:13];

    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"account":[NSString stringWithFormat:@"%@",accountLabel.text],
                          @"type":_isHYOrDL,
                          @"newpwd1":[NSString stringWithFormat:@"%@",passwordLabel.text],
                          @"newpwd2":[NSString stringWithFormat:@"%@",passwordTwoLabel.text],
                          @"mobilecode":[NSString stringWithFormat:@"%@",codeLabel.text],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"Home/Login/searchpwd" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            [self.navigationController  popViewControllerAnimated:YES];
            [self performSelector:@selector(delayMethodSucess) withObject:nil afterDelay:0.5f];

        }else
        {
            
            
        }
        
    } fail:^(NSError *error) {
        UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
        [sender setUserInteractionEnabled:YES];
    }];
    
}
- (void)yanzhengma:(UIButton *)sender
{
    if (sender.selected) {
        sender.userInteractionEnabled =YES;
        
        
        return;
    }else{
        
        sender.userInteractionEnabled =NO;
        
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.transform =CGAffineTransformIdentity;
        
    }];

    [self getInfoLLL];
    
    
    
}
-(void)daoshu
{
    listTime-=1;
    UIButton *yanzhengBtn = (UIButton *)[self.view viewWithTag:345];
    
    if (listTime==0) {
        [yanzhengBtn setSelected:NO];
        [huoquTimer invalidate];
        listTime =60;
        [yanzhengBtn setUserInteractionEnabled:YES];
        
    }else{
        [yanzhengBtn setTitle:[NSString stringWithFormat:@"%lds",listTime] forState:UIControlStateSelected];
        
    }
}

-(void)sendCodeBtnPressed
{
    if (huoquTimer) {
        [huoquTimer fire];
    }else{
        huoquTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitCode) userInfo:nil repeats:YES];
        [huoquTimer fire];
    }
}
-(void)waitCode
{
    [self getInfoLLL];
    
    if (listTime>1) {
        listTime--;
        [sendCodeBtn setTitle:[NSString stringWithFormat:@"%lds",listTime] forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:[UIColor colorWithWhite:189/255.0 alpha:1] forState:UIControlStateNormal];
        
        [sendCodeBtn setUserInteractionEnabled:NO];
    }else{
        listTime=60;
        [sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:[UIColor colorWithRed:201/255.0 green:33/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
        [sendCodeBtn setUserInteractionEnabled:YES];
        [huoquTimer invalidate];
        
    }
}

-(void)tiaokuanBtnPressed
{
    
}
//短信验证
- (void)getInfoLLL
{
    UITextField *accountLabel =[self.view viewWithTag:10];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"account":[NSString stringWithFormat:@"%@",accountLabel.text],
                          @"type":_isHYOrDL
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"Home/Login/getnum" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
            [MBProgressHUD showSuccess:@"验证码正在发送中" ToView:self.view];
            sender.selected=!sender.selected;
            [huoquTimer invalidate];
            listTime =60;
            huoquTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoshu) userInfo:nil repeats:YES];
            [huoquTimer fire];
            [sender setUserInteractionEnabled:NO];
            
        }else
        {
            UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
            [sender setUserInteractionEnabled:YES];

        }
        
    } fail:^(NSError *error) {
        UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
        [sender setUserInteractionEnabled:YES];
    }];

   
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.transform =CGAffineTransformMakeTranslation(0, 0);
        
    }];
    
    
    for (int i = 1; i<4; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i];
        [inputTExt resignFirstResponder];
    }
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    for (int i = 1; i<3; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i];
        [inputTExt resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.transform =CGAffineTransformMakeTranslation(0, 0);
        
    }];
    
    
    
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
        return YES;
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 11) {
        [textField resignFirstResponder ];
        [ProgressHUD showError:@"不能超过11位"];
        return NO;
    }
    
    
    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textFieled
{
    if(textFieled.tag==3)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.transform  =CGAffineTransformMakeTranslation(0, -100);
            
        }];
        
        
    }
    
    
}

-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)delayMethodSucess
{
    [ProgressHUD showSuccess:@"新密码设置成功"];
}
@end
