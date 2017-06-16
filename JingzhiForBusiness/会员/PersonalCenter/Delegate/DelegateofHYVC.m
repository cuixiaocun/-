//
//  DelegateofHYVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DelegateofHYVC.h"

@interface DelegateofHYVC ()
{
    //底部scrollview
    UIScrollView *bgScrollView;
    

}
@end

@implementation DelegateofHYVC

- (void)viewDidLoad {
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
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"代理商"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    [self mainView];
}
- (void)mainView
{
    
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    
    NSArray *topArr =@[@"proxy_me_icon_kucun",@"proxy_me_icon_xiaji",@"proxy_me_icon_kehu",@"proxy_me_icon_dizhi",@"proxy_me_icon_mima",@"proxy_me_icon_shengji",@"proxy_me_icon_tixian",@"proxy_me_icon_liuzhuan",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    
    NSArray*bottomArr =@[@"我的推荐",@"我的订单",@"收货地址",@"资金记录",@"推广二维码",@"代理商",@"流转记录",@"会员订单",@"银行卡",@"返佣",@"代理审核",@"我的授权",@"",@"",] ;
    for (int i=0; i<6; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(250*Width*(i%3),20*Width+325*Width*(i/3),249*Width,323*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(75*Width,90*Width,100*Width,100*Width)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
        topImgV.tag =1100+i;
        [btn addSubview:topImgV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom,250*Width,100*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.textColor =BlackColor;
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
    }
    

}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    

}
-(void)myBtnAciton:(UIButton *)btn
{

}
- (void)confirmBtn
{


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
