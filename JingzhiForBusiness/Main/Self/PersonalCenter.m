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
@interface PersonalCenter ()
{
    //底部scrollview
    UIScrollView *bgScrollView;

}
@end

@implementation PersonalCenter
- (void)viewWillAppear:(BOOL)animated
{

[[self rdv_tabBarController] setTabBarHidden:NO animated:YES];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    
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
    levelLabel.text =@"一级代理商";
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.font = [UIFont boldSystemFontOfSize:16];
    levelLabel.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:levelLabel];
    
    //电话
    UILabel *telphoneL = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+24*Width,levelLabel.bottom, 400*Width, 60*Width)];
    telphoneL.textColor = [UIColor whiteColor];
    telphoneL.tag =3332;
    telphoneL.text=@"183******3";
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
    
    
    NSArray *topArr =@[@"proxy_me_icon_kucun",@"proxy_me_icon_xiaji",@"proxy_me_icon_kehu",@"proxy_me_icon_dizhi",@"proxy_me_icon_mima",@"proxy_me_icon_shengji",@"proxy_me_icon_tixian",@"proxy_me_icon_liuzhuan",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];

    NSArray*bottomArr =@[@"库存",@"下级代理",@"我的客户",@"收货地址",@"密码修改",@"申请升级",@"提现管理",@"流转记录",@"会员订单",@"银行卡",@"返佣",@"代理审核",@"我的授权",@"",@"",] ;
    for (int i=0; i<13; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(187*Width*(i%4),bgImageV.bottom+20*Width+187.5*Width*(i/4),186*Width,186*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+330;
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
    LoginPage *log =[[LoginPage alloc]init];
    [self.navigationController pushViewController:log animated:YES];
    


}
-(void)myBtnAciton:(UIButton *)btn
{




}
-(void)startScan{
//画二维码
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
//    NSArray*arr=@[[QRCodeGenerator qrImageForString:@"Key" imageSize:400],
//                  [QRCodeGenerator qrImageForString:@"key1" imageSize:400 Topimg:[UIImage imageNamed:@"super.jpg"]],
//                  [QRCodeGenerator qrImageForString:@"key2" imageSize:400 withPointType:QRPointRect withPositionType:QRPositionNormal withColor:[UIColor yellowColor]],
//                  [QRCodeGenerator qrImageForString:@"key3" imageSize:400 withPointType:QRPointRound withPositionType:QRPositionRound withColor:[UIColor redColor]],
//                  [QRCodeGenerator qrImageForString:@"key4" imageSize:400 withPointType:QRPointRect withPositionType:QRPositionRound withColor:[UIColor blueColor]],
//                  [QRCodeGenerator qrImageForString:@"key5" imageSize:400 withPointType:QRPointRound withPositionType:QRPositionNormal withColor:[UIColor purpleColor]]];
//    for (int i=0; i<6; i++) {
//        UIImageView*QRCode=[[UIImageView alloc]initWithFrame:CGRectMake(i%3*w/3, (i/3)*w/3, w/3, w/3)];
//        QRCode.image=arr[i];
//        [self.view addSubview:QRCode];
//    }
//
//    //扫描二维码
//    XYMScanViewController *scanView = [[XYMScanViewController alloc]init];
//    
//    [self.navigationController pushViewController:scanView animated:YES];
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
