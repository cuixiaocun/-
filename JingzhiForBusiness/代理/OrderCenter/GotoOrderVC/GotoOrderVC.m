//
//  GotoOrderVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GotoOrderVC.h"
#import "GoOrderCell.h"
#import "ConfirmOrderVC.h"
@interface GotoOrderVC ()<UITableViewDelegate,UITableViewDataSource,goOrderCellDelegate>
{
    UIView* blackBgView;//输入框背景透明黑
    UIView *alterView;//弹出输入框
    UITableView*  declarTabel ;
}

@end

@implementation GotoOrderVC

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
    [navTitle setText:@"去下单"];
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

    declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-20)];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:BGColor];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell0";
        GoOrderCell  *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[GoOrderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
    cell.delegate =self;
        //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
        //    [cell setDic:dict];
        return cell;
        
}

-(void)goOrderBtnClick:(UITableViewCell *)cell andActionTag:(NSInteger)flag
{
    NSIndexPath *index = [declarTabel indexPathForCell:cell];

    if (flag ==10) {//中间数量
        [self alterView:index.row];
        
        
    }else if (flag ==11){//－
        NSLog(@"减");
        //做减法
        //先获取到当期行数据源内容，改变数据源内容，刷新表格
//        GoodsModel *model = infoArr[index.row];
//        if (model.goodsNum > 0)
//        {
//            model.goodsNum --;
//            model.goodsTotalPrice =[NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue]*model.goodsNum] ;
//            
//        }

    
    }else if (flag ==12){//＋
        NSLog(@"加");

        //做加法
//        GoodsModel *model = infoArr[index.row];
//        
//        model.goodsNum ++;
//        model.goodsTotalPrice =[NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue]*model.goodsNum] ;
        

    }else if (flag ==13){//下单
        ConfirmOrderVC *confirm =[[ConfirmOrderVC alloc]init];
        [self.navigationController pushViewController:confirm animated:YES];
        
        
        
        NSLog(@"下单");
    }else if (flag ==14){//
        
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [textF becomeFirstResponder];//键盘
//    GoodsModel *model = infoArr[indextNum];
//    textF.text =[NSString stringWithFormat:@"%d",model.goodsNum];//取得数量
     textF.text =[NSString stringWithFormat:@"%@",@"12"];
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
    
//    GoodsModel *model = infoArr[indextNum];
//    model.goodsNum =[textF.text intValue];
//    model.goodsTotalPrice =[NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue]*model.goodsNum] ;
    
    //刷新表格
    [declarTabel reloadData];
    
    
    
}
//取消
-(void)cancelBtn
{
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    
    blackBgView.hidden=YES;
    
    alterView.hidden =YES;
    
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
