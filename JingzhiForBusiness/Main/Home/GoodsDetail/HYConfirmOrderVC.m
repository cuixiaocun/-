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
#import "AddAddressVC.h"
@interface HYConfirmOrderVC ()<CXCThreeLabelSheetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    float allIntegral;//总积分
    float allPrice;//总共价格
    float canPayIntegral;//可抵扣积分
    float turePay;//实际付款
    UITableView *declarTabel;//tableview
    NSMutableArray *infoArray;
    NSString *addressIdString;
    
    UIButton *isSelectedBtn;//按钮
}


@end

@implementation HYConfirmOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    canPayIntegral =0.00;
    infoArray =[[NSMutableArray alloc]init];

    [self getArr];
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
- (void)getArr
{
    addressIdString =[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"addressid"]];
    allIntegral =0.00;
    allPrice =0.00;
    turePay =0.00;
    canPayIntegral =0.00;
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    for ( int i =0; i<_googsArr.count; i++)
    {
        NSMutableDictionary *model =[NSMutableDictionary dictionaryWithDictionary:_googsArr[i]];
        
        allIntegral = allIntegral + [[model objectForKey:@"deductible"] floatValue] ;//总积分
        allPrice = allPrice + [[model objectForKey:@"goodsNum"] integerValue] *[[model  objectForKey:@"goodsPrice" ] floatValue];//总价
    }
    
    if ([[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"integral"]] floatValue]<allIntegral) {
        
        canPayIntegral =[[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"integral"]] floatValue];
        
    }else
    {
        canPayIntegral =allIntegral;
    }
    turePay =allPrice-canPayIntegral;


}
- (void)mainView
{
    
    
    declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-20)style:UITableViewStyleGrouped];
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
    NSString*str =[NSString stringWithFormat:@"实付款：¥%.2f",turePay ];
    subPromLabel.tag =1999;
    [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
    
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [subPromLabel setAttributedText:textColor];
    subPromLabel.tag =11112;
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
//立即下单
- (void)confirmButtonAction
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSString *stringForGoods =@"";
    for (int i=0; i<_googsArr.count; i++) {
        NSDictionary *dict =_googsArr[i];
        ;
        
        NSString *idStr =[dict objectForKey:@"goodID"];
        NSString *numStr =[dict objectForKey:@"goodsNum"];
        if (i<_googsArr.count-1) {
            stringForGoods = [stringForGoods stringByAppendingFormat:@"%@,%@,",idStr,numStr];

        }else
        {
            stringForGoods = [stringForGoods stringByAppendingFormat:@"%@,%@",idStr,numStr];

        }
        
    }
    [dic1 setDictionary:@{@"addressId":addressIdString,
                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]],
                          @"checked":isSelectedBtn.selected?@"true":@"false",
                          
                              @"products":stringForGoods
                              
                          }];
    [PublicMethod AFNetworkPOSTurl:@"Home/OnlineOrder/createOrder" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            float beforIntager=[[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"integral"]] floatValue];
            float newIntager=beforIntager-canPayIntegral;
            [[PublicMethod getDataKey:member]setValue:[NSString stringWithFormat:@"%.2f",newIntager] forKey:@"integral"];
            
            
            CashierVC *cashVC =[[CashierVC alloc]init];
            cashVC.orderDic =[[dict objectForKey:@"data"] objectForKey:@"order"];
            cashVC.orderId =[[[dict objectForKey:@"data"] objectForKey:@"order"] objectForKey:@"id"];
            [self.navigationController  pushViewController:cashVC animated:YES];
            
            

        }
        
    } fail:^(NSError *error) {
        
    }];

    
    
    
    
  

}
-(void)isSelectedBtnAction:(UIButton *)btn
{
    if (btn.selected==YES) {
        btn.selected =NO;
        canPayIntegral = 0;
        turePay =allPrice-canPayIntegral;

    }else
    {
        btn.selected =YES ;

        [self getArr];
    }
    UILabel *jifenlabel =[self.view viewWithTag:3301];
    jifenlabel.text =[NSString stringWithFormat:@"-%.2f",canPayIntegral];
    NSString*str =[NSString stringWithFormat:@"实付款：¥%.2f",turePay ];
    UILabel *subPromLabel =[self.view viewWithTag:11112];
    [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
    
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [subPromLabel setAttributedText:textColor];

    
}
-(void)confirmOrder
{
    
    
}

- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)btnClickName:(NSString *)nameString andPhone:(NSString *)phone andAdress:(NSString *)adress withID:(NSString *)str withDefaut:(NSString *)def
{
    UILabel *nameLabel =[self.view viewWithTag:450];
    UILabel *phoneLabel =[self.view viewWithTag:451];
    UILabel *adressLabel =[self.view viewWithTag:452];
    [nameLabel setText:nameString];
    [phoneLabel setText:phone];
    [adressLabel setText:adress];
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    if ([def isEqualToString:@"1"]) {
        UILabel*defaultLabel =[self.view viewWithTag:33345];
        defaultLabel.hidden =NO;

    }else
    {
        UILabel*defaultLabel =[self.view viewWithTag:33345];
        defaultLabel.hidden =YES;
    }
    addressIdString =str;
    
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
    [topView addTarget:self action:@selector(getAdress) forControlEvents:UIControlEventTouchUpInside];
    
    [bgScrollView addSubview:topView];
    
    UILabel*nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60*Width, 25*Width, 150*Width, 50*Width)];
    nameLabel.text =[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"receivename"]];
    nameLabel.tag=450;
    nameLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:nameLabel];
    
    
    UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.right+20*Width, 25*Width, 300*Width, 50*Width)];
    numberLabel.text =[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"receivephone"]];
    numberLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:numberLabel];
    numberLabel.tag=451;
    
    UILabel *defaultLabel=[[UILabel alloc]initWithFrame:CGRectMake(490*Width, nameLabel.top+5*Width, 80*Width, 40*Width)];
    defaultLabel.textColor =NavColor;
    defaultLabel.text =@"默认";
    defaultLabel.font =[UIFont systemFontOfSize:12];
    [topView addSubview:defaultLabel];
    defaultLabel.tag =33345;
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
    if ([[[PublicMethod getDataKey:member] objectForKey:@"name_path"]isEqual:[NSNull null]]||[[[PublicMethod getDataKey:member] objectForKey:@"name_path"]isEqualToString:@"<null>"]) {
        addressLabel.text =@"请完善";
        defaultLabel.hidden =YES;

    }else
    {
      addressLabel.text =[NSString stringWithFormat:@"%@%@",[[PublicMethod getDataKey:member] objectForKey:@"name_path"],[[PublicMethod getDataKey:member] objectForKey:@"address"]];
        defaultLabel.hidden =NO;

    }
    
  
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
    return _googsArr.count;
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
    NSDictionary *dict = [_googsArr objectAtIndex:[indexPath row]];
    [cell setDicForGoods:dict];
    return cell;
        
        
    
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
    jifenDetailLabel.textColor =BlackColor;
    jifenDetailLabel.font =[UIFont systemFontOfSize:12];
    [jifenView addSubview:jifenDetailLabel];
    
     jifenDetailLabel.text =[NSString stringWithFormat:@"共%@积分,可用%.2f积分,抵扣¥%.2f",[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"integral"]],canPayIntegral, canPayIntegral];//当前积分小于可抵扣积分的时候，显示当前积分，大于可抵扣积分时，显示可抵扣积分
    
    
    isSelectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    isSelectedBtn.frame = CGRectMake(650*Width, 0, 100*Width, 83*Width);
    [isSelectedBtn setImage:[UIImage imageNamed:@"confirm_checkbox_nor"]  forState:UIControlStateNormal];
    [isSelectedBtn setImage:[UIImage imageNamed:@"confirm_checkbox_norYI"]  forState:UIControlStateSelected];
    if(canPayIntegral>0)
    {
        isSelectedBtn.selected = YES;

    }else
    {
        isSelectedBtn.selected = NO;

    }
    
    [isSelectedBtn addTarget:self action:@selector(isSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [isSelectedBtn setImageEdgeInsets:UIEdgeInsetsMake( 19.5*Width,28*Width, 19.5*Width,28*Width)];
    [jifenView addSubview:isSelectedBtn];
    
    UIView *detailView =[[UIView alloc]initWithFrame:CGRectMake(0,jifenView.bottom+20*Width , CXCWidth, 135*Width)];
    [bottomBgView addSubview:detailView];
    detailView.backgroundColor =[UIColor whiteColor];
    NSArray *leftArr =@[@"积分总额",@"积分"];
   
//    [declarTabel reloadData];
    NSArray *rightArr =@[[NSString stringWithFormat:@"%.2f",allPrice],[NSString stringWithFormat:@"-%.2f",canPayIntegral]];
    
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
        rightLabel.tag =3300+i;
        rightLabel.textAlignment =NSTextAlignmentRight;
        [detailView addSubview:rightLabel];
        
        
    }
    return bottomBgView;
}
- (void)examinePass:(UIButton*)btn
{
    
    
}
- (void)getAdress
{
    UILabel*defaultLabel =[self.view viewWithTag:33345];
    defaultLabel.hidden =YES;
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          //                          @"page":[NSString stringWithFormat:@"%ld",currentPage] ,
                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]]
                          }];
    [PublicMethod AFNetworkPOSTurl:@"Home/address/index" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            
            infoArray=[[dict objectForKey:@"data"] objectForKey:@"address_list"];
            if(infoArray.count>0)
            {

            CXCThreeLabelSheet *sh =[self.view viewWithTag:1111];
            [sh removeFromSuperview];
            
            CXCThreeLabelSheet *sheet =[[CXCThreeLabelSheet alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight) with:infoArray];
                sheet.tag=1111;
                sheet.delegate=self;
                [self.view addSubview:sheet];
            }else
            {
                AddAddressVC *address =[[AddAddressVC alloc]init];
                [self.navigationController pushViewController:address animated:YES];
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
