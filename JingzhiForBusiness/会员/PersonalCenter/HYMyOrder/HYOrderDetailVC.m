//
//  HYOrderDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYOrderDetailVC.h"
#import "HYConfirmOrderCell.h"
@interface HYOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    NSArray *goodsArr;
    
}
@end

@implementation HYOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    goodsArr =[[NSArray alloc]init];
    goodsArr =[_dic objectForKey:@"goods"];
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
    [navTitle setText:@"订单详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    
    
    [self mainView];
}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)mainView
{
    [self.view setBackgroundColor:BGColor];
    
    UITableView *declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-20)style:UITableViewStyleGrouped];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setFrame:CGRectMake(0,64, CXCWidth, CXCHeight-100*Width-20*Width)];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:[UIColor clearColor]];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth,220*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    
    UIButton *topView =[[UIButton alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 200*Width)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    
    [bgScrollView addSubview:topView];
    
    UILabel*nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60*Width, 25*Width, 150*Width, 50*Width)];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    nameLabel.tag=450;
    nameLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:nameLabel];
    
    
    UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.right+20*Width, 25*Width, 300*Width, 50*Width)];
    numberLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone"]];
    numberLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:numberLabel];
    numberLabel.tag=451;
    
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(20*Width, nameLabel.bottom+46*Width,24*Width, 32*Width)];
    [imgView setImage:[UIImage imageNamed:@"wuliu_icon_location"]];
    [topView addSubview:imgView];
    
    UILabel *addressLabel  =[[UILabel alloc]initWithFrame:CGRectMake(imgView.right+ 20*Width, nameLabel.bottom,620*Width, 125*Width)];
    [topView addSubview:addressLabel];
    addressLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"address"]];
    addressLabel.font =[UIFont systemFontOfSize:13];
    addressLabel.numberOfLines= 0;
    addressLabel.textColor =TextGrayColor;
    addressLabel.tag=452;

    
    return bgScrollView ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 220*Width;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return goodsArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 240*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HYConfirmOrderCell  *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HYConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    NSDictionary *dict = [goodsArr objectAtIndex:[indexPath row]];
    [cell setDic:dict];
    return cell;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 500*Width;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bottomBgView =[[UIView alloc]init];
    bottomBgView.backgroundColor =BGColor;

   

    UIButton *middleBgView =[[UIButton alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 200*Width)];
    middleBgView.backgroundColor =[UIColor whiteColor];
    [bottomBgView   addSubview:middleBgView];
      //当状态是未付款的时候支付方式要隐藏
      //paytype 1微信  2支付宝 0未支付
    UILabel*promLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,20*Width , 300*Width, 44*Width)];
    promLabel.text =@"支付方式";
    promLabel.textColor =BlackColor;
    promLabel.font =[UIFont systemFontOfSize:16];
    [middleBgView addSubview:promLabel];
    
    //银行卡头像背景
    UIImageView *cardPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(24*Width,promLabel.bottom+ 32*Width, 72*Width, 72*Width)];
    cardPhoto.userInteractionEnabled = YES;
    cardPhoto.tag =201;
        [middleBgView addSubview:cardPhoto];
    
    //名称
    UILabel *bankNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, promLabel.bottom+ 32*Width, 300*Width, 72*Width)];
    bankNameLabel.textColor =BlackColor;
    bankNameLabel.tag =202;
    bankNameLabel.font =[UIFont systemFontOfSize:16];
    [middleBgView addSubview:bankNameLabel];
    if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"paytype"]]isEqualToString:@"1"])
    {
        cardPhoto.image =[UIImage imageNamed:@"pay_icon_weChat"];
        bankNameLabel.text =@"微信支付";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"paytype"]]isEqualToString:@"2"])
    {
        cardPhoto.image =[UIImage imageNamed:@"pay_icon_alipay"];
        bankNameLabel.text =@"支付宝支付";
    }

    
    
    
    UIView *detailView =[[UIView alloc]init ];

    if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]]isEqualToString:@"5"]||[[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]]isEqualToString:@"6"]||[[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]]isEqualToString:@"1"])
    {
        middleBgView.hidden =YES;
       detailView.frame = CGRectMake(0,20*Width , CXCWidth, 215*Width);
    }else
    {
       middleBgView.hidden =NO;
       detailView.frame = CGRectMake(0,middleBgView.bottom+20*Width , CXCWidth, 215*Width);
    }
    
    
    
    
    [bottomBgView addSubview:detailView];
    detailView.backgroundColor =[UIColor whiteColor];
    NSArray *leftArr =@[@"商品总额",@"积分"];
    NSArray *rightArr =@[[NSString stringWithFormat:@"%@",[_dic objectForKey:@"total"]],[NSString stringWithFormat:@"%@",[_dic objectForKey:@"integral"]]];
    
    for (int i=0; i<2; i++) {
        UILabel *leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 10*Width+57.5*Width*i, 200*Width, 57.5*Width)];
        leftLabel.font =[UIFont systemFontOfSize:14];
        leftLabel.textColor =BlackColor;
        leftLabel.text = leftArr[i];
        [detailView addSubview:leftLabel];
    
        
        UILabel *rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(450*Width, 10*Width+57.5*Width*i, 275*Width, 57.5*Width)];
        rightLabel.font =[UIFont systemFontOfSize:14];
        rightLabel.textColor =BlackColor;
        rightLabel.text = rightArr[i];
        rightLabel.textAlignment =NSTextAlignmentRight;
        [detailView addSubview:rightLabel];
        
        
    }
    
    //线
    UIImageView*xianBottom =[[UIImageView alloc]init];
    xianBottom.backgroundColor =BGColor;
    [detailView addSubview:xianBottom];
    xianBottom.frame =CGRectMake(0*Width,133.5*Width, CXCWidth, 1.5*Width);
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width, xianBottom.bottom, 725*Width, 80*Width)];
    NSString*str =[NSString stringWithFormat:@"实付款：%.2f",([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"total"]] floatValue]-[[NSString stringWithFormat:@"%@",[_dic objectForKey:@"integral"]] floatValue])];
    subPromLabel.textAlignment =NSTextAlignmentRight;
    [subPromLabel setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
    
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [subPromLabel setAttributedText:textColor];
    [subPromLabel  setFont:[UIFont systemFontOfSize:14]];
    [detailView   addSubview:subPromLabel];
    
    return bottomBgView;
}

- (void)examinePass:(UIButton*)btn
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
