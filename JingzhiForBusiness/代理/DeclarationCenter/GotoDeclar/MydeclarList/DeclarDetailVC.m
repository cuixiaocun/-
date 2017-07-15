//
//  DeclarDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DeclarDetailVC.h"
#import "MyDeclarationCell.h"
#import "IsTureAlterView.h"
@interface DeclarDetailVC ()<UITableViewDelegate,UITableViewDataSource,IsTureAlterViewDelegate>
{
    NSArray *inforArray;
    NSDictionary *agenDic;
    NSDictionary *orrderDic;
    UITableView *declarTabel;
    
}
@end

@implementation DeclarDetailVC

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
    [navTitle setText:@"详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    inforArray =[[NSArray alloc]init];
    agenDic =[[NSDictionary alloc]init];
    
    [self getInfor];
    [self mainView];
}
- (void)mainView
{
    
    declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-64)style:UITableViewStyleGrouped];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:BGColor];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    

}
- (void)examinePass:(UIButton *)btn
{
    //审核通过
    IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要通过审核吗？"];
    isture.delegate =self;
    isture.tag =180;
    [self.view addSubview:isture];
    
    NSLog(@"驳回");

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

    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          @"id":_orderId}];
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/auditdagenonlineorder" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            
            [[self rdv_tabBarController] setSelectedIndex:0];
            [MBProgressHUD showSuccess:@"审核成功" ToView:self.view];
          
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    

    
}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (![agenDic isEqual:[NSNull null]]) {
        
   
    UIView *bgV =[self.view viewWithTag:123];
    [bgV removeFromSuperview];

    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 394*Width)];
    [self.view addSubview:bgView];
    bgView.tag =123;
    bgView.backgroundColor =[UIColor whiteColor];

    //时间
    UILabel* timeLabel  = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:timeLabel];
    timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
    timeLabel.backgroundColor =BGColor;
    timeLabel.textColor = TextGrayColor;
    //总额
    UILabel* pricesLabel  = [[UILabel alloc]init];
    pricesLabel.font = [UIFont systemFontOfSize:13];
    pricesLabel.textColor = TextGrayColor;
    [bgView addSubview:pricesLabel];
    pricesLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
    pricesLabel.backgroundColor =BGColor;
    pricesLabel.textAlignment = NSTextAlignmentRight;
    //订单号
    UILabel* orderNumberLabel  = [[UILabel alloc]init];
    orderNumberLabel.font = [UIFont systemFontOfSize:14];
  
    [bgView addSubview:orderNumberLabel];
    orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
    orderNumberLabel.textColor = TextGrayColor;
    //状态
    UILabel* orderStatuerLabel  = [[UILabel alloc]init];
    orderStatuerLabel.font = [UIFont systemFontOfSize:14];
    orderStatuerLabel.textAlignment =NSTextAlignmentRight;
    [bgView addSubview:orderStatuerLabel];
    orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
    orderStatuerLabel.textColor = NavColor;
    
    NSArray*leftArr =@[@"代理名称",@"账号",@"等级",@"",@"",@"",@"",@"",];
        NSArray*rightArr  =[[NSArray alloc]init];
        if ([_ismy isEqualToString:@"0"]) {
            rightArr=@[[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"agen"] objectForKey:@"upagenname"]],[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"agen"] objectForKey:@"upagenaccount"]],[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"agen"] objectForKey:@"upagenlevelname"]],@"",];
            

        }else
        {
            rightArr =@[[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"agen"] objectForKey:@"name"]],[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"agen"] objectForKey:@"account"]],[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"agen"] objectForKey:@"levelname"]],@"",];

        }

    for (int i=0; i<3; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =BGColor;
        [bgView addSubview:bgview];
        bgview.frame =CGRectMake(0, orderNumberLabel.bottom+82*i*Width, CXCWidth, 82*Width);
        if (i<3) {
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            labe.text = leftArr[i];
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            //右边内容
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textColor = NavColor;
            rightLabel.textColor = BlackColor;
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            [bgview addSubview:rightLabel];
            //细线
            UIImageView*xianOfGoods =[[UIImageView alloc]init];
            xianOfGoods.backgroundColor =[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
            [bgview addSubview:xianOfGoods];
            xianOfGoods.frame =CGRectMake(0*Width,80.5*Width,CXCWidth,1.5*Width);
            
            
        }
        if ([[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"status"]]isEqualToString:@"1"]) {
            orderStatuerLabel.text = @"待审核";

        }else if([[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"status"]]isEqualToString:@"3"])
        {
            orderStatuerLabel.text =@"已审核";
        }else if([[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"status"]] isEqualToString:@"2"])
        {
            orderStatuerLabel.text =@"已驳回";
        }else if([[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"status"]] isEqualToString:@"4"])
        {
            orderStatuerLabel.text =@"已完成";
        }else if([[NSString stringWithFormat:@"%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"status"]] isEqualToString:@"5"])
        {
            orderStatuerLabel.text =@"已取消";
        }

        timeLabel.text = [NSString stringWithFormat:@"      %@",[[agenDic objectForKey:@"oorder"] objectForKey:@"createtime"]];
        
        NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"total"]];//总和
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
        NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
        [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
        [pricesLabel setAttributedText:textColor];
        
        orderNumberLabel.text = [NSString stringWithFormat:@"     订单号:%@",[[agenDic objectForKey:@"oorder"] objectForKey:@"id"]];
    }
        return bgView;

    }else
    {
        return nil;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 394*Width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return inforArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyDeclarationCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyDeclarationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
        NSDictionary *dict = [inforArray objectAtIndex:[indexPath row]];
        [cell setDic:dict];
    return cell;
}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([_isHavePass isEqualToString:@"YES"])
    {    return 82*Width;

    }else
        return 0.01*Width;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([_isHavePass isEqualToString:@"YES"]) {
        
       //背景
    UIView *bgview =[[UIView alloc]init];
    bgview.backgroundColor =BGColor;
    bgview.frame =CGRectMake(0, 0, CXCWidth, 82*Width);
    bgview.backgroundColor =[UIColor whiteColor];
    UIButton *examineBtn =[[UIButton alloc]initWithFrame:CGRectMake(580*Width, 13.5*Width, 145*Width,50*Width)];
    [bgview addSubview:examineBtn];
    
    [examineBtn setBackgroundColor:[UIColor whiteColor]];
    [examineBtn.layer setCornerRadius:4*Width];
    [examineBtn.layer setBorderWidth:1.0*Width];
    [examineBtn.layer setMasksToBounds:YES];
    [examineBtn setTitleColor:NavColor forState:UIControlStateNormal];
    examineBtn.layer.borderColor =NavColor.CGColor;
    [examineBtn setTitle:@"审核通过" forState:UIControlStateNormal];
    [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [examineBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:examineBtn];
    
    
    
    
    
    return bgview;
    }
    else return nil;
    
}
- (void)getInfor
{
    
    //
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"orderid": _orderId,
                          @"flg":_ismy,
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/myagenonlineorderdetail" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            inforArray =[[dict objectForKey:@"data"] objectForKey:@"detail"];
            agenDic =[dict objectForKey:@"data"] ;
            [declarTabel reloadData];
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
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
