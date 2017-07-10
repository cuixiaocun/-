//
//  BankCardVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "BankCardVC.h"
#import "AddBankCardVC.h"
@interface BankCardVC ()
{

    //底部scrollview
    UIScrollView *bgScrollView;
    UIButton *addBtn;//添加银行卡
}
@end

@implementation BankCardVC

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
    [navTitle setText:@"银行卡"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
//    //提现按钮
//    UIButton *  withDrawlsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    withDrawlsBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
//    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
//    withDrawlsBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
//    [withDrawlsBtn setTitle:@"提现" forState:UIControlStateNormal];
//    [withDrawlsBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [topImageView addSubview:withDrawlsBtn];
   
        [self mainView];
}
- (void)mainView
{
    //背景
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    //左边线
    UIImageView* leftXian =[[UIImageView alloc]initWithFrame:CGRectMake(24*Width, 20*Width, 4*Width, 44*Width)];
    leftXian.backgroundColor = NavColor;
    [bgScrollView addSubview:leftXian];
    //右边提示
    UILabel *promLabel =[[UILabel alloc]initWithFrame:CGRectMake(45*Width, 0, 650*Width, 84*Width)];
    promLabel.text =@"务必保证收款账户姓名、账户等信息真实有效";
    [bgScrollView addSubview:promLabel];
    promLabel.font =[UIFont systemFontOfSize:13];
    for (int i=0; i<3; i++) {
        //银行卡背景
        UIImageView *cardBgView = [[UIImageView alloc]initWithFrame:CGRectMake(25*Width,promLabel.bottom+ 300*i*Width, 700*Width, 270*Width)];
        cardBgView.userInteractionEnabled = YES;
        cardBgView.tag =900+i;
        if (i==0) {
            [cardBgView setImage:[UIImage imageNamed:@"bcard_icon_bg_default"]];

        }else
        {
            [cardBgView setImage:[UIImage imageNamed:@"bcard_icon_bg_second"]];
            
        }
        [bgScrollView addSubview:cardBgView];
        
        //银行卡头像背景
        UIImageView *cardPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(36*Width, 36*Width, 70*Width, 70*Width)];
        cardPhoto.userInteractionEnabled = YES;
        cardPhoto.tag =100+i;
        cardPhoto.image =[UIImage imageNamed:@"bcard_icon_bank_white"];
        [cardBgView addSubview:cardPhoto];

        //name
        UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, cardPhoto.top-10*Width, 350*Width, 35*Width)];
        
        nameLabel.textColor =[UIColor whiteColor];
        nameLabel.text =@"曲小川";
        nameLabel.tag =200+i;

        nameLabel.font =[UIFont systemFontOfSize:16];
        [cardBgView addSubview:nameLabel];
        
        //银行
        UILabel *bankLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, nameLabel.bottom+10*Width, 350*Width, 35*Width)];
        bankLabel.textColor =[UIColor whiteColor];
        bankLabel.text =@"中国银行";
        bankLabel.tag =300+i;

        bankLabel.font =[UIFont systemFontOfSize:14];
        [cardBgView addSubview:bankLabel];
        
        //银行卡号
        UILabel *bankCardLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, bankLabel.bottom+10*Width, 550*Width, 80*Width)];
        bankCardLabel.textColor =[UIColor whiteColor];
        bankCardLabel.text =@"6223910301160170";
        bankCardLabel.font =[UIFont systemFontOfSize:18];
        [cardBgView addSubview:bankCardLabel];
        bankCardLabel.tag =400+i;
        
        //默认label
        UILabel *defaultLabel =[[UILabel alloc]initWithFrame:CGRectMake(580*Width, nameLabel.top, 80*Width, 35*Width)];
        defaultLabel.textColor =[UIColor whiteColor];
        defaultLabel.text =@"默认";
        defaultLabel.tag=500+i;
        defaultLabel.font =[UIFont systemFontOfSize:14];
        [cardBgView addSubview:defaultLabel];
        //uibutton
        //系统计算按钮
       UIButton * setDefaultBtn = [[UIButton alloc]initWithFrame:CGRectMake(550*Width, 200*Width, 145*Width, 45*Width)];
        [setDefaultBtn.layer setCornerRadius:2*Width];
        [setDefaultBtn.layer setBorderWidth:1.5*Width];
        [setDefaultBtn.layer setMasksToBounds:YES];
        [setDefaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [setDefaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [setDefaultBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [setDefaultBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        setDefaultBtn.layer.borderColor =[UIColor whiteColor].CGColor;
        [cardBgView addSubview:setDefaultBtn];
        setDefaultBtn.tag=600+i;
        if(i==0)
        {
            setDefaultBtn.hidden=YES;
            defaultLabel.hidden=NO;
        }else
        {
            setDefaultBtn.hidden=NO;
            defaultLabel.hidden=YES;

        }

    }
    addBtn = [[UIButton alloc]initWithFrame:CGRectMake(25*Width,promLabel.bottom+ 300*(3)*Width, 700*Width, 270*Width)];//(2)为卡片数量
    [addBtn setImage:[UIImage imageNamed:@"bcard_bg_addcard"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [bgScrollView addSubview:addBtn];

}
- (void)btnAction:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        UIButton *btn =[self.view viewWithTag:600+i];
        UILabel *label =[self.view viewWithTag:500+i];
        UIImageView*imgV =[self.view viewWithTag:900+i];
        btn.hidden=NO;
        label.hidden=YES;
        [imgV setImage:[UIImage imageNamed:@"bcard_icon_bg_second"]];

    }
    btn.hidden=YES;
    NSInteger index =btn.tag-600;
    UILabel *label =[self.view viewWithTag:500+index];
    UIImageView*imgV =[self.view viewWithTag:900+index];
    [imgV setImage:[UIImage imageNamed:@"bcard_icon_bg_default"]];
    label.hidden=NO;
    

}
- (void)withDrawlsBtnAction
{
    
    
    
}
- (void)addBtnAction
{
    AddBankCardVC *addBtnVC =[[AddBankCardVC alloc]init];
    [self.navigationController pushViewController:addBtnVC animated:YES];


}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}- (void)didReceiveMemoryWarning {
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
