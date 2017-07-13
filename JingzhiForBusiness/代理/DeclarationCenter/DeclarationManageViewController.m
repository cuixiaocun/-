//
//  DeclarationManageViewController.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/9.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DeclarationManageViewController.h"
#import "MyDeclarationCell.h"
#import "GoodsAndNumCell.h"
@interface DeclarationManageViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation DeclarationManageViewController
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
//    [navTitle setText:@"报单管理"];
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
        if (i==0) {
            statuBtn.selected =YES;
        }
        if (i<4) {
            //横线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [topView addSubview:xian];
            xian.frame =CGRectMake(statuBtn.right,25*Width, Width, 50*Width);
            
        }
        //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
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
    

    UITableView *declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64+100*Width, CXCWidth, CXCHeight-20)style:UITableViewStyleGrouped];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setFrame:CGRectMake(0,64+100*Width, CXCWidth, CXCHeight-100-20*Width)];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:BGColor];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
  {
      UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,CXCWidth ,80*Width)];
      label.text =@"    当前产品数量";
      label.font =[UIFont systemFontOfSize:14];
      label.textColor =TextGrayColor;
      label.backgroundColor =BGColor;
      return label;
  }else
  {
  
 
    UIView * bottomBgView =[[UIView alloc]init];
    [bottomBgView setBackgroundColor:[UIColor whiteColor]];
    bottomBgView.frame =CGRectMake(0,0, CXCWidth,74*Width*2+2*Width);;
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
    
    return bottomBgView;
  }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 80*Width;
        
    }else
        
    return 74*Width*2+2*Width;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 3;
        
    }else
        
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 80*Width;
        
    }else
        
    return 170*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"CellWithNumber";

        GoodsAndNumCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[GoodsAndNumCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        return cell;

        
    }else
    {
        static NSString *CellIdentifier = @"Cell";

        MyDeclarationCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MyDeclarationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        return cell;


    }
       //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
    //    [cell setDic:dict];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }

    return 80*Width;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return nil;
    
    }else
    {
    UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 80*Width)];
    btnView.backgroundColor =[UIColor whiteColor];
    UIButton *examineBtn =[[UIButton alloc]initWithFrame:CGRectMake(580*Width, 15*Width, 145*Width,50*Width)];
    [btnView addSubview:examineBtn];
    
    [examineBtn setBackgroundColor:[UIColor whiteColor]];
    [examineBtn.layer setCornerRadius:4*Width];
    [examineBtn.layer setBorderWidth:1.0*Width];
    [examineBtn.layer setMasksToBounds:YES];
    [examineBtn setTitleColor:NavColor forState:UIControlStateNormal];
    examineBtn.layer.borderColor =NavColor.CGColor;
    examineBtn.tag =2000+section;
    [examineBtn setTitle:@"审核通过" forState:UIControlStateNormal];
    [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [examineBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:examineBtn];
    return btnView;
    
    }


}
- (void)examinePass:(UIButton*)btn
{


}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<5; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    
    
    
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
