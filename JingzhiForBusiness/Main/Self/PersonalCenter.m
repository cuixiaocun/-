//
//  PersonalCenter.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/5/25.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PersonalCenter.h"
#import "XYMScanViewController.h"
#import "QRCodeGenerator.h"
#import "LoginPage.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "NextDelegateVC.h"//下级代理
#import "DelegateExamineVC.h"//代理审核
#import "StockTableviewVC.h"//库存
#import "ManageAddressTableVC.h"
#import "ChangePasswordVC.h"
#import "RegisterAndGoods.h"
#import "MyCustomerVC.h"
#import "WithDrawlsMoneyVC.h"
#import "CirculationRecordVC.h"
#import "CirculationRecordVC.h"
#import "MemberOrderVC.h"
#import "BankCardListVC.h"
#import "RebateVC.h"
#import "MyAuthorizationVC.h"
#import "HomePage.h"
#import "IsTureAlterView.h"
#import "DelegateCenterVC.h"
#import "ShoppingCartVC.h"
#import "HYPersonalCenterVC.h"
#import "OrderCirclatonVC.h"
@interface PersonalCenter ()<SRActionSheetDelegate,IsTureAlterViewDelegate,RDVTabBarControllerDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    NSString *levelString;//代理升级的时候选择的代理
    NSDictionary*dic;
}
@end
@implementation PersonalCenter
- (void)viewWillAppear:(BOOL)animated
{
    
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    if (![PublicMethod getDataStringKey:@"IsLogin"]) {//若没登录请登录
        LoginPage*logP =[[LoginPage alloc]init];
        [self.navigationController pushViewController:logP animated:YES];
    
        return;
    }
    dic =[[NSDictionary alloc]init];

    dic  =[PublicMethod getDataKey:agen];

    UILabel *levelLabel =[self.view viewWithTag:3331];
    levelLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"name"])?@"":[dic objectForKey:@"name"]];
    
    UILabel *telphoneL =[self.view viewWithTag:3332];
    telphoneL.text=[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"account"])?@"":[dic objectForKey:@"account"]];


}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    
//    //替代导航栏的imageview
//    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
//    topImageView.userInteractionEnabled = YES;
//    topImageView.backgroundColor = NavColor;
//    [self.view addSubview:topImageView];
//    
//    //注册标签
//    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
//    [navTitle setText:@"个人中心"];
//    [navTitle setTextAlignment:NSTextAlignmentCenter];
//    [navTitle setBackgroundColor:[UIColor clearColor]];
//    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
//    [navTitle setNumberOfLines:0];
//    [navTitle setTextColor:[UIColor whiteColor]];
//    [self.view addSubview:navTitle];
//    
    [self mainView];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 80, 40);
//    btn.center = self.view.center;
//    btn.backgroundColor = [UIColor blueColor];
//    [btn setTitle:@"开始扫码" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btn];
}
- (void)mainView
{

    
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator =
    NO;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1300*Width)];
    //上面的image
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Width*300)];
    bgImageV.backgroundColor = [UIColor colorWithRed:241/255.0 green:80/255.0 blue:84/255.0 alpha:1];
    [bgImageV setImage:[UIImage imageNamed:@"bg_wo_top"]];
    [bgScrollView addSubview:bgImageV];
    //头像外环
    UIImageView *bgtouImg =[[UIImageView alloc]init] ;
    [bgtouImg setFrame:CGRectMake(42*Width, 120*Width, 112*Width, 112*Width)];
    bgtouImg.userInteractionEnabled =YES;
    [bgtouImg setBackgroundColor:[UIColor colorWithRed:244/255.0 green:170/255.0 blue:170/255.0 alpha:1]];
    [bgImageV addSubview:bgtouImg];
    [bgtouImg.layer setCornerRadius:112*Width/2];
    [bgtouImg.layer setMasksToBounds:YES];
    
    //头像
    EGOImageView *touImageV = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
    [touImageV setFrame:CGRectMake(9*Width, 9*Width, 94*Width, 94*Width)];
//    [touImageV setImageURL:[NSURL URLWithString:headString]];
    [touImageV setImage:[UIImage imageNamed:@"proxy_icon_header"]];
    
    [touImageV.layer setCornerRadius:94*Width/2];
    touImageV.tag =3330;
    touImageV.userInteractionEnabled =YES;
    [touImageV.layer setMasksToBounds:YES];
    [bgtouImg addSubview:touImageV];
    
    //代理
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+24*Width,bgtouImg.top, 400*Width, 60*Width)];
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.tag =3331;
    ;
                
    levelLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"name"])?@"":[dic objectForKey:@"name"]];
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.font = [UIFont boldSystemFontOfSize:16];
    
    levelLabel.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:levelLabel];
   
    //电话
    UILabel *telphoneL = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+24*Width,levelLabel.bottom, 400*Width, 60*Width)];
    telphoneL.textColor = [UIColor whiteColor];
    telphoneL.tag =3332;
    telphoneL.text=[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"account"])?@"":[dic objectForKey:@"account"]];
    telphoneL.textAlignment = NSTextAlignmentLeft;
    telphoneL.font = [UIFont boldSystemFontOfSize:15];
    telphoneL.textColor = [UIColor whiteColor];
    [bgImageV addSubview:telphoneL];
    
    //头像按钮
    UIButton *topbtn =[[UIButton alloc]initWithFrame:CGRectMake(0,120*Width,CXCWidth, 210*Width)];
    [bgScrollView addSubview:topbtn];
    [topbtn addTarget:self action:@selector(selfCenter) forControlEvents:UIControlEventTouchUpInside];
    //右箭头图片
    UIImageView*jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(672*Width, telphoneL.top-30*Width, 32*Width, 52*Width)];
    [bgImageV addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"proxy_btn_me_next"]];
    
    
    NSArray *topArr =@[@"proxy_me_icon_kucun",@"proxy_me_icon_xiaji",@"proxy_me_icon_kehu",@"proxy_me_icon_dizhi",@"proxy_me_icon_mima",@"proxy_me_icon_shengji",@"proxy_me_icon_tixian",@"proxy_me_icon_liuzhuan",@"proxy_me_icon_orderliu",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"proxy_me_icon_exit",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];

    NSArray*bottomArr =@[@"库存",@"下级代理",@"我的客户",@"收货地址",@"密码修改",@"申请升级",@"提现",@"订单流转",@"审核流转",@"会员订单",@"银行卡",@"返佣",@"代理审核",@"我的授权",@"退出",@"",] ;
    for (int i=0; i<15; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(187*Width*(i%4),bgImageV.bottom+20*Width+187.5*Width*(i/4),186*Width,186*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(52*Width,45*Width,83.5*Width,60*Width)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
        topImgV.tag =1100+i;
        [btn addSubview:topImgV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom,187*Width,60*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.textColor =BlackColor;
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
    }
    





}
- (void)selfCenter
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    DelegateCenterVC *log =[[DelegateCenterVC alloc]init];
    [self.navigationController pushViewController:log animated:YES];
    


}
-(void)myBtnAciton:(UIButton *)btn
{

    if (btn.tag==300) {//库存
        StockTableviewVC*stockVC =[[StockTableviewVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController  pushViewController:stockVC animated:YES];
     
    }else if (btn.tag==301)//下级代理
    {
        NextDelegateVC*next =[[NextDelegateVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

        [self.navigationController  pushViewController:next animated:YES];

    
    }else if (btn.tag==302)//我的客户
    {
        MyCustomerVC *myCustomerVC =[[MyCustomerVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController  pushViewController:myCustomerVC animated:YES];
        
    }
    else if (btn.tag==303)//收货地址
    {
        ManageAddressTableVC *manageAdd =[[ManageAddressTableVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

        [self.navigationController pushViewController:manageAdd animated:YES];
        
    }
    else if (btn.tag==304)//修改密码
    {
        ChangePasswordVC *changeVC =[[ChangePasswordVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }
    else if (btn.tag==305)//申请升级
    {
        
        //选择代理
        SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"选择代理级别"
                                                                    cancelTitle:@"取消"
                                                               destructiveTitle:nil
                                                                     withNumber:@"7"
                                                                 withLineNumber:@"1"
                                                                    otherTitles:@[@"一级代理",@"二级代理",@"三级代理",@"四级代理",@"五级代理",@"六级代理"]
                                                                    otherImages:nil
                                                              selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                                  
                                                                  if (index>5||index<0) {
                                                                      return;
                                                                  }
                                                                  levelString =[NSString stringWithFormat:@"%ld",index];
                                                                  [self upLevel];
                                                                  
                                                                  
                                                                  NSLog(@"%zd", index);
                                                              }];
        actionSheet.number=@"7";
        actionSheet.lineNumber=@"1";
        
        [actionSheet show];
        

        
    }
    else if (btn.tag==306)//提现管理
    {
        WithDrawlsMoneyVC *withdrawlsVC =[[WithDrawlsMoneyVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:withdrawlsVC animated:YES];
        
    }
    else if (btn.tag==307)//订单流转
    {
        CirculationRecordVC *withdrawlsVC =[[CirculationRecordVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:withdrawlsVC animated:YES];
        
    }
    else if (btn.tag==308)//审核流转
    {
        OrderCirclatonVC *withdrawlsVC =[[OrderCirclatonVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:withdrawlsVC animated:YES];
        
    }
    else if (btn.tag==309)//会员订单
    {
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        MemberOrderVC *memberVC =[[MemberOrderVC alloc]init];
        [self.navigationController pushViewController:memberVC animated:YES];
        

        
    }
    else if (btn.tag==310)//银行卡
    {
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        BankCardListVC *bankCard =[[BankCardListVC alloc]init];
        [self.navigationController pushViewController:bankCard animated:YES];
//        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//        BankCardVC *bankCard =[[BankCardVC alloc]init];
//        [self.navigationController pushViewController:bankCard animated:YES];
        

        
    }
    else if (btn.tag==311)//返佣
    {
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        RebateVC *rebateVC =[[RebateVC alloc]init];
        [self.navigationController pushViewController:rebateVC animated:YES];
        
    }
    else if (btn.tag==312)//代理审核
    {
        DelegateExamineVC *delegateEx =[[DelegateExamineVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:delegateEx animated:YES];
        
    }
    else if (btn.tag==313)//我的授权
    {
        MyAuthorizationVC *myAuth =[[MyAuthorizationVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

        [self.navigationController pushViewController:myAuth animated:YES];
        
    }else if (btn.tag ==314)
    {
        
        
        IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要退出吗？"];
        isture.delegate =self;
        isture.tag =180;
        [self.view addSubview:isture];
        
        NSLog(@"showalert");
        
    }



}
- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)buttonIndex
{
    
}
- (void)upLevel
{
    RegisterAndGoods*changeVC =[[RegisterAndGoods alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    changeVC.levelString =levelString;
    changeVC.navTitle =@"代理升级";
    [self.navigationController pushViewController:changeVC animated:YES];
}


-(void)startScan{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancelBtnActinAndTheAlterView:(UIView *)alter
{
    IsTureAlterView *isture = [self.view viewWithTag:180];
    [isture removeFromSuperview];
    NSLog(@"取消");
    
}
-(void)tureBtnActionAndTheAlterView:(UIView *)alter
{
    IsTureAlterView *isture = [self.view viewWithTag:180];
    
    [isture removeFromSuperview];
    NSLog(@"确认");
    
    //删除
    [PublicMethod removeObjectForKey: @"IsLogin"];
    [PublicMethod removeObjectForKey: member];
    [self setupViewControllersHYwithIsBack:@"YES"];
    
}
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
        [tabBarController setSelectedIndex:0];//若果是返回按钮
        
    }else
    {
        [tabBarController setSelectedIndex:2];//若果是登录按钮
        
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

@end
