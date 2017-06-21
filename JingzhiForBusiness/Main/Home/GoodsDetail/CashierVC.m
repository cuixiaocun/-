//
//  CashierVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "CashierVC.h"
#import "CXCTwoLableSheet.h"
@interface CashierVC ()<CXCTwoLableSheetDelegate>
{
    UIScrollView *bgScrollView;
}
@end

@implementation CashierVC

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
    [navTitle setText:@"心体荟收银台"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    
    
    [self mainView];
}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1200*Width)];
    
    UIView *needPayView =[[UIView alloc]initWithFrame:CGRectMake(0,20*Width, CXCWidth, 83*Width)];
    needPayView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:needPayView];
    
    
    UILabel *needPayLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,0, 200*Width,83*Width )];
    needPayLabel.text =@"需支付";
    needPayLabel.textColor =BlackColor;
    needPayLabel.font =[UIFont systemFontOfSize:14];
    [needPayView addSubview:needPayLabel];
    
    UILabel *payLabel =[[UILabel alloc]initWithFrame:CGRectMake(150*Width,0, 575*Width,83*Width )];
    payLabel.text =@"200.00元";
    payLabel.textColor =NavColor;
    payLabel.textAlignment =NSTextAlignmentRight;
    payLabel.font =[UIFont systemFontOfSize:14];
    [needPayView addSubview:payLabel];
    
    
    UIButton *middleBgView =[[UIButton alloc]initWithFrame:CGRectMake(0, needPayView.bottom+20*Width, CXCWidth, 200*Width)];
    middleBgView.backgroundColor =[UIColor whiteColor];
    [bgScrollView   addSubview:middleBgView];
    [middleBgView addTarget:self action:@selector(showCXCActionSheetView) forControlEvents:UIControlEventTouchUpInside];
    UILabel*promLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,20*Width , 300*Width, 44*Width)];
    promLabel.text =@"支付方式";
    promLabel.textColor =BlackColor;
    promLabel.font =[UIFont systemFontOfSize:16];
    [middleBgView addSubview:promLabel];
    
    
    
    
    
    
    //银行卡头像背景
    UIImageView *cardPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(24*Width,promLabel.bottom+ 32*Width, 72*Width, 72*Width)];
    cardPhoto.userInteractionEnabled = YES;
    cardPhoto.tag =201;
    cardPhoto.image =[UIImage imageNamed:@"withdrawcash_icon_bank_red"];
    [middleBgView addSubview:cardPhoto];
    
    //名称
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, cardPhoto.top-10*Width, 270*Width, 36*Width)];
    nameLabel.textColor =BlackColor;
    nameLabel.text =@"中国银行";
    nameLabel.tag =202;
    
    nameLabel.font =[UIFont systemFontOfSize:16];
    [middleBgView addSubview:nameLabel];
    
    
    
    UILabel *defaultLabel=[[UILabel alloc]initWithFrame:CGRectMake(400*Width, nameLabel.top, 80*Width, 36*Width)];
    defaultLabel.textColor =NavColor;
    defaultLabel.text =@"默认";
    defaultLabel.font =[UIFont systemFontOfSize:12];
    [middleBgView addSubview:defaultLabel];
    [defaultLabel.layer setCornerRadius:2*Width];
    [defaultLabel.layer setBorderWidth:1.5*Width];
    [defaultLabel.layer setMasksToBounds:YES];
    defaultLabel.textAlignment =NSTextAlignmentCenter;
    defaultLabel.layer.borderColor =NavColor.CGColor;
    

    
    //银行卡号
    UILabel *bankLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, nameLabel.bottom+10*Width, 550*Width, 36*Width)];
    bankLabel.textColor =BlackColor;
    bankLabel.text =@"6223 9103 0116 0170";
    bankLabel.tag =203;
    bankLabel.font =[UIFont systemFontOfSize:14];
    [middleBgView addSubview:bankLabel];
    //箭头
    UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width,promLabel.bottom+ 47*Width,40*Width , 40*Width)];
    [middleBgView addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
    
    
 
    //下一步按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,440*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"支付" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(surePayTheMoney) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];

    
    
    
    
    
    

    
    

    
    
    

}
- (void)surePayTheMoney
{


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showCXCActionSheetView
{
    CXCTwoLableSheet *sheet =[[CXCTwoLableSheet alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight) with:@[@[@"潍坊银行",@"62239050849068308690468"],@[@"中国银行",@"3243905864390608593"],@[@"中国银行",@"3243905864390608593"],@[@"中国银行",@"3243905864390608593"],@[@"潍坊银行",@"62239050849068308690468"],@[@"中国银行",@"3243905864390608593"],@[@"潍坊银行",@"62239050849068308690468"],@[@"中国银行",@"3243905864390608593"],]];
    sheet.tag=1111;
    sheet.delegate=self;
    [self.view addSubview:sheet];
    
    
    
}
- (void)btnClickName:(NSString *)nameString andBankNumber:(NSString *)bankNum
{
    UILabel *nameLabel= [self.view viewWithTag:202];
    [nameLabel setText:nameString];
    
    UILabel *numberLabel= [self.view viewWithTag:203];
    [numberLabel setText:bankNum];
    
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    
    
    
}
-(void)hiddenCXCActionSheet
{
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    UILabel *nameLabel= [self.view viewWithTag:202];
    [nameLabel setText:@"请选择"];
    
    UILabel *numberLabel= [self.view viewWithTag:203];
    [numberLabel setText:@"请选择"];
    
    
    
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
