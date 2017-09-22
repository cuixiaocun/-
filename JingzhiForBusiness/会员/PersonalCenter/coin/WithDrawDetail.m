//
//  WithDrawDetail.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "WithDrawDetail.h"
#import "CXCTwoLableSheet.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CoinViewController.h"
@interface WithDrawDetail ()<UITextFieldDelegate,CXCTwoLableSheetDelegate >
{
    TPKeyboardAvoidingScrollView *bgScrollView;
    BOOL isHaveDian;//判断小数点
    NSInteger listTime;
    NSTimer *huoquTimer;
    UIButton *sendCodeBtn;
    NSArray*bankAllArr;
    NSString *bankIdString;



}

@end

@implementation WithDrawDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    bankIdString =@"wu";

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
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"金币"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    UIButton *  withDrawlsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withDrawlsBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    withDrawlsBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [withDrawlsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [withDrawlsBtn setTitle:@"明细" forState:UIControlStateNormal];
    [withDrawlsBtn addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:withDrawlsBtn];

    [self  withdrawalsMoneyInfo];
    [self mainView];
}
- (void)detailAction
{
    CoinViewController *coinVC =[[CoinViewController alloc]init];
    [self.navigationController pushViewController:coinVC animated:YES];

}
- (void)mainView
{
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 64+20*Width,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    bgScrollView.showsHorizontalScrollIndicator = FALSE;
    
    UIView*topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 446*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:topView];
    
    UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(300*Width, 50*Width, 150*Width, 150*Width)];
    [topImgV setImage:[UIImage imageNamed:@"me_icon_glod"]];
    [topView addSubview:topImgV];
    
    UILabel *promeLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, topImgV.bottom, CXCWidth, 80*Width)];
    promeLabel.text =@"我的金币";
    promeLabel.textAlignment =NSTextAlignmentCenter;
    promeLabel.textColor =BlackColor ;
    promeLabel.font =[UIFont systemFontOfSize:14];
    [topView addSubview:promeLabel ];
    
    UILabel *coinLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, promeLabel.bottom, CXCWidth, 132*Width)];
    coinLabel.tag =200;
    coinLabel.text =@"23";

    coinLabel.textAlignment =NSTextAlignmentCenter;
    coinLabel.textColor =BlackColor ;
    coinLabel.font =[UIFont systemFontOfSize:40];
    [topView addSubview:coinLabel ];
    
    UIButton *middleBgView =[[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+20*Width, CXCWidth, 136*Width)];
    middleBgView.backgroundColor =[UIColor whiteColor];
    [bgScrollView   addSubview:middleBgView];
    [middleBgView addTarget:self action:@selector(showCXCActionSheetView) forControlEvents:UIControlEventTouchUpInside];
    
    //银行卡头像背景
    UIImageView *cardPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(24*Width, 32*Width, 72*Width, 72*Width)];
    cardPhoto.userInteractionEnabled = YES;
    cardPhoto.tag =201;
    cardPhoto.image =[UIImage imageNamed:@"pay_icon_alipay"];
    [middleBgView addSubview:cardPhoto];
    
    //名称
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, cardPhoto.top-10*Width, 350*Width, 36*Width)];
    
    nameLabel.textColor =BlackColor;
    nameLabel.text =@"支付宝";
    nameLabel.tag =202;
    
    nameLabel.font =[UIFont systemFontOfSize:16];
    [middleBgView addSubview:nameLabel];

    
    //moren
    UILabel *promLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, nameLabel.bottom+10*Width, 550*Width, 36*Width)];
    promLabel.textColor =TextGrayColor;
    promLabel.text =@"推荐支付宝用户使用";
    promLabel.tag =203;
    promLabel.font =[UIFont systemFontOfSize:14];
    [middleBgView addSubview:promLabel];
    //箭头
    UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 47*Width,40*Width , 40*Width)];
    [middleBgView addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
    
    

    
    UIView *bottomBgView =[[UIView alloc]initWithFrame:CGRectMake(0, middleBgView.bottom+20*Width, CXCWidth, 190*Width)];
    bottomBgView.backgroundColor =[UIColor whiteColor];
    [bgScrollView   addSubview:bottomBgView];
    //提现金额
    UILabel *promNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 0*Width, 350*Width, 80*Width)];
    promNumLabel.textColor =BlackColor;
    promNumLabel.text =@"充值金额";
    promNumLabel.font =[UIFont systemFontOfSize:16];
    [bottomBgView addSubview:promNumLabel];
    UILabel *RMBLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, promNumLabel.bottom, 50*Width, 100*Width)];
    RMBLabel.textColor =BlackColor;
    RMBLabel.text =@"¥";
    RMBLabel.font =[UIFont boldSystemFontOfSize:30];
    [bottomBgView addSubview:RMBLabel];
    UITextField *inputText = [[UITextField alloc] init];
    [inputText setTag:204];
    [inputText setKeyboardType:UIKeyboardTypePhonePad];
    [inputText setPlaceholder:@"请输入充值金额"];
    [inputText setDelegate:self];
    inputText.keyboardType =UIKeyboardTypeDecimalPad;
    inputText.textAlignment =NSTextAlignmentLeft;
    [inputText setFont:[UIFont boldSystemFontOfSize:28]];
    [inputText setTextColor:[UIColor blackColor]];
    [inputText setFrame:CGRectMake(RMBLabel.right, RMBLabel.top,600*Width,100*Width)];
    [bottomBgView addSubview:inputText];
//    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(24*Width, inputText.bottom, CXCWidth, 1.5*Width)];
//    [bottomBgView addSubview:xian];
//    xian.backgroundColor =BGColor;
//    //提现金额
//    UILabel *balanceLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, xian.bottom, 700*Width, 80*Width)];
//    balanceLabel.textColor =TextColor;
//    
//    [balanceLabel setTag:205];
//    balanceLabel.font =[UIFont systemFontOfSize:14];
//    [bottomBgView addSubview:balanceLabel];
//    //全部提现
//    
//    UIButton *drawlsAllBtn =[[UIButton alloc]initWithFrame:CGRectMake(100*Width, xian.bottom, 600*Width, 80*Width)];
//    [drawlsAllBtn.layer setCornerRadius:4];
//    [drawlsAllBtn setTitleColor:NavColor forState:UIControlStateNormal];
//    [drawlsAllBtn.layer setMasksToBounds:YES];
//    [drawlsAllBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//    [drawlsAllBtn addTarget:self action:@selector(allDrawlsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [drawlsAllBtn setTitle:@"" forState:UIControlStateNormal];
//    [drawlsAllBtn.titleLabel setTextColor:[UIColor whiteColor]];
//    [drawlsAllBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
//    [bottomBgView addSubview:drawlsAllBtn];
//    
//    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0, bottomBgView.bottom+20*Width, CXCWidth,106*Width)];
//    bgview.backgroundColor =[UIColor whiteColor];
//    [bgScrollView addSubview:bgview];
//    
//    UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
//    labe.text = @"验证码";
//    labe.font = [UIFont systemFontOfSize:15];
//    labe.textColor = [UIColor grayColor];
//    [bgview addSubview:labe];
//    
//    UITextField *yzmTextF = [[UITextField alloc] init];
//    [yzmTextF setTag:1034];
//    [yzmTextF setDelegate:self];
//    [yzmTextF setFont:[UIFont systemFontOfSize:15]];
//    [yzmTextF setTextColor:[UIColor blackColor]];
//    [yzmTextF setFrame:CGRectMake(220*Width, 0,580*Width,106*Width)];
//    [bgview addSubview:yzmTextF];
//    [yzmTextF setPlaceholder:@"请输入"];
//    UIButton *butto = [[UIButton alloc]initWithFrame:CGRectMake(520*Width, 13*Width, 200*Width, 80*Width)];
//    [butto.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [butto setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [butto setTitle:[NSString stringWithFormat:@"%lds",listTime] forState:UIControlStateSelected];
//    butto.tag = 345;
//    butto.backgroundColor =BGColor;
//    [butto setTitleColor:NavColor forState:UIControlStateNormal];
//    [butto setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1] forState:UIControlStateSelected];
//    [butto addTarget:self action:@selector(yanzhengma:) forControlEvents:UIControlEventTouchUpInside];
//    [bgview addSubview:butto];
//    sendCodeBtn =butto;

    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(370*Width, bottomBgView.bottom+20*Width, 24*Width, 24*Width)];
    imgV.image =[UIImage imageNamed:@"withdrawcash_icon_remind"];
    [bgScrollView addSubview:imgV];
    
    UILabel *tishiLabel =[[UILabel alloc]initWithFrame:CGRectMake(imgV.right, bottomBgView.bottom , 350*Width, 64*Width)];
    tishiLabel.text =@"提示:1RMB=1金币，最小充值¥1";
    [bgScrollView addSubview:tishiLabel];
    tishiLabel.textColor =TextGrayGrayColor;
    tishiLabel.font =[UIFont systemFontOfSize:12];
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,bottomBgView.bottom+ 106*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.cornerRadius = 10;
    layer.shadowColor = NavColor.CGColor;

    [bgScrollView.layer addSublayer:layer];

    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,bottomBgView.bottom+ 106*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"充值" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(sureDrawls) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
        //这里self表示当前自定义的view
 }
- (void)allDrawlsBtnAction:(UIButton *)btn
{
    
    UILabel *coinLabel =[self.view viewWithTag:200];
    UITextField *textF =[self.view viewWithTag:204];
    UITextField *textYZM =[self.view viewWithTag:1034];
    [textYZM resignFirstResponder];
    [textF resignFirstResponder];
    textF.text =coinLabel.text;
}
-(void)sureDrawls
{
    UITextField *textMoney =[self.view viewWithTag:204];
    UITextField *textYZM =[self.view viewWithTag:1034];

    if([bankIdString isEqualToString:@"wu"])
    {
        [MBProgressHUD showWarn:@"请选择银行卡" ToView:self.view];
        return;
    }
    if([textMoney.text isEqualToString:@""])
    {
        [MBProgressHUD showWarn:@"输入金额" ToView:self.view];
        return;
    }
    
    if([textYZM.text isEqualToString:@""])
    {
        [MBProgressHUD showWarn:@"请输入验证码" ToView:self.view];
        return;
    }
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"amount":[NSString stringWithFormat:@"%@",textMoney.text],
                          @"bankinfo":bankIdString,
                          @"mobilecode":[NSString stringWithFormat:@"%@",textYZM.text],
                          }];
    [PublicMethod AFNetworkPOSTurl:@"home/Account/withdrawal" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"])
        {
            [MBProgressHUD  showSuccess:@"提现成功" ToView:self.view];
            [self performSelector:@selector(withdrawSuccess) withObject:nil afterDelay:1];

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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    UITextField *textF =[self.view viewWithTag:204];
    [textF resignFirstResponder];
    


}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==204) {
        if (string.length == 0)
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 10) {
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

    }else
    {
        return YES;

    }
   return YES;
}
-(void)showCXCActionSheetView
{
    
    if (bankAllArr.count==0) {
        {
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            [dic1 setDictionary:@{
//                                  @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                                  }
             ];
            
            [PublicMethod AFNetworkPOSTurl:@"home/Account/bankcard" paraments:dic1  addView:self.view success:^(id responseDic) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
                if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"])         {
   
                }
                
            } fail:^(NSError *error) {
                
            }];
            
        }
       
        
    }else
    {
    
        CXCTwoLableSheet *sheet =[[CXCTwoLableSheet alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight) with:bankAllArr];
        sheet.tag=1111;
        sheet.delegate=self;
        [self.view addSubview:sheet];
    }
   
    
    

}
- (void)btnClickName:(NSString *)nameString andBankNumber:(NSString *)bankNum withid:(NSString *)idstring withIsDefult:(NSString *)isDefult
{
    UILabel *nameLabel= [self.view viewWithTag:202];
    [nameLabel setText:nameString];
    
    UILabel *numberLabel= [self.view viewWithTag:203];
    [numberLabel setText:bankNum];
    
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    
    bankIdString=idstring;
    UILabel*defaultLabel =[self.view viewWithTag:302];
    

    if ([isDefult isEqualToString:@"1"]) {
        defaultLabel.hidden =NO;

    }else
    {
        defaultLabel.hidden =YES ;

    }


}
-(void)hiddenCXCActionSheet
{
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];
    UILabel *nameLabel= [self.view viewWithTag:202];
    [nameLabel setText:@"请选择"];
    
    UILabel *numberLabel= [self.view viewWithTag:203];
    [numberLabel setText:@"请选择"];
    


}
- (void)yanzhengma:(UIButton *)sender
{
    if (sender.selected) {
        sender.userInteractionEnabled =YES;
        
        
        return;
    }else{
        
        sender.userInteractionEnabled =NO;
        
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.transform =CGAffineTransformIdentity;
        
    }];
    
    [self getInfoLLL];
    
    
    
}
-(void)daoshu
{
    listTime-=1;
    UIButton *yanzhengBtn = (UIButton *)[self.view viewWithTag:345];
    
    if (listTime==0) {
        [yanzhengBtn setSelected:NO];
        [huoquTimer invalidate];
        listTime =60;
        [yanzhengBtn setUserInteractionEnabled:YES];
        
    }else{
        [yanzhengBtn setTitle:[NSString stringWithFormat:@"%lds",listTime] forState:UIControlStateSelected];
        
    }
}

-(void)sendCodeBtnPressed
{
    if (huoquTimer) {
        [huoquTimer fire];
    }else{
        huoquTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitCode) userInfo:nil repeats:YES];
        [huoquTimer fire];
    }
}
-(void)waitCode
{
    [self getInfoLLL];
    
    if (listTime>1) {
        listTime--;
        [sendCodeBtn setTitle:[NSString stringWithFormat:@"%lds",listTime] forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:[UIColor colorWithWhite:189/255.0 alpha:1] forState:UIControlStateNormal];
        
        [sendCodeBtn setUserInteractionEnabled:NO];
    }else{
        listTime=60;
        [sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:[UIColor colorWithRed:201/255.0 green:33/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
        [sendCodeBtn setUserInteractionEnabled:YES];
        [huoquTimer invalidate];
        
    }
}

//短信验证
- (void)getInfoLLL
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{}];
    
    [PublicMethod AFNetworkPOSTurl:@"Home/Account/getnum" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
            [MBProgressHUD showSuccess:@"验证码正在发送中" ToView:self.view];
            sender.selected=!sender.selected;
            [huoquTimer invalidate];
            listTime =60;
            huoquTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoshu) userInfo:nil repeats:YES];
            [huoquTimer fire];
            [sender setUserInteractionEnabled:NO];
            
        }else
        {
            UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
            [sender setUserInteractionEnabled:YES];
            
        }
        
    } fail:^(NSError *error) {
        UIButton *sender = (UIButton *)[self.view  viewWithTag:345];
        [sender setUserInteractionEnabled:YES];
    }];
    
    
    
}

- (void)withdrawalsMoneyInfo
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"home/Account/cash" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        UILabel*coinLabel =[self.view viewWithTag:200];
        UILabel*balanceLabel =[self.view viewWithTag:205];
        UILabel*nameLabel =[self.view viewWithTag:202];
        UILabel*defaultLabel =[self.view viewWithTag:302];
        UILabel*bankLabel =[self.view viewWithTag:203];
        bankAllArr =[[NSArray alloc]init];

        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"])
        {
            NSDictionary*rechargeDic =[[dict objectForKey:@"data"] objectForKey:@"recharge"];
            NSDictionary*bankDic =[[dict objectForKey:@"data"] objectForKey:@"user_bank"];
            

                     coinLabel.text =[NSString stringWithFormat:@"%@",[rechargeDic objectForKey:@"balance"]];
            
            if ([[[dict objectForKey:@"data"] objectForKey:@"user_bank"]isEqual:[NSNull null]]||[[NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"user_bank"]]isEqualToString:@"<null>"]) {
                //若有默认值
                nameLabel.text =[NSString stringWithFormat:@"%@",@"请选择"];
                bankLabel.text =[NSString stringWithFormat:@"%@",@"请选择"];
                defaultLabel.hidden =YES;
                

                
            }else
            {
                nameLabel.text =[NSString stringWithFormat:@"%@",[bankDic objectForKey:@"bankname"]];
                bankLabel.text =[NSString stringWithFormat:@"%@",[bankDic objectForKey:@"number"]];
                if ([[NSString stringWithFormat:@"%@",[bankDic objectForKey:@"isdefault"]]isEqualToString:@"1"]) {//1默认，2普通
                    defaultLabel.hidden =NO;
                }else
                {
                    defaultLabel.hidden =YES;
                }

            }
            
            bankIdString =[bankDic objectForKey:@"id"];
            
            NSString *totalString =[NSString stringWithFormat:@"当前可提现余额%@元,全部提现",[rechargeDic objectForKey:@"balance"]];//总和
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
            NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:textColor.length-4]];
            [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
            [balanceLabel setAttributedText:textColor];
            bankAllArr =[[dict objectForKey:@"data"] objectForKey:@"user_all_bank"];
            
            
        }else
        {
            //若有默认值
            nameLabel.text =[NSString stringWithFormat:@"%@",@"请选择"];
            bankLabel.text =[NSString stringWithFormat:@"%@",@"请选择"];
            defaultLabel.hidden =YES;

        
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
-(void)withdrawSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
    [_delegate needReloadDataWithdrawMoney];

}
-(void)needReloadData
{
    [self withdrawalsMoneyInfo];


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
