//
//  HYPersonalCenterVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYPersonalCenterVC.h"//会员的个人中心
#import "LoginPage.h"
#import "ManageAddressTableVC.h"
#import "ChangePasswordVC.h"
#import "FundrecordVC.h"
#import "PersonalDetail.h"
#import "HYQRCodeVC.h"
#import "XYMScanViewController.h"
#import "IsTureAlterView.h"
#import "HYMyOrderVC.h"
#import "HYMyRecommendVC.h"
@interface HYPersonalCenterVC ()<LoginDelegate,IsTureAlterViewDelegate  >
{
    //底部scrollview
    UIScrollView *bgScrollView;
}
@end

@implementation HYPersonalCenterVC
- (void)viewWillAppear:(BOOL)animated
{
    [self viewWillAppearLogin];
}
- (void)viewWillAppearLogin
{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    if (![PublicMethod getDataStringKey:@"IsLogin"]) {//若没登录请登录

        LoginPage *rootViewController = [[LoginPage alloc] init];
        UINavigationController* _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        [UIApplication sharedApplication].keyWindow.rootViewController =_navigationController ;

        [_navigationController setNavigationBarHidden:YES];
        return;
    }else
    {
        NSDictionary*dic =[[NSDictionary alloc]init];
        dic  =[PublicMethod getDataKey:member];
        UILabel *nameLabel =[self.view viewWithTag:3331];
        UILabel *phoneLabel =[self.view viewWithTag:3332];
        nameLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"name"])?@"":[dic objectForKey:@"name"]];
        phoneLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"account"])?@"":[dic objectForKey:@"account"]];
    }

}
-(void)backBecauseBackNarrow
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    [self mainView];

}
- (void)mainView
{
    NSDictionary*dic =[[NSDictionary alloc]init];
    dic  =[PublicMethod getDataKey:member];
    
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1200*Width)];
    
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
    [bgImageV   addSubview:telphoneL];
    
    //头像按钮
    UIButton *topbtn =[[UIButton alloc]initWithFrame:CGRectMake(0,120*Width,CXCWidth, 210*Width)];
    [bgScrollView addSubview:topbtn];
    [topbtn addTarget:self action:@selector(selfCenter) forControlEvents:UIControlEventTouchUpInside];
    //右箭头图片
    UIImageView*jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(672*Width, telphoneL.top-30*Width, 32*Width, 52*Width)];
    [bgImageV addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"proxy_btn_me_next"]];
    
    
    NSArray *topArr =@[@"vip_wo_icon_tuijian",@"vip_wo_icon_order",@"vip_wo_icon_adress",@"vip_wo_icon_cash",@"vip_wo_icon_qrcode",@"vip_wo_icon_pwd",@"vip_wo_icon_true",@"vip_wo_icon_exit",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    
    NSArray*bottomArr =@[@"我的推荐",@"我的订单",@"收货地址",@"资金券记录",@"推广二维码",@"修改密码",@"防伪查询",@"退出登录",@"",@"",@"",] ;
    for (int i=0; i<9; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(250*Width*(i%3),bgImageV.bottom+20*Width+250*Width*(i/3),249*Width,249*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        if(i<8)
        {
            //上边图片
            UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(87.5*Width,66*Width,75*Width,64*Width)];
            topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
            topImgV.tag =1100+i;
            [btn addSubview:topImgV];
            //下边文字
            UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom,250*Width,85*Width)];
            botLabel.textAlignment=NSTextAlignmentCenter;
            botLabel.font =[UIFont systemFontOfSize:14];
            botLabel.textColor =[UIColor    blackColor];
            botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
            [btn addSubview:botLabel];
            [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;

        }
        

    }
        
    
    
}
- (void)selfCenter
{
    PersonalDetail *viewController =[[PersonalDetail alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {
        HYMyRecommendVC *viewController=[[HYMyRecommendVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==301) {
        
        HYMyOrderVC *viewController =[[HYMyOrderVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];

    }else if (btn.tag ==302) {
        ManageAddressTableVC *viewController =[[ManageAddressTableVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (btn.tag ==303) {
        FundrecordVC *viewController =[[FundrecordVC alloc]init];
        
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:viewController animated:YES];

        
    }else if (btn.tag ==304) {
        
        HYQRCodeVC *viewController =[[HYQRCodeVC alloc]init];
        
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (btn.tag ==305) {
        
        ChangePasswordVC *viewController =[[ChangePasswordVC alloc]init];
        
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (btn.tag ==306) {
        
        XYMScanViewController *viewController =[[XYMScanViewController alloc]init];
        
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        viewController.whichView =@"防伪查询";
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==307) {

        
        IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要退出吗？"];
        isture.delegate =self;
        isture.tag =180;
        [self.view addSubview:isture];
        
        NSLog(@"showalert");

    }

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
    
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setDictionary:@{
//                              @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]]
                              }];
        
        [PublicMethod AFNetworkPOSTurl:@"Home/Login/exitlogin" paraments:dic1  addView:self.view success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
        
                
                
                NSLog(@"确认");
                [[self rdv_tabBarController] setSelectedIndex:0];
                
                //删除
                [PublicMethod removeObjectForKey: @"IsLogin"];
                [PublicMethod removeObjectForKey: member];
                [PublicMethod removeObjectForKey: shopingCart];
                
            }
            
        } fail:^(NSError *error) {
            
        }];
        
    
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
