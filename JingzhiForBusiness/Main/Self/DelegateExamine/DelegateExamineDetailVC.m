//
//  DelegateExamineDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DelegateExamineDetailVC.h"
#import "IsTureAlterView.h"
@interface DelegateExamineDetailVC ()<IsTureAlterViewDelegate>
{

    //底部scrollview
    UIScrollView *bgScrollView;
    NSDictionary *dict;

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
    [navTitle setText:@"审核详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
//    [self mainView];
    [self getExaminePass];

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
    [bgScrollView addSubview:topBgView];
   
    NSArray *reviewArr =[dict objectForKey:@"agenstock"];
    NSMutableArray* topLeftArr =[[NSMutableArray alloc]init];
    [topLeftArr addObject:@"    当前产品数量"];
    
    NSMutableArray* topRightArr =[[NSMutableArray alloc]init];
    [topRightArr addObject:@"     "];
    
    for (int i=0; i<reviewArr.count; i++) {
        
        [topLeftArr addObject:[reviewArr[i] objectForKey:@"name"]];
        [topRightArr addObject:[reviewArr[i] objectForKey:@"num"]];
    }
  
    topBgView.frame =CGRectMake(0, 0, CXCWidth,74*Width+reviewArr.count*Width*84 );;

    for (int i=0;i<topRightArr.count ; i++) {
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
        
            labe.frame= CGRectMake(32*Width, 74*Width+82*Width*(i-1),400*Width , 82*Width);
            labe.textColor = TextGrayColor;
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = topRightArr[i];
            rightLabel.frame =CGRectMake(450*Width ,labe.top, 275*Width,82*Width );
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
    NSArray* middleRightArr =[[NSArray alloc]init];
    if (![[dict objectForKey:@"agen"]isEqual:[NSNull null]]) {
    middleRightArr =@[@"     ",
                      [NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"agen"]objectForKey:@"name"]]]],
                    [NSString stringWithFormat:@"%@",  [PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"agen"] objectForKey:@"account"]]]],
                    [NSString stringWithFormat:@"%@",[PublicMethod stringNilString: [NSString stringWithFormat:@"%@",[[dict objectForKey:@"agen"] objectForKey:@"levelname"]]]],
                    [NSString stringWithFormat:@"%@", [PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"agen"] objectForKey:@"idcard"]]]],
                    [NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"agen"] objectForKey:@"phone"]]]]];
        

    }else{
    
        middleRightArr =@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
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
    [bgScrollView addSubview:bottomBgView];
    //时间
    UILabel* timeLabel  = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.text =[NSString stringWithFormat:@"    %@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"oorder"] objectForKey:@"createtime"]]] ];
    [bottomBgView addSubview:timeLabel];
    timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
    timeLabel.backgroundColor =BGColor;
    timeLabel.textColor = TextGrayColor;
    //总额
    UILabel* pricesLabel  = [[UILabel alloc]init];
    pricesLabel.font = [UIFont systemFontOfSize:13];
    pricesLabel.textColor = TextGrayColor;
    NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"oorder"] objectForKey:@"total"]]]];//总和
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
    orderNumberLabel.text = [NSString stringWithFormat:@"    订单号：%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"oorder"] objectForKey:@"sn"]]] ];
    [bottomBgView addSubview:orderNumberLabel];
    orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
    orderNumberLabel.textColor = TextGrayColor;
    //状态
    UILabel* orderStatuerLabel  = [[UILabel alloc]init];
    orderStatuerLabel.font = [UIFont systemFontOfSize:14];
    orderStatuerLabel.text = [_angeDic objectForKey:@"stuname"];
    orderStatuerLabel.textAlignment =NSTextAlignmentRight;
    [bottomBgView addSubview:orderStatuerLabel];
    orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
    orderStatuerLabel.textColor = NavColor;
    //细线
    UIImageView*xianOfGoods =[[UIImageView alloc]init];
    xianOfGoods.backgroundColor =BGColor;
    [bottomBgView addSubview:xianOfGoods];
    xianOfGoods.frame =CGRectMake(0*Width,orderNumberLabel.bottom,CXCWidth,1.5*Width);
    
    
    NSArray *orderArr =[dict objectForKey:@"detail"];
    bottomBgView.frame =CGRectMake(0, middleBgView.bottom, CXCWidth,74*Width*2+orderArr.count*Width*170);;

    
    for (int i=0;i<orderArr.count ; i++) {
        
        UIView  *bgview =[[UIView alloc]initWithFrame:CGRectMake(0*Width, xianOfGoods.bottom+170*Width*i,CXCWidth , 170*Width)];
        [bottomBgView addSubview:bgview];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        //商品名称
        UILabel* leftTopLabe = [[UILabel alloc]init];
        leftTopLabe.font = [UIFont systemFontOfSize:14];
        leftTopLabe.text = [NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"detail"][i]objectForKey:@"name"]]]];
        leftTopLabe.frame= CGRectMake(24*Width, 0,300*Width , 80*Width);
        leftTopLabe.tag =230+i;
//        leftTopLabe.backgroundColor =BGColor;
        leftTopLabe.textColor = TextGrayColor;
        [bgview addSubview:leftTopLabe];
        //数量
        UILabel* rightLabel = [[UILabel alloc]init];
  
       
        int box =[[[dict objectForKey:@"detail"][i]objectForKey:@"num"] intValue]/[[[dict objectForKey:@"detail"][i]objectForKey:@"boxnum"] intValue];
        int he =[[[dict objectForKey:@"detail"][i]objectForKey:@"num"] intValue]%[[[dict objectForKey:@"detail"][i]objectForKey:@"boxnum"] intValue];
        
        if (box==0) {
           rightLabel.text  = [NSString stringWithFormat:@"%d盒",he];
            
        }else if(box>0&&he>0)
        {
            rightLabel.text  = [NSString stringWithFormat:@"%d箱%d盒",box,he];
            
        }else if(box>0&&he==0)
        {
            rightLabel.text  = [NSString stringWithFormat:@"%d箱",box];
            
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
       
        priceLabe.text = [NSString stringWithFormat:@"¥%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"detail"][i]objectForKey:@"price"]]]];
        priceLabe.frame= CGRectMake(24*Width, leftTopLabe.bottom+10*Width,300*Width , 80*Width);
        priceLabe.tag =250+i;
        priceLabe.textColor = NavColor;
        [bgview addSubview:priceLabe];
        
        //小计
        UILabel* allPriceLabel = [[UILabel alloc]init];
        allPriceLabel.textColor = BlackColor;

        NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"detail"][i]objectForKey:@"total"]]]];//总和
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
       if (![[dict objectForKey:@"agen"]isEqual:[NSNull null]]) {
           UIButton *examineBtn =[[UIButton alloc]initWithFrame:CGRectMake(580*Width, 15*Width, 145*Width,50*Width)];
           [btnView addSubview:examineBtn];
           
           [examineBtn setBackgroundColor:[UIColor whiteColor]];
           [examineBtn.layer setCornerRadius:4*Width];
           [examineBtn.layer setBorderWidth:1.0*Width];
           [examineBtn.layer setMasksToBounds:YES];
           [examineBtn setTitleColor:NavColor forState:UIControlStateNormal];
           examineBtn.layer.borderColor =NavColor.CGColor;

        if([[[dict objectForKey:@"agen"] objectForKey:@"level"] integerValue]>[[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"level"]] integerValue])
        {
            [examineBtn setTitle:@"审核通过" forState:UIControlStateNormal];
            [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
            [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [examineBtn addTarget:self action:@selector(examinePass) forControlEvents:UIControlEventTouchUpInside];
            [btnView addSubview:examineBtn];
            
//            
//        }else
//        {
//            
//            [examineBtn setTitle:@"流转" forState:UIControlStateNormal];
//            [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
//            [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//            [examineBtn addTarget:self action:@selector(cirAgen) forControlEvents:UIControlEventTouchUpInside];
//            [btnView addSubview:examineBtn];
//            
        }

    }
        [bgScrollView setContentSize:CGSizeMake(CXCWidth, btnView.bottom)];

    
    
    if ([[NSString stringWithFormat:@"%@",[_angeDic objectForKey:@"status"]]isEqualToString:@"1"]) {
        
        
    }else
    {
        btnView.hidden =YES;
        topBgView.hidden =YES;
        middleBgView.frame =CGRectMake(0, 0, CXCWidth,74*Width+5*Width*84 );
        bottomBgView.frame =CGRectMake(0, middleBgView.bottom, CXCWidth,74*Width*2+orderArr.count*Width*170);
    }

    
    
        
}
    
-(void)examinePass
{
    IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要通过审核吗？"];
    isture.delegate =self;
    isture.tag =180;
    [self.view addSubview:isture];
    
    return;

    



}

#pragma mark - IsTureAlterViewDelegate

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
    NSLog(@"确认");
    [self examineDetailPass];
    //删除
    
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getExaminePass
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"agen":[NSString stringWithFormat:@"%@",[_angeDic objectForKey:@"agenid"]] ,
                          @"viewid":[NSString stringWithFormat:@"%@",[_angeDic objectForKey:@"id"]],//viewID就是列表的id
                          @"orderid":[NSString stringWithFormat:@"%@",[_angeDic objectForKey:@"orderid"]] ,
                          @"agenid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/agenonlineorderdetail" paraments:dic1  addView:self.view success:^(id responseDic) {
        dict = [[NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        [MBProgressHUD showSuccess:@"审核成功" ToView:self.view];

        
        [self  mainView ];
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)examineDetailPass{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                         @"id":[NSString stringWithFormat:@"%@",[_angeDic objectForKey:@"id"]],
//                         @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          }
     ];
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/auditagenreview" paraments:dic1  addView:self.view success:^(id responseDic) {
      NSDictionary*  agenDict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil] ;
        if([ [NSString stringWithFormat:@"%@",[agenDict objectForKey:@"code"]]isEqualToString:@"0"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self performSelector:@selector(delayMethodSucess) withObject:nil afterDelay:0.5f];
        }

        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)delayMethodSucess
{
    
    [ProgressHUD showSuccess:@"审核通过"];
    [self.delegate reloadTheinformation];
    
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
