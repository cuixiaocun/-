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
    NSArray*inforArr;
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
    
    inforArr =[[NSArray alloc]init];
    inforArr =[_detailDic objectForKey:@"goods"];
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
    bottomBgView.frame =CGRectMake(0, 0, CXCWidth,74*Width*2+inforArr.count*Width*170);;
    [bgScrollView addSubview:bottomBgView];
    //时间
    UILabel* timeLabel  = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.text = [NSString stringWithFormat:@"    %@",[_detailDic objectForKey:@"createtime"] ];
    [bottomBgView addSubview:timeLabel];
    timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
    timeLabel.backgroundColor =BGColor;
    timeLabel.textColor = TextGrayColor;
    //总额
    UILabel* pricesLabel  = [[UILabel alloc]init];
    pricesLabel.font = [UIFont systemFontOfSize:13];
    pricesLabel.textColor = TextGrayColor;
    NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",[_detailDic objectForKey:@"total"]];//总和
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
    orderNumberLabel.text = [NSString stringWithFormat:@"    订单号：%@",[_detailDic objectForKey:@"sn"] ];
    [bottomBgView addSubview:orderNumberLabel];
    orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
    orderNumberLabel.textColor = TextGrayColor;
    //状态
    UILabel* orderStatuerLabel  = [[UILabel alloc]init];
    orderStatuerLabel.font = [UIFont systemFontOfSize:14];
    NSArray*arr =@[@"",@"待支付",@"待发货",@"已发货",@"已完成",@"已取消",@"已驳回",@"",];
    int i =[[_detailDic objectForKey:@"status"] intValue];

    orderStatuerLabel.text = [NSString stringWithFormat:@"%@",arr[i]];
    orderStatuerLabel.textAlignment =NSTextAlignmentRight;
    [bottomBgView addSubview:orderStatuerLabel];
    orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
    orderStatuerLabel.textColor = NavColor;
    //细线
    UIImageView*xianOfGoods =[[UIImageView alloc]init];
    xianOfGoods.backgroundColor =BGColor;
    [bottomBgView addSubview:xianOfGoods];
    xianOfGoods.frame =CGRectMake(0*Width,orderNumberLabel.bottom,CXCWidth,1.5*Width);
    for (int i=0;i< inforArr.count; i++) {
        
        UIView  *bgview =[[UIView alloc]initWithFrame:CGRectMake(0*Width, xianOfGoods.bottom+170*Width*i,CXCWidth , 170*Width)];
        [bottomBgView addSubview:bgview];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        //商品名称
        UILabel* leftTopLabe = [[UILabel alloc]init];
        leftTopLabe.font = [UIFont systemFontOfSize:14];
        leftTopLabe.text = [NSString stringWithFormat:@"%@",[inforArr[i] objectForKey:@"name"]];
        leftTopLabe.frame= CGRectMake(24*Width, 0,300*Width , 80*Width);
        leftTopLabe.tag =230+i;
        //        leftTopLabe.backgroundColor =BGColor;
        leftTopLabe.textColor = TextGrayColor;
        [bgview addSubview:leftTopLabe];
        //数量
        UILabel* rightLabel = [[UILabel alloc]init];
        NSInteger box =[[NSString  stringWithFormat:@"%@", [inforArr[i] objectForKey:@"num"]] integerValue]/[[NSString  stringWithFormat:@"%@", [inforArr[i] objectForKey:@"boxnum"]] integerValue];
        NSInteger num =[[NSString  stringWithFormat:@"%@", [inforArr[i] objectForKey:@"num"]] integerValue]%[[NSString  stringWithFormat:@"%@", [inforArr[i] objectForKey:@"boxnum"]] integerValue];
        if (box==0) {
            rightLabel.text   = [NSString stringWithFormat:@"%ld盒",num];
            
        }else if(box>0&&num>0)
        {
            rightLabel.text  = [NSString stringWithFormat:@"%ld箱%ld盒",box,num];
            
        }else if(box>0&&num==0)
        {
            rightLabel.text  = [NSString stringWithFormat:@"%ld箱",box];
            
        }
        rightLabel.frame =CGRectMake(250*Width ,0,475*Width,80*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =240+i;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = TextGrayGrayColor;
        [bgview addSubview:rightLabel];
        
        
        //商品单价
        UILabel* priceLabe = [[UILabel alloc]init];
        priceLabe.font = [UIFont systemFontOfSize:14];
        priceLabe.text =[NSString stringWithFormat:@"¥%@",[inforArr[i] objectForKey:@"price"]] ;
        priceLabe.frame= CGRectMake(24*Width, leftTopLabe.bottom+10*Width,300*Width , 80*Width);
        priceLabe.tag =250+i;
        priceLabe.textColor = NavColor;
        [bgview addSubview:priceLabe];
        
        //小计
        UILabel* allPriceLabel = [[UILabel alloc]init];
        allPriceLabel.textColor = BlackColor;
        
        NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",[inforArr[i] objectForKey:@"total"]];//总和
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
        if (i==inforArr.count-1) {
            [bgScrollView setContentSize:CGSizeMake(CXCWidth,bgview.bottom)];

        }
        
    }
    NSArray*leftArr =@[@"收货人",@"电话",@"收货地址",@"快递公司",@"运单号",@"",@"",@"",@"",@"",] ;
    NSArray*rightArr =@[[NSString stringWithFormat:@"%@",[_detailDic objectForKey:@"receivename"]],
                        [NSString stringWithFormat:@"%@",[_detailDic objectForKey:@"phone"]],
                        [NSString stringWithFormat:@"%@%@",[_detailDic objectForKey:@"namepath"],[_detailDic objectForKey:@"address"]],
                        [NSString stringWithFormat:@"%@",[_detailDic objectForKey:@"logisticscom"]],
                        [NSString stringWithFormat:@"%@",[_detailDic objectForKey:@"logistics"]],
                        [NSString stringWithFormat:@"%@",[_detailDic objectForKey:@"name"]],] ;
    CGSize titleSize;//通过文本得到高度
    
    titleSize = [rightArr[2] boundingRectWithSize:CGSizeMake(490*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
//    NSArray*arr =@[@"",@"待支付",@"待发货",@"已发货",@"已完成",@"已取消",@"已驳回",@"",];
//    int i =[[_detailDic objectForKey:@"status"] intValue];
    //待发货、待支付的都是没有物流信息的其他的都有物流信息
    if ([[_detailDic objectForKey:@"status"] intValue]==1||[[_detailDic objectForKey:@"status"] intValue]==2||[[_detailDic objectForKey:@"status"] intValue]==5||[[_detailDic objectForKey:@"status"] intValue]==6) {
        
        for (int i=0; i<3; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [bgScrollView addSubview:bgview];
            if (i==2) {
                bgview.frame =CGRectMake(0, bottomBgView.bottom+20*Width+2*82*Width, CXCWidth, 50*Width+titleSize.height);
                
            }else if(i>2)
            {
                bgview.frame =CGRectMake(0, bottomBgView.bottom+40*Width+i*82*Width+titleSize.height-30*Width, CXCWidth, 82*Width);
                
            }else if(i<2)
            {
                bgview.frame =CGRectMake(0, bottomBgView.bottom+20*Width+i*82*Width, CXCWidth, 82*Width);
            }
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
            rightLabel.frame =CGRectMake(230*Width ,0, 495*Width,bgview.height );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.numberOfLines =0;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BlackColor;
            [bgview addSubview:rightLabel];
            //分割线
            if (i!=2) {
                
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [bgview addSubview:xian];
                xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
                
            }
            
        }
        if ([[_detailDic objectForKey:@"status"]isEqualToString:@"2"]) {//若是待发货状态
            UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0, bottomBgView.bottom+20*Width+82*2*Width+50*Width+titleSize.height, CXCWidth, 80*Width)];
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
            [bgScrollView setContentSize:CGSizeMake(CXCWidth,examineBtn.bottom)];
            
            
        }
        
        
        
    }else
    {
  
    for (int i=0; i<5; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        if (i==2) {
            bgview.frame =CGRectMake(0, bottomBgView.bottom+20*Width+2*82*Width, CXCWidth, 50*Width+titleSize.height);
            
 
        }else if(i>2)
        {
            bgview.frame =CGRectMake(0, bottomBgView.bottom+40*Width+i*82*Width+titleSize.height-30*Width, CXCWidth, 82*Width);
            if (i==4) {
                [bgScrollView setContentSize:CGSizeMake(CXCWidth,bgview .bottom)];

            }

        }else if(i<2)
        {
            bgview.frame =CGRectMake(0, bottomBgView.bottom+20*Width+i*82*Width, CXCWidth, 82*Width);
            
        }
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
        rightLabel.frame =CGRectMake(230*Width ,0, 495*Width,bgview.height );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =200+i;
        rightLabel.numberOfLines =0;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = BlackColor;
        [bgview addSubview:rightLabel];
        //分割线
        if (i!=2) {
            
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [bgview addSubview:xian];
            xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
  
        }
        
    }
        
        
 }
    
    

    
    
    
    
    


}
- (void)examinePass
{
    MemberDeliverVC *membervc =[[MemberDeliverVC alloc]init];
    membervc.orderId =[_detailDic objectForKey:@"id"];
    membervc.orderDetailDic =_detailDic;

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
