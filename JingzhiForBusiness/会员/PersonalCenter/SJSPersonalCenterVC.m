//
//  HYPersonalCenterVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//
#import "SJSPersonalCenterVC.h"//会员的个人中心
#import "LoginPage.h"
#import "FundrecordVC.h"
#import "PersonalDetail.h"
#import "HYQRCodeVC.h"
#import "IsTureAlterView.h"
#import "HYMyOrderVC.h"
#import "HYMyRecommendVC.h"
#import "ManageAddressTableVC.h"
#import "WithDrawDetail.h"
#import "MYTenderVC.h"
#import "MyAppointmentVC.h"
#import "AccoutSetVC.h"
#import "CouponViewController.h"
#import "DiaryofDecorateVC.h"

#import "MarkManageVC.h"
#import "MYSignUp.h"
@interface SJSPersonalCenterVC ()<LoginDelegate,IsTureAlterViewDelegate  >
{
    //底部scrollview
    UIScrollView *bgScrollView;
}
@end

@implementation SJSPersonalCenterVC
- (void)viewWillAppear:(BOOL)animated
{
    [self viewWillAppearLogin];
}
- (void)viewWillAppearLogin
{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    if (![PublicMethod getDataStringKey:@"IsLogin"]) {//若没登录请登录
        self.navigationController.navigationBarHidden =YES;
        // 新的
        LoginPage *viewController =[[LoginPage alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:NO];
        return;
    }else
    {
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setDictionary:@{}];
        [PublicMethod AFNetworkPOSTurl:@"mobileapi/index.php?ucenter/index-index.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController success:^(id responseDic) { NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            NSDictionary*dic =[[NSDictionary alloc]init];
            dic  =[PublicMethod getDataKey:member];
            UILabel *nameLabel =[self.view viewWithTag:3331];
            UILabel *phoneLabel =[self.view viewWithTag:3332];
            nameLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"name"])?@"":[dic objectForKey:@"name"]];
            phoneLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"account"])?@"":[dic objectForKey:@"account"]];
                self.navigationController.navigationBarHidden =YES;
            }else
            {
                
            }
            
        } fail:^(NSError *error) {
            
        }];
       
    }

}
-(void)backBecauseBackNarrow
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if (@available(iOS 11.0, *)) {
        bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
                self.edgesForExtendedLayout = UIRectEdgeNone;
            }
    }

    [self mainView];
}
- (void)mainView
{
    NSDictionary*dic =[[NSDictionary alloc]init];
    dic  =[PublicMethod getDataKey:member];
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    
    //上面的image
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Width*550)];
    bgImageV.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:bgImageV];
    UIImageView *topImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Width*410)];
    topImageV.backgroundColor = [UIColor whiteColor];
    [topImageV setImage:[UIImage imageNamed:@"me_icon_topbg"]];
    [bgImageV addSubview:topImageV];

    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CXCWidth-44, 20, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"meicon_shezhi"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [bgScrollView   addSubview:rightBtn];

        //头像外环
    UIImageView *bgtouImg =[[UIImageView alloc]init] ;
    [bgtouImg setFrame:CGRectMake(300*Width, 88*Width, 150*Width, 150*Width)];
    bgtouImg.userInteractionEnabled =YES;
    [bgtouImg setBackgroundColor:[UIColor colorWithRed:241/255.0 green:153/255.0 blue:102/255.0 alpha:1]];
    [bgImageV addSubview:bgtouImg];
    [bgtouImg.layer setCornerRadius:150*Width/2];
    [bgtouImg.layer setMasksToBounds:YES];
    
    //头像
    EGOImageView *touImageV = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"me_icon_head"]];
    [touImageV setFrame:CGRectMake(10*Width, 10*Width, 130*Width, 130*Width)];
    //    [touImageV setImageURL:[NSURL URLWithString:headString]];
    
    [touImageV.layer setCornerRadius:130*Width/2];
    touImageV.tag =3330;
    touImageV.userInteractionEnabled =YES;
    [touImageV.layer setMasksToBounds:YES];
    [bgtouImg addSubview:touImageV];
    
      //姓名
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,bgtouImg.bottom+20*Width,CXCWidth, 50*Width)];
    //_nameLabel =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"name"])?@"":[dic objectForKey:@"name"]];
    _nameLabel.text =@"王皓";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    _nameLabel.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:_nameLabel];

    
    //角色
    _roleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,_nameLabel.bottom,CXCWidth, 50*Width)];
    _roleLabel.textColor = [UIColor whiteColor];
    _roleLabel.text =@"设计师";
//    levelLabel.text =[NSString stringWithFormat:@"%@",IsNilString([dic objectForKey:@"name"])?@"":[dic objectForKey:@"name"]];
    _roleLabel.textAlignment = NSTextAlignmentCenter;
    _roleLabel.font = [UIFont boldSystemFontOfSize:15];
    _roleLabel.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:_roleLabel];
    
    NSArray *toptitleArr =@[@"1",@"22",@"1223",@"1",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    
    NSArray*bottomtitleArr =@[@"我的预约",@"我的招标",@"金币",@"优惠券"] ;
    
    
    for (int i=0; i<4; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(162.5*Width*i+(i+1)*20*Width,_roleLabel.bottom+60*Width,162.5*Width,132.5*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        if(i<4)
        {
            UILabel *topLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,10*Width,162.5*Width,50*Width)];
            topLabel.textAlignment=NSTextAlignmentCenter;
            topLabel.font =[UIFont systemFontOfSize:14];
            topLabel.textColor =[UIColor  blackColor];
            topLabel.text =[NSString stringWithFormat:@"%@",toptitleArr[i]];
            [btn addSubview:topLabel];
            [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
            
            //下边文字
            UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topLabel.bottom,162*Width,60*Width)];
            botLabel.textAlignment=NSTextAlignmentCenter;
            botLabel.font =[UIFont systemFontOfSize:14];
            botLabel.textColor =[UIColor    blackColor];
            botLabel.text =[NSString stringWithFormat:@"%@",bottomtitleArr[i]];
            [btn addSubview:botLabel];
        }
        
        
    }
    
    
    
    NSArray *topArr =@[@"me_icon_mall",@"me_icon_rj",@"me_icon_sjs",@"me_icon_quit",@"vip_wo_icon_qrcode",@"vip_wo_icon_pwd",@"vip_wo_icon_true",@"vip_wo_icon_exit",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    
    NSArray*bottomArr =@[@"商城订单",@"装修日记",@"设计师管理",@"退出登录",@"",] ;
    for (int i=0; i<4; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0,120*Width*i,CXCWidth,100*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+400;
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        //图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width,25*Width,40*Width,50*Width)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
        [btn addSubview:topImgV];
        //文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(topImgV.right+21*Width,0,250*Width,98.5*Width)];
        botLabel.font =[UIFont systemFontOfSize:14];
        botLabel.textColor =[UIColor   blackColor];
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 98.5*Width, 690*Width, 1.5*Width)];
        xian.backgroundColor =BGColor;
        [btn addSubview:xian];
        
        if (i==0) {
            btn.frame =CGRectMake(0,100*Width*i+bgImageV.bottom+20*Width,CXCWidth,100*Width);
        }else if (i==1) {
            btn.frame =CGRectMake(0,100*Width*i+bgImageV.bottom+20*Width,CXCWidth,100*Width);
        }else if (i==2) {
            NSArray *topArr =@[@"me_icon_bm",@"me_icon_zb",@"me_icon_yy",@"zx_icon_twt",];
            NSArray*bottomArr =@[@"我的报名",@"招标投标",@"预约管理",@"",@"",];

            for (int j=0; j<3; j++) {
                btn.frame =CGRectMake(0,100*Width*i+bgImageV.bottom+40*Width,CXCWidth,100*Width);                //大按钮
                UIButton *btnLi =[[UIButton alloc]initWithFrame:CGRectMake( 248.5*j*Width+(1+j)*1.5*Width ,btn.bottom,248.5*Width,250*Width)];
                [btnLi addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
                btnLi.tag =j+600;
                btnLi.backgroundColor =[UIColor whiteColor];
                [bgScrollView  addSubview:btnLi];
                
                //上边图片
                UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(85*Width,60*Width,80*Width,80*Width)];
                topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[j]]];
                topImgV.tag =1100+j;
                [btnLi addSubview:topImgV];
                //下边文字
                UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom+10*Width,250*Width,60*Width)];
                botLabel.textAlignment=NSTextAlignmentCenter;
                botLabel.font =[UIFont systemFontOfSize:14];
                botLabel.textColor =BlackColor;
                botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[j]];
                [btnLi addSubview:botLabel];            }
            
        }else if (i==3) {
            btn.frame =CGRectMake(0,100*Width*i+bgImageV.bottom+310*Width,CXCWidth,100*Width);
        }

    }
    
    
    
}
- (void)rightBtnAction
{
    AccoutSetVC *viewController=[[AccoutSetVC alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {
        
        MyAppointmentVC *viewController=[[MyAppointmentVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==301) {
        
        MYTenderVC *viewController =[[MYTenderVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];

    }else if (btn.tag ==302) {
        WithDrawDetail *viewController =[[WithDrawDetail alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==303) {
        CouponViewController *viewController =[[CouponViewController alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==400) {
        
        HYMyOrderVC*viewController =[[HYMyOrderVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==401) {
       
        DiaryofDecorateVC*viewController =[[DiaryofDecorateVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];

    }else if (btn.tag ==402) {
        
       
    }else if (btn.tag ==403) {
        [self nextStep];
    }else if (btn.tag ==600) {
        
        MYSignUp*viewController =[[MYSignUp alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==601) {
        
        MarkManageVC *viewController =[[MarkManageVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (btn.tag ==602) {
        [self nextStep];
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
  
    
    IsTureAlterView *isture = [self.view viewWithTag:180];
    [isture removeFromSuperview];
//
//        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
//        [dic1 setDictionary:@{
////                              @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]]
//                              }];
//        
//        [PublicMethod AFNetworkPOSTurl:@"Home/Login/exitlogin" paraments:dic1  addView:self.view success:^(id responseDic) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
//        
//                
//                
//                NSLog(@"确认");
                [[self rdv_tabBarController] setSelectedIndex:0];
                
                //删除
                [PublicMethod removeObjectForKey: @"IsLogin"];
                [PublicMethod removeObjectForKey: member];
                [PublicMethod removeObjectForKey: shopingCart];
                [PublicMethod removeObjectForKey: @"zhangyue_searchJiLu"];
                [PublicMethod removeObjectForKey: @"wantSearch"];

//            
//            }
//            
//        } fail:^(NSError *error) {
//            
//        }];
//        
//    
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
