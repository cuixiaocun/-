//
//  DelegateExamineDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DelegateExamineDetailVC.h"

@interface DelegateExamineDetailVC ()
{

    //底部scrollview
    UIScrollView *bgScrollView;

}
@end

@implementation DelegateExamineDetailVC

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
    [navTitle setText:@"审核代理注册"];
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
    UIView * topBgView =[[UIView alloc]init];
    [topBgView setBackgroundColor:[UIColor whiteColor]];
    topBgView.frame =CGRectMake(0, 0, CXCWidth,74*Width+4*Width*84 );;
    [bgScrollView addSubview:topBgView];
   NSArray* topLeftArr =@[@"    当前产品数量",@"商品a",@"商品b",@"商品b",@"商品b"];
   NSArray* topRightArr =@[@"     ",@"100盒",@"100盒",@"100盒",@"100盒"];

    for (int i=0;i<5 ; i++) {
        //左边提示
        UILabel* labe = [[UILabel alloc]init];
        labe.font = [UIFont systemFontOfSize:14];
        labe.text = topLeftArr[i];
        labe.tag =200+i;
        [topBgView addSubview:labe];

        if (i==0) {
            labe.frame= CGRectMake(0*Width, 0,CXCWidth , 74*Width);
            labe.backgroundColor =BGColor;
            labe.textColor = TextGrayColor;
            
 
        }else
        {
        
            labe.frame= CGRectMake(32*Width, 74*Width+82*Width*(i-1),200*Width , 82*Width);
            labe.textColor = TextGrayColor;
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = topRightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,labe.top, 475*Width,82*Width );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =210+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BlackColor;
            [topBgView addSubview:rightLabel];
        
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [topBgView addSubview:xian];
            xian.frame =CGRectMake(24*Width,74*Width+82*(i-1)*Width-1.5*Width, CXCWidth, 1.5*Width);
        }
        
    }

    UIView * middleBgView =[[UIView alloc]init];
    [middleBgView setBackgroundColor:[UIColor whiteColor]];
    middleBgView.frame =CGRectMake(0, topBgView.bottom, CXCWidth,74*Width+5*Width*84 );;
    [bgScrollView addSubview:middleBgView];
    NSArray* middleLeftArr =@[@"    注册下级代理信息",@"姓名",@"账号",@"代理级别",@"身份证",@"电话"];
    NSArray* middleRightArr =@[@"     ",@"张三",@"18363671722",@"二级代理",@"393902199810193124",@"18363671722"];
    
    for (int i=0;i<6 ; i++) {
        //左边提示
        UILabel* labe = [[UILabel alloc]init];
        labe.font = [UIFont systemFontOfSize:14];
        labe.text = middleLeftArr[i];
        [middleBgView addSubview:labe];
        
        if (i==0) {
            labe.frame= CGRectMake(0*Width, 0,CXCWidth , 74*Width);
            labe.backgroundColor =BGColor;
            labe.textColor = TextGrayColor;
            
            
        }else
        {
            
            labe.frame= CGRectMake(32*Width, 74*Width+82*Width*(i-1),200*Width , 82*Width);
            labe.textColor = TextGrayColor;
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = middleRightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,labe.top, 475*Width,82*Width );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =220+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BlackColor;
            [middleBgView addSubview:rightLabel];
            
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [middleBgView addSubview:xian];
            xian.frame =CGRectMake(24*Width,74*Width+82*(i-1)*Width-1.5*Width, CXCWidth, 1.5*Width);
        }
        
    }
    
    UIView * bottomBgView =[[UIView alloc]init];
    [bottomBgView setBackgroundColor:[UIColor whiteColor]];
    bottomBgView.frame =CGRectMake(0, middleBgView.bottom, CXCWidth,74*Width*2+4*Width*170);;
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
    orderStatuerLabel.text = @"等待审核";
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
    [examineBtn setTitle:@"审核通过" forState:UIControlStateNormal];
    [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [examineBtn addTarget:self action:@selector(examinePass) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:examineBtn];
    

    
    
    
    
    
    
        
}
    
-(void)examinePass
{
    NSLog(@"审核通过");
    UIAlertView *delAlertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",@"确定要通过审核？"] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [delAlertView show];
    



}

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//    //横线
//    UIImageView*xian =[[UIImageView alloc]init];
//    xian.backgroundColor =BGColor;
//    [bgScrollView addSubview:xian];
//    xian.frame =CGRectMake(0,0*Width, CXCWidth, 18*Width);
//    NSArray*leftArr =@[@"代理级别",@"账号",@"名称",@"报单量",@"报单金额",@"下单量",@"",@"",@"",@"",@"",@"",] ;
//    NSArray*rightArr =@[@"一级",@"18363671722",@"山东桥通天下网络科技有限公司",@"3单",@"100000万",@"3单",@"",@"",@"",@"",@"",@"",] ;
//    
//    for (int i=0; i<6; i++) {
//        //背景
//        UIView *bgview =[[UIView alloc]init];
//        bgview.backgroundColor =[UIColor whiteColor];
//        [bgScrollView addSubview:bgview];
//        bgview.frame =CGRectMake(0, 0+i*82*Width, CXCWidth, 82*Width);
//        //左边提示
//        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
//        labe.text = leftArr[i];
//        //            labe.textAlignment=NSTextAlignmentLeft;
//        labe.font = [UIFont systemFontOfSize:14];
//        labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
//        [bgview addSubview:labe];
//        //右边显示
//        UILabel* rightLabel = [[UILabel alloc]init];
//        rightLabel.text = rightArr[i];
//        rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
//        rightLabel.textAlignment=NSTextAlignmentRight;
//        rightLabel.tag =200+i;
//        rightLabel.font = [UIFont systemFontOfSize:14];
//        rightLabel.textColor = BlackColor;
//        [bgview addSubview:rightLabel];
//        //分割线
//        UIImageView*xian =[[UIImageView alloc]init];
//        xian.backgroundColor =BGColor;
//        [bgview addSubview:xian];
//        xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
//        
//    }
//    
//    
//    
//    
//

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        return;
        
    }else
    {
        //审核通过
        
    }
}


- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
