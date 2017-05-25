 //
//  LoginPage.m
//  Demo_simple
//
//  Created by Eleven on 15/4/19.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "LoginPage.h"
@interface LoginPage ()

@end

@implementation LoginPage

//-(void)forgetBtnPressed
//{
//    
//}
//-(void)registerBtnPressed
//{
//}
//-(void)visitBtnPressed
//{
//    [PublicMethod setObject:@"11" key:@"visit"];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //底部scrollview
    UIScrollView *bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, CXCHeight )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
       [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(320, 568)];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 174+Frame_Y)];
    [titleImage setImage:[UIImage imageNamed:@"login_title.png"]];
    [bgScrollView addSubview:titleImage];
    
    
    
    for (int i =0; i<2; i++) {
        if (i==0) {
            UIImageView *textBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg.png"]];
            [textBg setUserInteractionEnabled:YES];
            [textBg setFrame:CGRectMake(30, titleImage.bottom+70, 262, 5)];
            [bgScrollView addSubview:textBg];

            UIImageView *tishi = [[UIImageView alloc] init];
            [tishi setFrame:CGRectMake(41, titleImage.bottom+47, 25, 25)];
            [tishi setImage:[UIImage imageNamed:@"login_user.png"]];
            [bgScrollView addSubview:tishi];
            
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:1];
//            [inputText setKeyboardType:UIKeyboardTypeNumberPad];
            [inputText setPlaceholder:@"请输入身份证号"];
            [inputText setDelegate:self];
            [inputText setFont:[UIFont systemFontOfSize:15]];
            [inputText setTextColor:[UIColor colorWithWhite:120/255.0 alpha:1]];

            [inputText setFrame:CGRectMake(75, titleImage.bottom+48, 200, 22)];
            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [inputText setKeyboardType:UIKeyboardTypeDefault];
            [bgScrollView addSubview:inputText];

        }else
        {
            UIImageView *textBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg.png"]];
            [textBg setUserInteractionEnabled:YES];
            [textBg setFrame:CGRectMake(30, titleImage.bottom+116, 262, 5)];
            [bgScrollView addSubview:textBg];

            UIImageView *tishi = [[UIImageView alloc] init];
            [tishi setFrame:CGRectMake(41, titleImage.bottom+94, 25, 25)];
            [tishi setImage:[UIImage imageNamed:@"login_password.png"]];
            [bgScrollView addSubview:tishi];

            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:2];
            inputText.delegate = self;
            [inputText setPlaceholder:@"请输入密码"];
            [inputText setFont:[UIFont systemFontOfSize:15]];
            [inputText setTextColor:[UIColor colorWithWhite:120/255.0 alpha:1]];
            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [inputText setSecureTextEntry:YES];
            [inputText setFrame:CGRectMake(75, titleImage.bottom+96, 200, 22)];
            [bgScrollView addSubview:inputText];

        }
    }
    //忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithWhite:120/255.0 alpha:1] forState:UIControlStateNormal];
    [forgetBtn setFrame:CGRectMake(230, 325, 70, 20)];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [forgetBtn addTarget:self action:@selector(registerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:forgetBtn];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame:CGRectMake(30, 361 +Frame_Y, 260, 50)];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:201/255.0 green:33/255.0 blue:44/255.0 alpha:1]];
    [loginBtn.layer setCornerRadius:5];
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [loginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [loginBtn addTarget:self action:@selector(loginAdmin) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:loginBtn];

  
//    UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, loginBtn.bottom+12, 100, 15)];
//    [registerLabel setTextAlignment:NSTextAlignmentLeft];
//    [registerLabel setText:@"还没有账号，我要"];
//    [registerLabel setTextColor:[UIColor colorWithWhite:77/255.0 alpha:1]];
//    [registerLabel setFont:[UIFont systemFontOfSize:12]];
//    [bgScrollView addSubview:registerLabel];
//    
//    //注册按钮
//    NSMutableAttributedString *oldGoodAtt = [[NSMutableAttributedString alloc] initWithString:@"立即注册"];
//    NSRange range = {0,[oldGoodAtt length]};
//
//    [oldGoodAtt addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
//    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
//    [registerBtn.titleLabel setAttributedText:oldGoodAtt];
//    [registerBtn setTitleColor:[UIColor colorWithWhite:120/255.0 alpha:1] forState:UIControlStateNormal];
//    [registerBtn setFrame:CGRectMake(120, loginBtn.bottom+12, 70, 15)];
//    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    [registerBtn addTarget:self action:@selector(registerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
//    [bgScrollView addSubview:registerBtn];
//    
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(40, 508, 240, 1)];
//    [line setBackgroundColor:[UIColor colorWithWhite:221/255.0 alpha:1]];
//    [bgScrollView addSubview:line];

//    //游客访问按钮
//    UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [visitBtn setTitle:@"游客访问" forState:UIControlStateNormal];
//    [visitBtn setTitleColor:[UIColor colorWithWhite:120/255.0 alpha:1] forState:UIControlStateNormal];
//    [visitBtn setFrame:CGRectMake(130, line.bottom+10, 70, 15)];
//    [visitBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    [visitBtn addTarget:self action:@selector(visitBtnPressed) forControlEvents:UIControlEventTouchUpInside];
//    [bgScrollView addSubview:visitBtn];

    
}

-(void)loginAdmin
{
    
    UITextField *admin = (UITextField *)[self.view viewWithTag:1];
    UITextField *password = (UITextField *)[self.view viewWithTag:2];
    if (admin.text.length!=18&&admin.text.length!=11) {
        [ProgressHUD showError:@"请输入正确的用户名"];
        return;
        
    }
    if (admin.text.length<6) {
        [ProgressHUD showError:@"密码长度不得小于6位"];
        return;

    }
    
    [ProgressHUD show:@"加载中"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];

    //你的接口地址
    NSString *url=[NSString stringWithFormat:@"%@/user/login",SERVERURL];
    NSDictionary *parameter = @{@"uname":admin.text,@"password":password.text,@"deviceType":@"2"};
    
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", dict);
        
        if (dict) {
            if ([[dict objectForKey:@"result"] boolValue]) {
                [PublicMethod setObject:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"resident"] objectForKey:@"communityId"] ]key:@"cid"];
                [PublicMethod setObject:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"resident"] objectForKey:@"idno"] ]key:@"idno"];
                [PublicMethod setObject:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"resident"] objectForKey:@"id"] ]key:@"id"];
                [PublicMethod setObject:[NSString stringWithFormat:@"%@",admin.text ]key:@"uname"];
                
                [PublicMethod setObject:[NSString stringWithFormat:@"YES"]key:@"isLogin"];
                
                
                
                
                [UIApplication sharedApplication].keyWindow.rootViewController = [PublicMethod getTabber];
                
                
                

                [ProgressHUD showSuccess:@"登陆成功！"];
                
                
                
                
            }else if([[dict objectForKey:@"code"] isEqualToString:@"E001"]){

                [ProgressHUD showError:@"账号已在别处登录！"];
                [PublicMethod setObject:[NSString stringWithFormat:@"NO"]key:@"isLogin"];

            }else{
                [ProgressHUD showError:@"用户名密码错误！"];
                [PublicMethod setObject:[NSString stringWithFormat:@"NO"]key:@"isLogin"];

            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [PublicMethod setObject:[NSString stringWithFormat:@"NO"]key:@"isLogin"];

        [ProgressHUD showError:@"网络连接失败"];
        NSLog(@"网络连接失败");

    }];
    

    
    
   
}
//代理方法:判断是否为正确的手机号码
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1) {
        
        
        
          }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

-(void)seePassword
{
    UITextField *inputTExt = (UITextField *)[self.view viewWithTag:2];
    [inputTExt setSecureTextEntry:NO];
    
}
-(void)hidenPassword
{
    UITextField *inputTExt = (UITextField *)[self.view viewWithTag:2];
    [inputTExt setSecureTextEntry:YES];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i = 1; i<3; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i];
        [inputTExt resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
