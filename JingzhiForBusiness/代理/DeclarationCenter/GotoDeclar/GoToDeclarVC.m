//
//  GoToDeclarVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/9.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoToDeclarVC.h"
#import "GoodsModel.h"
#import "GoodsCell.h"

@interface GoToDeclarVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,GoodsCellDelegate>
{
    NSString *minMoney;//最低拿货金额

    
    UIScrollView *bgScrollView;//上半部分
    UITableView *goodsTableview;//中间商品
    NSMutableArray *infoArr;//商品信息
    double allPrice;//总共价格
    UILabel *_allPriceLab;//总共价格Labbel
    BOOL isHaveDian;//判断小数点
    UIView* blackBgView;//输入框背景透明黑
    UIView *alterView;//弹出输入框
    NSInteger indextNum;//定位在哪个单元格点击的（alterView 用）
}
@end

@implementation GoToDeclarVC

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
    [navTitle setText:[NSString stringWithFormat:@"%@",@"报单"]];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    [self mainView];
    [self minimumMoney];

}
- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, 360*Width )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    
    //顶部提示
    UILabel *promptLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 60*Width)];
    promptLabel.backgroundColor  =[UIColor colorWithRed:255/255.0 green:239/255.0 blue:212/255.0 alpha:1];
    promptLabel.textColor =[UIColor colorWithRed:249/255.0 green:98/255.0 blue:48/255.0 alpha:1];
    promptLabel.tag =1122;
    promptLabel.font =[UIFont systemFontOfSize:14];
    [bgScrollView addSubview:promptLabel];
    
    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0,promptLabel.bottom, CXCWidth, 324*Width)];
    [bgScrollView addSubview:bgview];
    [bgview setBackgroundColor:[UIColor whiteColor]];
    //金额
    //提示部分
    UILabel *promLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width, 35*Width, CXCWidth, 60*Width)];
    [promLabel setFont:[UIFont systemFontOfSize:14]];
    [bgview addSubview:promLabel];
    promLabel.textAlignment =NSTextAlignmentCenter;
    promLabel.text =@"拿货金额（¥）";
    [promLabel setTextColor:TextGrayColor];
    //输入金额
    UITextField *inputText = [[UITextField alloc] init];
    [inputText setTag:2];
    [inputText setPlaceholder:@"请输入金额"];
    [inputText setDelegate:self];
    inputText.keyboardType =UIKeyboardTypeDecimalPad;
    inputText.textAlignment=NSTextAlignmentCenter;
    [inputText setFont:[UIFont systemFontOfSize:20]];
    [inputText setTextColor:[UIColor blackColor]];
    [inputText setFrame:CGRectMake(0*375*Width, promLabel.bottom, CXCWidth, 70*Width)];
    [bgview addSubview:inputText];
     
 
    //横线
    UIImageView*bottomXian =[[UIImageView alloc]init];
    bottomXian.backgroundColor =BGColor;
    [bgview addSubview:bottomXian];
    bottomXian.frame =CGRectMake(0*Width,200*Width, CXCWidth, 1*Width);
    //系统计算按钮
    UIButton * calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [calculateBtn setFrame:CGRectMake(275*Width,bottomXian.bottom+18*Width , 200*Width, 64*Width)];
    [calculateBtn setBackgroundColor:[UIColor whiteColor]];
    [calculateBtn.layer setCornerRadius:4*Width];
    [calculateBtn.layer setBorderWidth:1.0*Width];
    [calculateBtn.layer setMasksToBounds:YES];
    [calculateBtn setTitleColor:[UIColor colorWithRed:19/255.0 green:157/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
    calculateBtn.layer.borderColor =[UIColor colorWithRed:19/255.0 green:157/255.0 blue:229/255.0 alpha:1].CGColor;
    [calculateBtn setTitle:@"系统计算" forState:UIControlStateNormal];
    [calculateBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [calculateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [calculateBtn addTarget:self action:@selector(calculateTheGoods) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:calculateBtn];
    
    //初始化数据
    allPrice = 0.0;
    infoArr = [[NSMutableArray alloc]init];
    /**
     *  初始化一个数组，数组里面放字典。字典里面放的是单元格需要展示的数据
     */
    
    //中间的tableview
    goodsTableview   =[[UITableView alloc]init];
    [goodsTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    goodsTableview .showsVerticalScrollIndicator = NO;
    
    [goodsTableview setFrame:CGRectMake(0,bgScrollView.bottom+20*Width,CXCWidth,CXCHeight-bgScrollView.height-64-100*Width )];
    [goodsTableview setDelegate:self];
    
    [goodsTableview setDataSource:self];
    [self.view addSubview:goodsTableview];
    goodsTableview.hidden =YES;//先隐藏当系统计算的时候再显示
    
    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomBgview];
    //线
    UIImageView*xianBottom =[[UIImageView alloc]init];
    xianBottom.backgroundColor =BGColor;
    [bottomBgview addSubview:xianBottom];
    xianBottom.frame =CGRectMake(0*Width,0*Width, CXCWidth, 1.5*Width);
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 100*Width, 100*Width)];
    [subPromLabel setText:@"合计:"];
    [subPromLabel  setFont:[UIFont systemFontOfSize:17]];
    [bottomBgview   addSubview:subPromLabel];
    [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
    //底部总价
    UILabel *subNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(125*Width, 0, 500*Width, 100*Width)];
    [subNumLabel setText:@"¥0"];
    [subNumLabel  setFont:[UIFont systemFontOfSize:17]];
    [subNumLabel    setTextColor:NavColor];
    [bottomBgview   addSubview:subNumLabel];
    _allPriceLab =subNumLabel;
    //确认提交按钮
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(550*Width,0 , 200*Width, 100*Width)];
    [confirmBtn setBackgroundColor:NavColor];
    confirmBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [confirmBtn setTitle:@"报单" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];
}
//确认提交按钮
- (void)confirmButtonAction
{
    NSString *stringForGoods =@"";//代理注册提交报单的拼接字符串
    for (int i=0; i<infoArr.count; i++) {
        GoodsModel *goodsModel=infoArr[i];
        NSString *idStr =goodsModel.goodID;
        int numStr =goodsModel.goodsNum;
        if (i<infoArr.count-1) {
            stringForGoods = [stringForGoods stringByAppendingFormat:@"%@,%d,",idStr,numStr];
        }else
        {
            stringForGoods = [stringForGoods stringByAppendingFormat:@"%@,%d",idStr,numStr];
        }
        
    }
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSString *url ;

    //参数
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          @"products":stringForGoods
                          }];
    url=@"home/AgentOnlineorder/addagenonlineorder";
    
    //网络请求
    [PublicMethod AFNetworkPOSTurl:url paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self performSelector:@selector(successTheAction) withObject:nil afterDelay:0.5f];
            
            
        }
        
    } fail:^(NSError *error) {
        
        
        
    }];
    

    
}
- (void)successTheAction
{
    
       [ProgressHUD showSuccess:@"报单成功"];
    
}

//系统计算
- (void)calculateTheGoods
{
    
    UITextField *moneyText =[self.view viewWithTag:2];
    [moneyText resignFirstResponder];

    if ([moneyText.text doubleValue]<[minMoney doubleValue]) {
        [MBProgressHUD showError:@"输入金额不得小于最低金额" ToView:self.view];
        return;
    }

    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"money":moneyText.text
                          }];
    NSLog(@"%@",dic1);
    
    [PublicMethod AFNetworkPOSTurl:@"home/Agen/getAgenBuyInfo" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            goodsTableview.hidden =NO;//显示tableview
            NSDictionary *prolistDic =[[dict objectForKey:@"data"]objectForKey:@"prolist"];
            NSArray *values = [prolistDic allValues];
            infoArr =[[NSMutableArray alloc]init];
            for (int i = 0; i<values.count; i++)
            {
                NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
                [infoDict setValue:[NSString stringWithFormat:@"%@",[values[i] objectForKey:@"name"]] forKey:@"goodsTitle"];
                [infoDict setValue:[NSString stringWithFormat:@"%@",[values[i] objectForKey:@"myprice"]] forKey:@"goodsPrice"];
                [infoDict setValue:[NSNumber numberWithBool:YES] forKey:@"selectState"];
                [infoDict setValue:[NSString stringWithFormat:@"%.2f",([[values[i] objectForKey:@"myprice"] doubleValue] *[[values[i] objectForKey:@"num"] doubleValue])] forKey:@"goodsTotalPrice"];
                [infoDict setValue:[NSNumber numberWithInt:[[values[i] objectForKey:@"num"] doubleValue]] forKey:@"goodsNum"];
                [infoDict setValue:[NSNumber numberWithInt:[[values[i] objectForKey:@"boxnum"] doubleValue]] forKey:@"boxnum"];
                [infoDict setValue:[NSNumber numberWithInt:[[values[i] objectForKey:@"id"] doubleValue]] forKey:@"goodID"];
                
                //封装数据模型
                GoodsModel *goodsModel = [[GoodsModel alloc]initWithDict:infoDict];
                //将数据模型放入数组中
                [infoArr addObject:goodsModel];
                
            }
            [self totalPrice];//求总和
            [goodsTableview reloadData];//更新一下tableView
            
            
            
            
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
    
}
//返回按钮
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =  @"indentify";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[GoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    
   
    //调用方法，给单元格赋值
    [cell addTheValue:infoArr[indexPath.row]];
    
    return cell;
}
//返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*Width;
}
//点击其他地方收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITextField *textF =[self.view viewWithTag:2];
    [textF resignFirstResponder];
    
}
//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}
-(void)selectBtnClick:(UIButton *)sender
{
    //判断是否选中，是改成否，否改成是，改变图片状态
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        [sender setImage:[UIImage imageNamed:@"复选框-选中.png"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"复选框-未选中.png"] forState:UIControlStateNormal];
    }
    //改变单元格选中状态
    for (int i=0; i<infoArr.count; i++)
    {
        GoodsModel *model = [infoArr objectAtIndex:i];
        model.selectState = sender.tag;
    }
    //计算价格
    [self totalPrice];
    //刷新表格
    [goodsTableview reloadData];
    
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识，11 为减按钮，12为加按钮 10为输入框按钮
 */
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [goodsTableview indexPathForCell:cell];
    
    switch (flag) {
        case 10:
        {
            indextNum =index.row;
            
            [self alterView:index.row];
            
            break;
            
        }
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            GoodsModel *model = infoArr[index.row];
            if (model.goodsNum > 0)
            {
                model.goodsNum --;
                model.goodsTotalPrice =[NSString stringWithFormat:@"%.2f",[model.goodsPrice doubleValue]*model.goodsNum] ;
                
            }
        }
            break;
        case 12:
        {
            //做加法
            GoodsModel *model = infoArr[index.row];
            
            model.goodsNum ++;
            model.goodsTotalPrice =[NSString stringWithFormat:@"%.2f",[model.goodsPrice doubleValue]*model.goodsNum] ;
            
            
        }
            break;
        default:
            break;
    }
    
    //刷新表格
    [goodsTableview reloadData];
    
    //计算总价
    [self totalPrice];
    
}

#pragma mark -- 计算价格
-(void)totalPrice
{
    //每次算完要重置为0，因为每次的都是全部循环算一遍
    allPrice = 0.0;
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    for ( int i =0; i<infoArr.count; i++)
    {
        GoodsModel *model = [infoArr objectAtIndex:i];
        if (model.selectState)
        {
            allPrice = allPrice + model.goodsNum *[model.goodsPrice  doubleValue];
        }
    }
    
    //给总价文本赋值
    _allPriceLab.text = [NSString stringWithFormat:@"¥%.2f",allPrice];
    NSLog(@"%f",allPrice);
    
    
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
        return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 7) {
        //            [ProgressHUD showError:@"不能超过6位"];
        [textField  resignFirstResponder];
        
        
        return NO;
    }
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [MBProgressHUD  showError:@"第一个数字不能为小数点" ToView:self.view];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if ([textField.text length]==1) {
                if ([textField.text isEqualToString:@"0"]) {
                    if(single >='0' && single<='9'){
                        [textField resignFirstResponder ];
                        [MBProgressHUD  showError:@"输入金额有误!" ToView:self.view];
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        
                        return NO;
                        
                        
                    }
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [MBProgressHUD  showError:@"您已经输入过小数点了" ToView:self.view];
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        
                        [MBProgressHUD  showError:@"您最多输入两位小数" ToView:self.view];
                        
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [MBProgressHUD  showError:@"您输入的格式不正确" ToView:self.view];
            
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    return YES;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//alterView
- (void)alterView:(NSInteger)index
{
    //若存在就不走里边的直接hidden=no;
    if (!blackBgView) {
        blackBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
        [blackBgView setAlpha:0.5];
        [blackBgView  setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:blackBgView];
        
        
        alterView=[[UIView alloc]initWithFrame:CGRectMake(75*Width, 200*Width, 620*Width, 360*Width)];
        [self.view addSubview:alterView];
        [alterView setBackgroundColor:[UIColor whiteColor]];
        [alterView.layer setCornerRadius:20*Width];
//        [alterView.layer setBorderWidth:1.0*Width];
//        alterView.layer.borderColor =BGColor.CGColor;
        [alterView.layer setMasksToBounds:YES];
        
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0*Width, 620*Width, 120*Width)];
        label.textAlignment =NSTextAlignmentCenter;
        [label setText:@"修改拿货数量"];
        [alterView addSubview:label];
        
        //购买商品的数量
        UITextField*  _numCountLab = [[UITextField alloc]initWithFrame:CGRectMake(210*Width,label.bottom,190*Width , 90*Width)];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        _numCountLab.tag=120;
        _numCountLab.keyboardType =UIKeyboardTypeNumberPad;
        _numCountLab.layer.borderColor =BGColor.CGColor;
        [_numCountLab.layer setBorderWidth:1.0*Width];
        [alterView addSubview:_numCountLab];
        
        //减按钮
        UIButton* _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(120*Width, label.bottom, 90*Width, 90*Width);
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        [_deleteBtn setImage:[UIImage imageNamed:@"register_btn_reduce_modify_black"] forState:UIControlStateNormal];
        [_deleteBtn.layer setBorderWidth:1.0*Width];
        _deleteBtn.layer.borderColor =BGColor.CGColor;
        [alterView addSubview:_deleteBtn];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(15*Width, 15*Width,15*Width, 15*Width);
        
        
        //加按钮
        UIButton* _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(400*Width, label.bottom, 90*Width, 90*Width);
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(15*Width, 15*Width,15*Width, 15*Width);
        
        [_addBtn.layer setBorderWidth:1.0*Width];
        _addBtn.layer.borderColor =BGColor.CGColor;
        [_addBtn setImage:[UIImage imageNamed:@"register_btn_add_modify_black"] forState:UIControlStateNormal];
        
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        [alterView addSubview:_addBtn];
        //线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [alterView addSubview:xian];
        xian.frame =CGRectMake(0*Width,260*Width, 620*Width, 1*Width);
        //取消按钮
        UIButton*cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, xian.bottom, 310*Width, 100*Width)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [alterView addSubview:cancelBtn];
        //确认按钮
        UIButton*tureBtn =[[UIButton alloc]initWithFrame:CGRectMake(310*Width, xian.bottom, 310*Width, 100*Width)];
        [tureBtn setBackgroundColor:NavColor];
        [tureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tureBtn addTarget:self action:@selector(tureBtn) forControlEvents:UIControlEventTouchUpInside];
        [alterView addSubview:tureBtn];
    }
    
    UITextField *textF =[self.view viewWithTag:120];
    [textF becomeFirstResponder];//收起键盘
    GoodsModel *model = infoArr[indextNum];
    textF.text =[NSString stringWithFormat:@"%d",model.goodsNum];//取得数量
    
    blackBgView.hidden=NO;
    alterView.hidden =NO;
    
}
//-
- (void)deleteBtnAction
{
    UITextField *textF =[self.view viewWithTag:120];
    if(textF.text.length==0||[textF.text isEqualToString:@"0"])
    {
        return;
        
    }else
    {
        textF.text =[NSString stringWithFormat:@"%ld",([textF.text integerValue]-1)];
        
        
    }
    
    
}
//+
- (void)addBtnAction
{
    UITextField *textF =[self.view viewWithTag:120];
    textF.text =[NSString stringWithFormat:@"%ld",([textF.text integerValue]+1)];
    
    
}
//确认
- (void)tureBtn
{
    blackBgView.hidden=YES;
    
    alterView.hidden =YES;
    
    
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    
    
    GoodsModel *model = infoArr[indextNum];
    NSString*numberstr;

    if ([textF.text integerValue]==0) {
        [MBProgressHUD showWarn:@"数量有误" ToView:self.view];
         numberstr=@"1";
        model.goodsNum =[numberstr intValue];

        
    }else
    {
        numberstr =[NSString stringWithFormat:@"%ld",[textF.text integerValue]];
        model.goodsNum =[numberstr intValue];

    }

    
    model.goodsTotalPrice =[NSString stringWithFormat:@"%.2f",[model.goodsPrice doubleValue]*model.goodsNum] ;
    
    //刷新表格
    [goodsTableview reloadData];
    
    //计算总价
    [self totalPrice];
    
}
//取消
-(void)cancelBtn
{
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    
    blackBgView.hidden=YES;
    
    alterView.hidden =YES;
    
}
-(void)minimumMoney
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          }];
    NSLog(@"%@",dic1);
    
    [PublicMethod AFNetworkPOSTurl:@"home/Agen/getAgenBuyInfo" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            minMoney=  [NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"]objectForKey:@"minmoney"]];
            
            UILabel *promptLabel =[self.view viewWithTag:1122];
            promptLabel.text =[NSString stringWithFormat:@"    提示：最低拿货金额%@元",minMoney];
            UITextField *textF =[self.view viewWithTag:2];
            textF.text =[NSString stringWithFormat:@"%@",minMoney];
            [self calculateTheGoods];
            
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
