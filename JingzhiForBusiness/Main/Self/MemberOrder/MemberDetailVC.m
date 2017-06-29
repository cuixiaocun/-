//
//  MemberDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MemberDetailVC.h"
#import "MemberDeliverVC.h"
@interface MemberDetailVC ()
{
    //底部scrollview
    UIScrollView *bgScrollView;

}
@end

@implementation MemberDetailVC
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
    [navTitle setText:@"会员订单详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    
    
    
    
    
    
    
    
    
    
        [self mainView];
}
-(void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 2000*Width)];
    UIView * bottomBgView =[[UIView alloc]init];
    [bottomBgView setBackgroundColor:[UIColor whiteColor]];
    bottomBgView.frame =CGRectMake(0, 0, CXCWidth,74*Width*2+4*Width*170);;
    [bgScrollView addSubview:bottomBgView];
    //时间
    UILabel* timeLabel  = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.text = @"    2017-09-01 12：23：24";
    [bottomBgView addSubview:timeLabel];
    timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
    timeLabel.backgroundColor =BGColor;
    timeLabel.textColor = TextGrayColor;
    //总额
    UILabel* pricesLabel  = [[UILabel alloc]init];
    pricesLabel.font = [UIFont systemFontOfSize:13];
    pricesLabel.textColor = TextGrayColor;
    NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",@"900000"];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [pricesLabel setAttributedText:textColor];
    [bottomBgView addSubview:pricesLabel];
    pricesLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
    pricesLabel.backgroundColor =BGColor;
    pricesLabel.textAlignment = NSTextAlignmentRight;
    //订单号
    UILabel* orderNumberLabel  = [[UILabel alloc]init];
    orderNumberLabel.font = [UIFont systemFontOfSize:14];
    orderNumberLabel.text = @"    订单号：1953056874376";
    [bottomBgView addSubview:orderNumberLabel];
    orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
    orderNumberLabel.textColor = TextGrayColor;
    //状态
    UILabel* orderStatuerLabel  = [[UILabel alloc]init];
    orderStatuerLabel.font = [UIFont systemFontOfSize:14];
    orderStatuerLabel.text = @"已支付";
    orderStatuerLabel.textAlignment =NSTextAlignmentRight;
    [bottomBgView addSubview:orderStatuerLabel];
    orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
    orderStatuerLabel.textColor = NavColor;
    //细线
    UIImageView*xianOfGoods =[[UIImageView alloc]init];
    xianOfGoods.backgroundColor =BGColor;
    [bottomBgView addSubview:xianOfGoods];
    xianOfGoods.frame =CGRectMake(0*Width,orderNumberLabel.bottom,CXCWidth,1.5*Width);
    for (int i=0;i<4 ; i++) {
        
        UIView  *bgview =[[UIView alloc]initWithFrame:CGRectMake(0*Width, xianOfGoods.bottom+170*Width*i,CXCWidth , 170*Width)];
        [bottomBgView addSubview:bgview];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        //商品名称
        UILabel* leftTopLabe = [[UILabel alloc]init];
        leftTopLabe.font = [UIFont systemFontOfSize:14];
        leftTopLabe.text = @"商品q";
        leftTopLabe.frame= CGRectMake(24*Width, 0,300*Width , 80*Width);
        leftTopLabe.tag =230+i;
        //        leftTopLabe.backgroundColor =BGColor;
        leftTopLabe.textColor = TextGrayColor;
        [bgview addSubview:leftTopLabe];
        //数量
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text =@"1箱9盒";
        rightLabel.frame =CGRectMake(250*Width ,0,475*Width,80*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =240+i;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = TextGrayGrayColor;
        [bgview addSubview:rightLabel];
        
        
        
        
        //商品单价
        UILabel* priceLabe = [[UILabel alloc]init];
        priceLabe.font = [UIFont systemFontOfSize:14];
        priceLabe.text = @"¥300.00";
        priceLabe.frame= CGRectMake(24*Width, leftTopLabe.bottom+10*Width,300*Width , 80*Width);
        priceLabe.tag =250+i;
        priceLabe.textColor = NavColor;
        [bgview addSubview:priceLabe];
        
        //小计
        UILabel* allPriceLabel = [[UILabel alloc]init];
        allPriceLabel.textColor = BlackColor;
        
        NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",@"900"];//总和
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
        NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
        [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
        [allPriceLabel setAttributedText:textColor];
        allPriceLabel.frame =CGRectMake(250*Width ,leftTopLabe.bottom+10*Width, 475*Width,80*Width );
        allPriceLabel.textAlignment=NSTextAlignmentRight;
        allPriceLabel.tag =260+i;
        allPriceLabel.font = [UIFont systemFontOfSize:14];
        [bgview addSubview:allPriceLabel];
        
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(24*Width,168.5*Width, CXCWidth, 1.5*Width);
        
    }
    UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0, bottomBgView.bottom+1*Width, CXCWidth, 80*Width)];
    btnView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:btnView];
    UIButton *examineBtn =[[UIButton alloc]initWithFrame:CGRectMake(580*Width, 15*Width, 145*Width,50*Width)];
    [btnView addSubview:examineBtn];
    
    [examineBtn setBackgroundColor:[UIColor whiteColor]];
    [examineBtn.layer setCornerRadius:4*Width];
    [examineBtn.layer setBorderWidth:1.0*Width];
    [examineBtn.layer setMasksToBounds:YES];
    [examineBtn setTitleColor:NavColor forState:UIControlStateNormal];
    examineBtn.layer.borderColor =NavColor.CGColor;
    [examineBtn setTitle:@"发货" forState:UIControlStateNormal];
    [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [examineBtn addTarget:self action:@selector(examinePass) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:examineBtn];
    
    
    


}
- (void)examinePass
{
    MemberDeliverVC *membervc =[[MemberDeliverVC alloc]init];
    [self.navigationController pushViewController:membervc animated:YES];



}
- (void)withDrawlsBtnAction
{
    
    
    
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
