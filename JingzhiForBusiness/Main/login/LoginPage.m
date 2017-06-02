 //
//  LoginPage.m
//  Demo_simple
//
//  Created by Eleven on 15/4/19.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "LoginPage.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "ShoppingCartVC.h"
#import "PersonalCenter.h"
#import "HomePage.h"
#import "RegisteredVC.h"
@interface LoginPage ()
{

    UIButton *loginBtn;
}
@end

@implementation LoginPage
- (void)viewWillAppear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    UIImageView*bgImg =[[UIImageView alloc]init];
    bgImg.backgroundColor=[UIColor whiteColor];
    [topImageView addSubview:bgImg];
    bgImg.layer.cornerRadius=4;
    [bgImg   setFrame:CGRectMake(183*Width, 19, 386*Width, 60*Width)];
    

    //会员
    UIButton *hyBtn =[[UIButton alloc]initWithFrame:CGRectMake(185*Width, 20, 190*Width, 56*Width)];
    [hyBtn setBackgroundColor:[UIColor whiteColor]];
    hyBtn.selected=YES;

    if (hyBtn.selected==YES) {
        [hyBtn setBackgroundColor:[UIColor whiteColor]];
    }else
    {
        [hyBtn setBackgroundColor:NavColor];
    }
    [hyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hyBtn setTitleColor:NavColor forState:UIControlStateSelected];
    [hyBtn setTitle:@"会员登录" forState:UIControlStateNormal];
    [hyBtn setTitle:@"会员登录" forState:UIControlStateSelected];
    hyBtn.tag =120;
    hyBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    hyBtn.layer.cornerRadius=4;

    [hyBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:hyBtn];

    //代理
    UIButton *dlBtn =[[UIButton alloc]initWithFrame:CGRectMake(hyBtn.right, 20, 190*Width, 56*Width)];
    [dlBtn setBackgroundColor:[UIColor whiteColor]];
    dlBtn.selected=NO;
    dlBtn.layer.cornerRadius=4;

    if (dlBtn.selected==YES) {
        [dlBtn setBackgroundColor:[UIColor whiteColor]];
    }else
    {
        [dlBtn setBackgroundColor:NavColor];
    }
    dlBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [dlBtn setTitle:@"代理登录" forState:UIControlStateNormal];
    [dlBtn setTitle:@"代理登录" forState:UIControlStateSelected];
    [dlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dlBtn setTitleColor:NavColor forState:UIControlStateSelected];
    [topImageView addSubview:dlBtn];
    dlBtn.tag =121;
    [dlBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];

    [topImageView addSubview:dlBtn];
    [self  mainView];
}
- (void)mainView
{

    
    //底部scrollview
    UIScrollView *bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1000)];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 194)];
    [titleImage setImage:[UIImage imageNamed:@"login_title.png"]];
    [bgScrollView addSubview:titleImage];
    
    NSArray *rightArr =@[@"请输入账号",@"请输入密码"];
    NSArray *leftArr =@[@"账号",@"密码"];
    
    
    for (int i =0; i<2; i++) {
        
        UIImageView *textBg = [[UIImageView alloc] init];
        
        [textBg setUserInteractionEnabled:YES];
        [textBg setFrame:CGRectMake(0, 20*Width+106*Width*i, CXCWidth,106*Width )];
        [bgScrollView addSubview:textBg];
        UILabel*  labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.tag = 10101010;
        labe.text = leftArr[i];
        labe.font = [UIFont boldSystemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [textBg addSubview:labe];
        
        UITextField *inputText = [[UITextField alloc] init];
        [inputText setTag:i+1];
        if (i==0) {
            [inputText setKeyboardType:UIKeyboardTypePhonePad];
        }else
        {
            inputText.secureTextEntry =YES;
        }
        [inputText setPlaceholder:rightArr[i]];
        [inputText setDelegate:self];
        [inputText setFont:[UIFont systemFontOfSize:18]];
        [inputText setTextColor:[UIColor blackColor]];
        
        [inputText setFrame:CGRectMake(140*Width, 0,580*Width,106*Width)];
        [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textBg addSubview:inputText];
        
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [textBg addSubview:xian];
        xian.frame =CGRectMake(0,104*Width, CXCWidth, 2*Width);
        
        textBg.backgroundColor =[UIColor whiteColor ];
        
        
    }
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame:CGRectMake(40*Width,232*Width+106*Width , 670*Width, 88*Width)];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:91/255.0 blue:94/255.0 alpha:1]];
    [loginBtn.layer setCornerRadius:4];
    [loginBtn.layer setMasksToBounds:YES];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [loginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [loginBtn addTarget:self action:@selector(loginAdmin) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:loginBtn];
    
    //忘记密码按钮
    UIButton *RegisteredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [RegisteredBtn setTitle:@"注册" forState:UIControlStateNormal];
    [RegisteredBtn setTitleColor:NavColor forState:UIControlStateNormal];
    [RegisteredBtn setFrame:CGRectMake(40*Width, loginBtn.bottom, 200*Width, 90*Width)];
    [RegisteredBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [RegisteredBtn addTarget:self action:@selector(registerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:RegisteredBtn];
    
    RegisteredBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    
    
    
    
    //忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [forgetBtn setFrame:CGRectMake(510*Width, loginBtn.bottom, 200*Width, 90*Width)];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [forgetBtn addTarget:self action:@selector(forgetBtn) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:forgetBtn];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

}
- (void)registerBtnPressed
{
    RegisteredVC *registeredVC =[[RegisteredVC alloc]init];
    [self.navigationController   pushViewController:registeredVC animated:YES];
    
    
    
}
- (void)forgetBtn
{



}
-(void)loginAdmin
{
    [self setupViewControllers];
    
    
    [PublicMethod saveDataString:@"1" withKey:@"WetherFirstInput"];
    
    UITextField *admin = (UITextField *)[self.view viewWithTag:1];
    UITextField *password = (UITextField *)[self.view viewWithTag:2];
    if (admin.text.length!=18&&admin.text.length!=11) {
        [ProgressHUD showError:@"请输入正确的用户名"];
        return;
        
    }
    if (password.text.length<8) {
        [ProgressHUD showError:@"密码长度不得小于6位"];
        return;

    }
    
//    [ProgressHUD show:@"加载中"];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
//    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];
//
//    //你的接口地址
//    NSString *url=[NSString stringWithFormat:@"%@/user/login",SERVERURL];
//    NSDictionary *parameter = @{@"uname":admin.text,@"password":password.text,@"deviceType":@"2"};
//    
//    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"请求成功JSON:%@", dict);
//        
//        if (dict) {
//            if ([[dict objectForKey:@"result"] boolValue]) {
//                [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"resident"] objectForKey:@"communityId"] ]withKey:@"cid"];
//                [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"resident"] objectForKey:@"idno"] ]withKey:@"idno"];
//                [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"resident"] objectForKey:@"id"] ]withKey:@"id"];
//                [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",admin.text ]withKey:@"uname"];
//                
//                [PublicMethod saveDataString:[NSString stringWithFormat:@"YES"]withKey:@"isLogin"];
//                
//                
//                [self setupViewControllers];
//                
//                
//                [PublicMethod saveDataString:@"1" withKey:@"WetherFirstInput"];
//                [ProgressHUD showSuccess:@"登陆成功！"];
//                
//                
//                
//                
//            }else if([[dict objectForKey:@"code"] isEqualToString:@"E001"]){
//
//                [ProgressHUD showError:@"账号已在别处登录！"];
//                [PublicMethod saveDataString:@"0" withKey:@"WetherFirstInput"];
//
//            }else{
//                [ProgressHUD showError:@"用户名密码错误！"];
//                [PublicMethod saveDataString:@"0" withKey:@"WetherFirstInput"];
//
//            }
//            
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [PublicMethod saveDataString:@"0" withKey:@"WetherFirstInput"];
//
//        [ProgressHUD showError:@"网络连接失败"];
//        NSLog(@"网络连接失败");
//
//    }];
//    
//
//    
//    
   
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{


  

    return YES;
    
}
//代理方法:判断是否为正确的手机号码
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    UITextField *textFOne =[self.view viewWithTag:1];
    UITextField *textFTwo =[self.view viewWithTag:2];
    NSString *one =textFOne.text;
    NSString *two =textFTwo.text;
    if (textField.tag==1) {
        one =[textField.text stringByReplacingCharactersInRange:range withString:string];;
        
    }else
    {
        two =[textField.text stringByReplacingCharactersInRange:range withString:string];;

    
    }

    
    if(one.length>0&&two.length>0)
    {
        [loginBtn setBackgroundColor:NavColor];
        
        
    }else
    {
        [loginBtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:91/255.0 blue:94/255.0 alpha:1]];
        
        
    }
    
    
    
    if (textField.tag == 1) {
        
        }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
+(BOOL)isMobileNumber:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *////将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
    NSInteger subStrIndex= [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
    NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
    idCardWiSum+= subStrIndex * idCardWiIndex;
   }
   //计算出校验码所在数组的位置
   NSInteger idCardMod=idCardWiSum%11;
   //得到最后一位身份证号码
   NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
    if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
     return NO;
    }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return NO;
           }
        }
    return YES;
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
- (void)setupViewControllers {
    //    if ([[PublicMethod getDataStringKey:@"WetherFirstInput"]isEqualToString:@"1"]) {//若为1，表示登录了
    [PublicMethod saveDataString:@"1" withKey:@"WetherFirstInput"];//是否第一次进入
    
    UIViewController *firstViewController = [[HomePage alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[ShoppingCartVC alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *threeViewController = [[PersonalCenter alloc] init];
    UIViewController *threeNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:threeViewController];
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,threeNavigationController]];
    [UIApplication sharedApplication].keyWindow.rootViewController =tabBarController ;
    [self customizeTabBarForController:tabBarController];
    
    //    }else//若不为1表示没登录
    //    {
    //        LoginPage *rootViewController = [[LoginPage alloc] init];
    //        UINavigationController* _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    //        self.viewController =_navigationController;
    //
    //    }
    
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"tab_home", @"tab_card",@"tab_card"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_pre.png",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        NSLog(@"%@",[NSString stringWithFormat:@"%@_pre",
                     [tabBarItemImages objectAtIndex:index]]);
        index++;
    }
}
- (void)login:(UIButton *)btn
{
    for (int i=0; i<2; i++) {
        
        UIButton *btnAll =[self.view viewWithTag:120+i];
        btnAll.selected =NO;
        [btnAll setBackgroundColor:[UIColor redColor]];

    }
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    btn.selected =YES;
    



}
- (void)returnBtnAction
{

    [self.navigationController   popViewControllerAnimated:YES];
    

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
