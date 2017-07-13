//
//  BankCardListVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/8.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "BankCardListVC.h"
#import "BankCardCell.h"
#import "AddBankCardVC.h"
@interface BankCardListVC ()<BankCardCellDelegate,AddBankDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *bankArr;
}
@end

@implementation BankCardListVC

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
    [navTitle setText:@"银行卡"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    bankArr =[[NSArray alloc]init];
    infoArray =[[NSMutableArray alloc]init];

    [self getInfoList];
   
    
    [self mainView];
}
- (void)mainView
{ //左边线
    UIImageView* leftXian =[[UIImageView alloc]initWithFrame:CGRectMake(24*Width, 64+20*Width, 4*Width, 44*Width)];
    leftXian.backgroundColor = NavColor;
    [self.view addSubview:leftXian];
    //右边提示
    UILabel *promLabel =[[UILabel alloc]initWithFrame:CGRectMake(45*Width,64, 650*Width, 84*Width)];
    promLabel.text =@"务必保证收款账户姓名、账户等信息真实有效";
    [self.view addSubview:promLabel];
    promLabel.font =[UIFont systemFontOfSize:13];
    self.tableView =[[UITableView alloc]init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,64+84*Width, CXCWidth, CXCHeight-20-44-80*Width)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView .showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    infoArray = [[NSMutableArray alloc] init];
    UIView *bgview= [[UIView alloc]initWithFrame:CGRectMake(0*Width,0 ,750*Width , 300*Width)];
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(25*Width,0, 700*Width, 270*Width)];//(3)为卡片数量
    [addBtn setImage:[UIImage imageNamed:@"bcard_bg_addcard"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:addBtn];
    self.tableView.tableFooterView = bgview;
    
}
- (void)addBtnAction
{
    AddBankCardVC *addBtnVC =[[AddBankCardVC alloc]init];
    addBtnVC.bankArr =bankArr;
    addBtnVC.delegate =self;
    [self.navigationController pushViewController:addBtnVC animated:YES];
    
    
}
#pragma mark cell的代理方法
- (void)btnClick:(UITableViewCell *)cell andTag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSString *url ;

    [dic1 setDictionary:@{
                          @"id":[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[infoArray[index.row] objectForKey:@"id"]]] ,
                          
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                          }];
    url =@"home/Account/setDefault";

   [PublicMethod AFNetworkPOSTurl:url paraments:dic1  addView:self.view success:^(id responseDic) {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
    if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
        
            for (int i=0; i<infoArray.count; i++) {
            [infoArray [i] setObject:@"2" forKey:@"isdefault"];
            
        }
        [infoArray [index.row] setObject:@"1" forKey:@"isdefault"];
        [self.tableView reloadData];
        
        
    }
    
} fail:^(NSError *error) {
    
}];



}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    BankCardCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BankCardCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
        cell.delegate =self;
        NSDictionary *dict = [infoArray objectAtIndex:row];
        [cell setDic:dict];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCardVC *addBtnVC =[[AddBankCardVC alloc]init];
    addBtnVC.bankArr =bankArr;
    addBtnVC.delegate =self;
    
    addBtnVC.bankDetailDic = infoArray[indexPath.row];
    [self.navigationController pushViewController:addBtnVC animated:YES];
    



}

- (void)getInfoList
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/Account/bankcard" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"])         {
            bankArr =[[dict objectForKey:@"data"] objectForKey:@"bank"];

            infoArray =[[dict objectForKey:@"data"] objectForKey:@"cardlist"];
            [self.tableView reloadData];

            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)needReloadData
{
    [self getInfoList];

}


@end
