//
//  HYConfirmOrderVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/17.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYConfirmOrderVC.h"
#import "CXCThreeLabelSheet.h"
#import "CashierVC.h"
#import "HYConfirmOrderCell.h"
@interface HYConfirmOrderVC ()<CXCThreeLabelSheetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //底部scrollview
    UIScrollView *bgScrollView;
}


@end

@implementation HYConfirmOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor =BGColor;
    
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
    [navTitle setText:@"确认订单"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    
    
    [self mainView];
}
- (void)mainView
{
    
    
    UITableView *declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-20)style:UITableViewStyleGrouped];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setFrame:CGRectMake(0,64, CXCWidth, CXCHeight-100*Width-20*Width)];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:[UIColor clearColor]];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    
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
    NSString*str =@"实付款：¥2700.00";
    [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
    
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [subPromLabel setAttributedText:textColor];
    [subPromLabel  setFont:[UIFont systemFontOfSize:14]];
    [bottomBgview   addSubview:subPromLabel];
    //确认提交按钮
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(550*Width,0 , 200*Width, 100*Width)];
    [confirmBtn setBackgroundColor:NavColor];
    confirmBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [confirmBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];
    
    
}
- (void)confirmButtonAction
{

    CashierVC *cashVC =[[CashierVC alloc]init];
    [self.navigationController  pushViewController:cashVC animated:YES];
    



}
-(void)isSelectedBtnAction:(UIButton *)btn
{
    btn.selected =!btn.selected;
    
    
    
}
-(void)confirmOrder
{
    
    
}

- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)chooseAdress
{
    CXCThreeLabelSheet *sheet =[[CXCThreeLabelSheet alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight) with:@[@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际山东省潍坊市高新区胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"],@[@"孙家",@"18363671722",@"山东省潍坊市胜利东街新华路中天下潍坊国际"]]];
    sheet.tag=1111;
    sheet.delegate=self;
    [self.view addSubview:sheet];
    
    
    
    
    
    
}
-(void)btnClickName:(NSString *)nameString andPhone:(NSString *)phone andAdress:(NSString *)adress
{
    UILabel *nameLabel =[self.view viewWithTag:450];
    UILabel *phoneLabel =[self.view viewWithTag:451];
    UILabel *adressLabel =[self.view viewWithTag:452];
    [nameLabel setText:nameString];
    [phoneLabel setText:phone];
    [adressLabel setText:adress];
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    
    
}
-(void)hiddenCXCActionSheet
{
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    UILabel *nameLabel= [self.view viewWithTag:450];
    [nameLabel setText:@"请选择"];
    UILabel *numberLabel= [self.view viewWithTag:451];
    [numberLabel setText:@"请选择"];
    UILabel *adressLabel =[self.view viewWithTag:452];
    [adressLabel setText:@"请选择"];
    
    
    
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
    [topView addTarget:self action:@selector(chooseAdress) forControlEvents:UIControlEventTouchUpInside];
    
    [bgScrollView addSubview:topView];
    
    UILabel*nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60*Width, 25*Width, 150*Width, 50*Width)];
    nameLabel.text =@"孙磊开";
    nameLabel.tag=450;
    nameLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:nameLabel];
    
    
    UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.right+20*Width, 25*Width, 300*Width, 50*Width)];
    numberLabel.text =@"18373781822";
    numberLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:numberLabel];
    numberLabel.tag=451;
    
    UILabel *defaultLabel=[[UILabel alloc]initWithFrame:CGRectMake(490*Width, nameLabel.top+5*Width, 80*Width, 40*Width)];
    defaultLabel.textColor =NavColor;
    defaultLabel.text =@"默认";
    defaultLabel.font =[UIFont systemFontOfSize:12];
    [topView addSubview:defaultLabel];
    [defaultLabel.layer setCornerRadius:2*Width];
    [defaultLabel.layer setBorderWidth:1.5*Width];
    [defaultLabel.layer setMasksToBounds:YES];
    defaultLabel.textAlignment =NSTextAlignmentCenter;
    defaultLabel.layer.borderColor =NavColor.CGColor;
    //箭头
    UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 80*Width,40*Width , 40*Width)];
    [topView addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(20*Width, nameLabel.bottom+46*Width,24*Width, 32*Width)];
    [imgView setImage:[UIImage imageNamed:@"wuliu_icon_location"]];
    [topView addSubview:imgView];
    
    UILabel *addressLabel  =[[UILabel alloc]initWithFrame:CGRectMake(imgView.right+ 20*Width, nameLabel.bottom,620*Width, 125*Width)];
    [topView addSubview:addressLabel];
    addressLabel.text =@"山东省潍坊市高新区胜利东街新华路中天下潍坊国际";
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
    return 3;
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
        return cell;
        
        
    //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
    //    [cell setDic:dict];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 750*Width;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *bottomBgView =[[UIView alloc]init];
    bottomBgView.backgroundColor =BGColor;
    NSArray*leftArray =@[@"支付方式",@"配送方式",@"",@"",@"",] ;
    NSArray*rightArray =@[@"在线支付",@"快递包邮"] ;
    
    for (int i=0; i<2; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bottomBgView addSubview:bgview];
        bgview.frame =CGRectMake(0, i*82*Width+20*Width, CXCWidth, 82*Width);
        //左边提示
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
        labe.text = leftArray[i];
        //            labe.textAlignment=NSTextAlignmentLeft;
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [bgview addSubview:labe];
        //右边显示
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text = rightArray[i];
        rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =200+i;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = BlackColor;
        [bgview addSubview:rightLabel];
        //分割线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
        
    }
    UIView *jifenView =[[UIView alloc]initWithFrame:CGRectMake(0, 2*82*Width+40*Width, CXCWidth, 83*Width)];
    jifenView.backgroundColor =[UIColor whiteColor];
    [bottomBgView addSubview:jifenView];
    
    
    UILabel *jifenLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,0, 200*Width,83*Width )];
    jifenLabel.text =@"积分";
    jifenLabel.textColor =BlackColor;
    jifenLabel.font =[UIFont systemFontOfSize:14];
    [jifenView addSubview:jifenLabel];
    
    UILabel *jifenDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(110*Width,0, 600*Width,83*Width )];
    jifenDetailLabel.text =@"共300积分,可用200积分,抵扣¥200.00";
    jifenDetailLabel.textColor =BlackColor;
    jifenDetailLabel.font =[UIFont systemFontOfSize:12];
    [jifenView addSubview:jifenDetailLabel];
    
    
    
    
    UIButton *isSelectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    isSelectedBtn.frame = CGRectMake(650*Width, 0, 100*Width, 83*Width);
    [isSelectedBtn setImage:[UIImage imageNamed:@"confirm_checkbox_nor"]  forState:UIControlStateNormal];
    [isSelectedBtn setImage:[UIImage imageNamed:@"confirm_checkbox_norYI"]  forState:UIControlStateSelected];
    isSelectedBtn.selected = YES;
    [isSelectedBtn addTarget:self action:@selector(isSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [isSelectedBtn setImageEdgeInsets:UIEdgeInsetsMake( 19.5*Width,28*Width, 19.5*Width,28*Width)];
    [jifenView addSubview:isSelectedBtn];
    
    UIView *detailView =[[UIView alloc]initWithFrame:CGRectMake(0,jifenView.bottom+20*Width , CXCWidth, 135*Width)];
    [bottomBgView addSubview:detailView];
    detailView.backgroundColor =[UIColor whiteColor];
    NSArray *leftArr =@[@"积分总额",@"积分"];
    NSArray *rightArr =@[@"¥300000.00",@"-3000.00"];
    
    for (int i=0; i<2; i++) {
        UILabel *leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 10*Width+57.5*Width*i, 200*Width, 57.5*Width)];
        leftLabel.font =[UIFont systemFontOfSize:14];
        leftLabel.textColor =BlackColor;
        leftLabel.text = leftArr[i];
        [detailView addSubview:leftLabel];
        
        UILabel *rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(450*Width, 10*Width+57.5*Width*i, 275*Width, 57.5*Width)];
        rightLabel.font =[UIFont systemFontOfSize:14];
        rightLabel.textColor =NavColor;
        rightLabel.text = rightArr[i];
        rightLabel.textAlignment =NSTextAlignmentRight;
        [detailView addSubview:rightLabel];
        
        
    }
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
