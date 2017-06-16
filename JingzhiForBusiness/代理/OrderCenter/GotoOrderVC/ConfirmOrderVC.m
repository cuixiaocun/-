//
//  ConfirmOrderVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "CXCThreeLabelSheet.h"
@interface ConfirmOrderVC ()<CXCThreeLabelSheetDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;



}
@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
    [navTitle setText:@"确认订单"];
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    
    UIButton *topView =[[UIButton alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 200*Width)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [topView addTarget:self action:@selector(chooseAdress) forControlEvents:UIControlEventTouchUpInside];
    
    [bgScrollView addSubview:topView];
    
    UILabel*nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60*Width, 25*Width, 260*Width, 50*Width)];
    nameLabel.text =@"孙磊";
    nameLabel.tag=450;
    nameLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:nameLabel];
    
    
    UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.right+20*Width, 25*Width, 300*Width, 50*Width)];
    numberLabel.text =@"18373781822";
    numberLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:numberLabel];
    numberLabel.tag=451;
    //箭头
    UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 80*Width,40*Width , 40*Width)];
    [topView addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];


    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(20*Width, nameLabel.bottom+46*Width,24*Width, 32*Width)];
    [imgView setImage:[UIImage imageNamed:@"wuliu_icon_location"]];
    [topView addSubview:imgView];
    
    
    
    UILabel *addressLabel  =[[UILabel alloc]initWithFrame:CGRectMake(imgView.right+ 20*Width, nameLabel.bottom,620*Width, 125*Width)];
    [topView addSubview:addressLabel];
    addressLabel.text =@"山东省潍坊市高新区胜利东街新华路中天下潍坊国际";
    addressLabel.font =[UIFont systemFontOfSize:13];
    addressLabel.numberOfLines= 0;
    addressLabel.textColor =TextGrayColor;
    addressLabel.tag=452;
    
    NSArray*leftArr =@[@"商品",@"数量",@"运单号",@"官方电话",@"",@"",@"",@"",] ;
    NSArray*rightArr =@[@"商品12",@"123",@"123948347398535789",@"11185",@"100000万",@"",@"",@"",] ;
    
    for (int i=0; i<2; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        bgview.frame =CGRectMake(0, topView.bottom+i*82*Width+20*Width, CXCWidth, 82*Width);
        //左边提示
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
        labe.text = leftArr[i];
        //            labe.textAlignment=NSTextAlignmentLeft;
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [bgview addSubview:labe];
        //右边显示
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text = rightArr[i];
        rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =200+i;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = BlackColor;
        [bgview addSubview:rightLabel];
        //分割线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
        
    }
    
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,520*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
-(void)confirmOrder
{


}

- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)chooseAdress
{
    CXCThreeLabelSheet *sheet =[[CXCThreeLabelSheet alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight) with:@[@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际山东省潍坊市高新区胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"]]];
    sheet.tag=1111;
    sheet.delegate=self;
    [self.view addSubview:sheet];
    
    
    



}
-(void)btnClickName:(NSString *)nameString andPhone:(NSString *)phone andAdress:(NSString *)adress
{
    UILabel *nameLabel =[self.view viewWithTag:450];
    UILabel *phoneLabel =[self.view viewWithTag:451];
    UILabel *adressLabel =[self.view viewWithTag:452];
    [nameLabel setText:nameString];
    [phoneLabel setText:phone];
    [adressLabel setText:adress];
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];


}
-(void)hiddenCXCActionSheet
{
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    UILabel *nameLabel= [self.view viewWithTag:450];
    [nameLabel setText:@"请选择"];
    UILabel *numberLabel= [self.view viewWithTag:451];
    [numberLabel setText:@"请选择"];
    UILabel *adressLabel =[self.view viewWithTag:452];
    [adressLabel setText:@"请选择"];

    
    
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
