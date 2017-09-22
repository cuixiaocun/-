//
//  CouponViewController.m
//  家装
//
//  Created by Admin on 2017/9/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponCell.h"
@interface CouponViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;

}
@end

@implementation CouponViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"优惠券"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,63, CXCWidth, 1);
    
    [self makeThisView];
    
}

- (void)returnBtnAction
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)rightBtnAction
{
    
    
}
////首页页面布局
-(void)makeThisView
{
    tableview  =[[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight  -20)style:UITableViewStyleGrouped];
    tableview .showsVerticalScrollIndicator = NO;
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
//    tableview.scrollEnabled = NO;
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview .showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableview];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 80*Width;
        
    }else
    {
        return 100*Width;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 4;
        
    }else if(section==1)
    {
        return 4;
    }
        
        return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 230*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"CellWithNumber";
        
        CouponCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        return cell;
        
    //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
    //    [cell setDic:dict];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 80*Width)];
    UILabel *xianV =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth,80*Width)];
    xianV.backgroundColor =BGColor;
    [bgview addSubview:xianV];
    //下边文字
    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,0*Width,CXCWidth,80*Width)];
    botLabel.font =[UIFont systemFontOfSize:16];
    botLabel.textColor =TextGrayColor;
    botLabel.backgroundColor =BGColor;
    if (section ==0) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    可用优惠券"];
    }else if(section ==1) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    已过期优惠券"];
        
    }else if(section ==2) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    已使用优惠券"];
        
    }

    [bgview  addSubview:botLabel];
    return bgview;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)moreTJ
{
    NSLog(@"111");
}
- (void)moreTS
{
    NSLog(@"222");
    
}
- (void)examinePass:(UIButton*)btn
{
    
    
}
- (void)chooseAddress
{
    
    
}
- (void)changeStatuBtn:(UIButton *)btn
{
    
    
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
