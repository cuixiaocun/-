//
//  ManageDeclareVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ManageDeclareVC.h"
#import "GoodsAndNumCell.h"
#import "ManageDeclarCell.h"
#import "DeclarDetailVC.h"
#import "IsTureAlterView.h"

@interface ManageDeclareVC ()<UITableViewDelegate,UITableViewDataSource,ManagerDelegate,IsTureAlterViewDelegate >
{
    UITableView *declarTabel;
}
@end

@implementation ManageDeclareVC

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
    [navTitle setText:@"我的订单"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    
    
    [self mainView];
}
- (void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)mainView
{
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 100*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray *btnArr =@[@"全部",@"待审核",@"已审核"];
    for (int i=0; i<3; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statuBtn.frame = CGRectMake(CXCWidth/3*i, 0,CXCWidth/3-2*Width ,100*Width);
        if ([_statusString isEqualToString:btnArr[i]]) {
            statuBtn.selected =YES;
        }
        if (i<4) {
            //横线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [topView addSubview:xian];
            xian.frame =CGRectMake(statuBtn.right,25*Width, Width, 50*Width);
            
        }
        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
        statuBtn.tag =220+i;
        [statuBtn addTarget:self action:@selector(changeStatuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:statuBtn];
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topView addSubview:xian];
    xian.frame =CGRectMake(0,98*Width, CXCWidth, 2*Width);
    
    
    declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64+100*Width, CXCWidth, CXCHeight-20)style:UITableViewStyleGrouped];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setFrame:CGRectMake(0,64+100*Width, CXCWidth, CXCHeight-100-20*Width)];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:[UIColor clearColor]];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ if(indexPath.section==0)
 {
     return;
    
 }else
 {
     DeclarDetailVC *declarDetail =[[DeclarDetailVC alloc]init];
    declarDetail.isHavePass =@"YES";//可以审核的
     declarDetail.ismy =@"1";
//     declar.orderId =[infoArray[indexPath.row] objectForKey:@"id"];

     [self.navigationController pushViewController:declarDetail animated:YES];
 
 }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        NSString *str=@"  当前产品数量";
        CGSize titleSize;//通过文本得到高度
        titleSize = [str boundingRectWithSize:CGSizeMake( MAXFLOAT,70*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel*promLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,0 ,CXCWidth,70*Width )];
        promLabel.text =str;
        promLabel.backgroundColor =BGColor;
        promLabel.font =[UIFont systemFontOfSize:14];
        promLabel.textColor =TextColor;
        return promLabel;
        

    }else
    {
        return nil;
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{  if(section==0)
  {
      return 70*Width;

  }else
      return 0.01*Width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 80*Width;
    }
    return 476*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        static NSString *CellIdentifier = @"Cell0";
        GoodsAndNumCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[GoodsAndNumCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
        //    [cell setDic:dict];
        return cell;
    
    }else
    {
        static NSString *CellIdentifier = @"Cell1";
        ManageDeclarCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ManageDeclarCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        cell.delegate =self;
        //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
        //    [cell setDic:dict];
        return cell;
        
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
    return 0.01*Width;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
    
    
}
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [ declarTabel indexPathForCell:cell];
    
    switch (flag) {
        case 2000:
        {
        //详情
            DeclarDetailVC *declar =[[DeclarDetailVC alloc]init];
            [self.navigationController pushViewController:declar animated:YES];
            
            break;
            
        }
        case 2001:
        {
           //审核通过
            IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要通过审核吗？"];
            isture.delegate =self;
            isture.tag =180;
            [self.view addSubview:isture];
            
            NSLog(@"驳回");
            return;

            
            break;

        }
    
  }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //删除
    
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
