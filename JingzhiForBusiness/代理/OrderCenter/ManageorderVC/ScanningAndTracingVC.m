//
//  ScanningAndTracingVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ScanningAndTracingVC.h"
#import "XYMScanViewController.h"
#import "ScanAndTracCell.h"
#import "TracingCell.h"
#import "SendGoodsVC.h"
@interface ScanningAndTracingVC ()<UITableViewDelegate,UITableViewDataSource,XYMScanViewControllerDelegate>
{
    UIView *topView;
    UITableView *scanTableView;
    NSMutableArray *tracingArr;//溯源信息
    int box ;
}
@end

@implementation ScanningAndTracingVC
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
    [navTitle setText:@"扫码追溯"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    tracingArr =[[NSMutableArray alloc]init];
    //扫码按钮
    UIButton *  scanningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanningBtn.tag=1567;

    scanningBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    scanningBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [scanningBtn setImage:[UIImage imageNamed:@"tracert_btn_scan"] forState:UIControlStateNormal];
    
    [scanningBtn addTarget:self action:@selector(scanningBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:scanningBtn];
    [self clearInfo];
    [self mainView];
}
- (void)mainView
{
    scanTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-100*Width-64)style:UITableViewStyleGrouped];
    [scanTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [scanTableView setDelegate:self];
    [scanTableView setDataSource:self];
    [scanTableView setBackgroundColor:[UIColor clearColor]];
    scanTableView .showsVerticalScrollIndicator = NO;
    [self.view addSubview:scanTableView];
    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomBgview];
    //线
    UIImageView*xianBottom =[[UIImageView alloc]init];
    xianBottom.backgroundColor =BGColor;
    [bottomBgview addSubview:xianBottom];
    xianBottom.frame =CGRectMake(0*Width,0*Width, CXCWidth, 1.5*Width);
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 450*Width, 100*Width)];
    subPromLabel.tag =340;
    [subPromLabel  setFont:[UIFont systemFontOfSize:14]];
    [bottomBgview   addSubview:subPromLabel];
    //确认提交按钮
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(550*Width,0 , 200*Width, 100*Width)];
    [confirmBtn setBackgroundColor:NavColor];
    confirmBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];

}
- (void)scanningBtnAction
{
    //扫描二维码
    XYMScanViewController *scanView = [[XYMScanViewController alloc]init];
    scanView.delegate =self;
    [self.navigationController pushViewController:scanView animated:YES];
    

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
    if (section==0) {
        
    
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 312*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    //时间
    UILabel* timeLabel  = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.text = [NSString stringWithFormat:@"      %@",[_orderDetailDic objectForKey:@"createtime"]];
    [topView addSubview:timeLabel];
    timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
    timeLabel.backgroundColor =BGColor;
    timeLabel.textColor = TextGrayColor;
    //总额
    UILabel* pricesLabel  = [[UILabel alloc]init];
    pricesLabel.font = [UIFont systemFontOfSize:13];
    pricesLabel.textColor = TextGrayColor;
    NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",[_orderDetailDic objectForKey:@"total"]];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [pricesLabel setAttributedText:textColor];
    [topView addSubview:pricesLabel];
    pricesLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
    pricesLabel.backgroundColor =BGColor;
    pricesLabel.textAlignment = NSTextAlignmentRight;
    //订单号
    UILabel* orderNumberLabel  = [[UILabel alloc]init];
    orderNumberLabel.font = [UIFont systemFontOfSize:14];
    orderNumberLabel.text = [NSString stringWithFormat:@"     订单号：%@",[_orderDetailDic objectForKey:@"id"]];
    [topView addSubview:orderNumberLabel];
    orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
    orderNumberLabel.textColor = TextGrayColor;
    //状态
    UILabel* orderStatuerLabel  = [[UILabel alloc]init];
    orderStatuerLabel.font = [UIFont systemFontOfSize:14];
    if([[NSString stringWithFormat:@"%@",[_orderDetailDic objectForKey:@"status"]] isEqualToString:@"2"])
    {
        orderStatuerLabel.text =@"未发货";

    }else if([[NSString stringWithFormat:@"%@",[_orderDetailDic objectForKey:@"status"]] isEqualToString:@"3"])
    {
        orderStatuerLabel.text =@"已发货";
        
    }else if([[NSString stringWithFormat:@"%@",[_orderDetailDic objectForKey:@"status"]] isEqualToString:@"4"])
    {
            orderStatuerLabel.text =@"已完成";
            
    }

    orderStatuerLabel.textAlignment =NSTextAlignmentRight;
    [topView addSubview:orderStatuerLabel];
    orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
    orderStatuerLabel.textColor = NavColor;
        NSString *numString;
    NSArray*leftArr =@[@"商品",@"数量",@"",@"",@"",@"",@"",];
         box =[[_orderDetailDic objectForKey:@"num"] intValue]/[[_orderDetailDic objectForKey:@"boxnum"] intValue];
        int he =[[_orderDetailDic objectForKey:@"num"] intValue]%[[_orderDetailDic objectForKey:@"boxnum"] intValue];
        
        if (box==0) {
            numString = [NSString stringWithFormat:@"%d盒",he];
            
        }else if(box>0&&he>0)
        {
           numString = [NSString stringWithFormat:@"%d箱%d盒",box,he];
            
        }else if(box>0&&he==0)
        {
            numString = [NSString stringWithFormat:@"%d箱",box];
            
        }

    NSArray*rightArr =@[[NSString stringWithFormat:@"%@",[_orderDetailDic objectForKey:@"name"]],numString,@"",@"",];
    for (int i=0; i<2; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [topView addSubview:bgview];
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
            xianOfGoods.frame =CGRectMake(24*Width,80.5*Width,CXCWidth,1.5*Width);
            
            
        }
    }
    return topView;
    }else
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 312*Width;
    }
    return 0.01*Width;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tracingArr.count>0)
    {
        NSArray*arr=[tracingArr [section] objectForKey:@"flowlist"];
        
        return arr.count+1;
    }else
        return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tracingArr.count==0) {
        return 1;

    }else
    {
        return tracingArr.count;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tracingArr.count>0) {

    if(indexPath.row==0)
    {
        return 160*Width;

    }else
    {
        
        NSArray*arr=[tracingArr[indexPath.section] objectForKey:@"flowlist"];
     ;
        

        NSString *titleContent =[NSString stringWithFormat:@"%@",arr[indexPath.row-1]];
        CGSize titleSize;//通过文本得到高度

        titleSize = [titleContent boundingRectWithSize:CGSizeMake(500*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

        return  titleSize.height+40*Width;
     }
    }else
    {
        return 0.01;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tracingArr.count>0) {
     
     if (indexPath.row ==0)
    {
        static NSString *CellIdentifier = @"Cell1";
        TracingCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TracingCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }

        cell.dic =tracingArr[indexPath.row];
        return cell;
        

    
    }else  {
        
        static NSString *CellIdentifier = @"Cell";
        ScanAndTracCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ScanAndTracCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        NSLog(@"++++++++++++++++%ld",indexPath.row);
        NSArray*arr=[tracingArr[indexPath.section] objectForKey:@"flowlist"];

        cell.dic =@[[NSString stringWithFormat:@"%@",arr[indexPath.row-1]],[NSString stringWithFormat:@"%ld",arr.count],[NSString stringWithFormat:@"%ld",indexPath.row]];
        
        return cell;
        ;
        
        
    }
    }else
    {
        return nil;
    }
    
    
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
    return 0.01;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
    
}
- (void)confirmButtonAction
{

    if (box==tracingArr.count) {
        //如果满一箱就可以扫描，零头不算
        SendGoodsVC *sendGoods =[[SendGoodsVC alloc]init];
        sendGoods.orderDetailDic =_orderDetailDic;
        [self.navigationController pushViewController:sendGoods animated:YES];
    }else if (box>tracingArr.count)
    {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多%d箱",box] ToView:self.view];
        return;
    }else
    {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最少%d箱",box] ToView:self.view];
        return;

    }
   
    
}
- (void)clearInfo
{
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/seltracing" paraments:@{@"id":[NSString stringWithFormat:@"%@",[_orderDetailDic objectForKey:@"id"]]}  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
}
- (void)getScanString:(NSString *)scanDataString
{
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/addtracing" paraments:@{
                                                                                   
//      @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
      @"tracingsn":scanDataString,
      }
    addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
//            NSDictionary *dictracinfo =[[dict objectForKey:@"data"] objectForKey:@"tracinfo"];
//            tracingArr =[[NSMutableArray alloc]init];
//            NSArray *arr =[dictracinfo allKeys];
//            for (int i=0; i<arr.count; i++) {
//                if (i==0) {
//                    
//                    [tracingArr addObject:[dictracinfo objectForKey:@""]];
//                }else
//                {
//                    [tracingArr addObject:[dictracinfo objectForKey:[NSString stringWithFormat:@"%d",i]]];
//                }
//            }
            tracingArr =[[dict objectForKey:@"data"] objectForKey:@"tracinfo"];
            NSString*str =[NSString stringWithFormat:@"已扫描：%ld箱",tracingArr.count];
            UILabel *subPromLabel =[self.view viewWithTag:340];
            [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
            
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
            NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
            [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
            [subPromLabel setAttributedText:textColor];
            
            [scanTableView reloadData];
            if (box==tracingArr.count) {
                UIButton *btn =[self.view viewWithTag:1567];
                btn.hidden =YES;
            }

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
