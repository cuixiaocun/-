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
#import "DeclarationCenterVC.h"
#import "OrderCenterVC.h"
#import "HYPersonalCenterVC.h"
#import "HYRegisteredVC.h"
@interface LoginPage ()
{
    UIButton *loginBtn;
    NSString *isLeveler;//yes==代理 no==会员
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
    isLeveler =@"NO";
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
    bgImg.userInteractionEnabled = YES;

    bgImg.layer.cornerRadius=2;
    [bgImg setFrame:CGRectMake(183*Width, 20+(44-56*Width)/2-1, 384*Width, 60*Width)];
    

    //会员
    UIButton *hyBtn =[[UIButton alloc]initWithFrame:CGRectMake(2*Width, 2*Width, 190*Width, 56*Width)];
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
//    hyBtn.layer.cornerRadius=4;

    [hyBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [bgImg addSubview:hyBtn];

    //代理
    UIButton *dlBtn =[[UIButton alloc]initWithFrame:CGRectMake(hyBtn.right,2*Width, 190*Width, 56*Width)];
    [dlBtn setBackgroundColor:[UIColor whiteColor]];
    dlBtn.selected=NO;
//    dlBtn.layer.cornerRadius=4;

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

    [bgImg addSubview:dlBtn];
    [self  mainView];
}
- (void)mainView
{
    //底部scrollview
    UIScrollView *bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator =
    NO;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1300*Width)];
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
    if ([isLeveler isEqualToString:@"NO"]) {
        
        HYRegisteredVC *hyRegisteredVC =[[HYRegisteredVC alloc]init];
        [self.navigationController pushViewController:hyRegisteredVC animated:YES];
        
        
    }else if ([isLeveler isEqualToString:@"YES"])
    {
        RegisteredVC *registeredVC =[[RegisteredVC alloc]init];
        [self.navigationController   pushViewController:registeredVC animated:YES];
    }

   
}
- (void)forgetBtn
{



}
-(void)loginAdmin
{
    
//    UITextField *admin = (UITextField *)[self.view viewWithTag:1];
//    UITextField *password = (UITextField *)[self.view viewWithTag:2];
//    if (admin.text.length!=18&&admin.text.length!=11) {
//        [MBProgressHUD showError:@"请输入正确的用户名" ToView:self.view];
//        return;
//    }
//    if (password.text.length<6) {
//        [MBProgressHUD showError:@"密码长度不得小于6位" ToView:self.view];
//        return;
//    }
    NSString *statustring ;//判断状态
    if ([isLeveler isEqualToString:@"YES"]) {
        statustring =@"2";
    }else if([isLeveler isEqualToString:@"NO"]){
        statustring =@"1";
    }
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"logintype":@"1",@"account":[NSString stringWithFormat:@"%@",@"15610280531"],@"password":@"111111"}];
//    [dic1 setDictionary:@{@"logintype":statustring ,@"account":[NSString stringWithFormat:@"%@",admin.text],@"password":[NSString stringWithFormat:@"%@",password.text]}];
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"Home/Login/login" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            if ([isLeveler isEqualToString:@"NO"]) {
                if ([_status isEqualToString:@"present"]) {
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }else
                {
                    
                    [self rdv_tabBarController].selectedIndex=2;
                    [self setupViewControllersHYwithIsBack:@"NO"];
                    [self.navigationController popViewControllerAnimated:YES];

                }
                [PublicMethod saveDataString:@"HY" withKey:@"IsLogin"];
                [PublicMethod saveData:dict withKey:@"member"];

                
            }else if ([isLeveler isEqualToString:@"YES"])
            {
                [self rdv_tabBarController].selectedIndex=2;
                [self setupViewControllers];
                [PublicMethod saveDataString:@"DL" withKey:@"IsLogin"];
                
            }
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
   
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
        
        
        
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
            if (existedLength - selectedLength + replaceLength >= 12) {
                
                [textField resignFirstResponder];
                return NO;
                
        }
        
        
        
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
    
    UIViewController *firstViewController = [[DeclarationCenterVC alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstNavigationController setNavigationBarHidden:YES];

    UIViewController *secondViewController = [[OrderCenterVC alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondNavigationController setNavigationBarHidden:YES];

    UIViewController *threeViewController = [[PersonalCenter alloc] init];
    UINavigationController *threeNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:threeViewController];
    [threeNavigationController setNavigationBarHidden:YES];

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
    NSArray *tabBarItemImages = @[@"proxy_icon_baodan", @"proxy_icon_order",@"proxy_icon_me"];
    
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
- (void)login:(UIButton *)btn//判断是会员还是代理
{
    for (int i=0; i<2; i++) {
        UIButton *btnAll =[self.view viewWithTag:120+i];
        btnAll.selected =NO;
        [btnAll setBackgroundColor:NavColor];
    }
    if(btn.tag==120)
    {
        isLeveler=@"NO";//会员登录
        
    }else
    {
        isLeveler=@"YES";//代理登录
    }
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.selected =YES;
    



}
- (void)returnBtnAction
{
    if ([_status isEqualToString:@"present"]) {
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }else
    {
        [self setupViewControllersHYwithIsBack:@"YES"];

    }

    


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setupViewControllersHYwithIsBack:(NSString *)isBackString{
    //    if ([[PublicMethod getDataStringKey:@"WetherFirstInput"]isEqualToString:@"1"]) {//若为1，表示登录了
    //        [PublicMethod saveDataString:@"1" withKey:@"WetherFirstInput"];//是否第一次进入
    //
    UIViewController *firstViewController = [[HomePage alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]initWithRootViewController:firstViewController];
    [firstNavigationController setNavigationBarHidden:YES];
    
    UIViewController *secondViewController = [[ShoppingCartVC alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:secondViewController];
    [secondNavigationController setNavigationBarHidden:YES];
    
    UIViewController *threeViewController = [[HYPersonalCenterVC alloc] init];
    UINavigationController *threeNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:threeViewController];
    [threeNavigationController setNavigationBarHidden:YES];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,threeNavigationController]];
    [UIApplication sharedApplication].keyWindow.rootViewController =tabBarController ;
//    [[self rdv_tabBarController].tabBar.delegate tabBar: [self rdv_tabBarController].tabBar didSelectItemAtIndex:2];

    [self customizeTabBarForControllerHY:tabBarController andBackString:isBackString] ;
    
    //    }else//若不为1表示没登录
    //    {
    //        LoginPage *rootViewController = [[LoginPage alloc] init];
    //        UINavigationController* _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    //        self.viewController =_navigationController;
    //        [_navigationController setNavigationBarHidden:YES];
    //
    //    }
    //
}
- (void)customizeTabBarForControllerHY:(RDVTabBarController *)tabBarController andBackString:(NSString*)isBackString {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"huiyuan_icon_home", @"huiyuan_icon_cart",@"proxy_icon_me"];
    
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
    if ([isBackString isEqualToString:@"YES"]) {
        [tabBarController setSelectedIndex:0];//若是返回按钮
        
    }else
    {
        [tabBarController setSelectedIndex:2];//若是登录按钮
        
    }

}

@end
