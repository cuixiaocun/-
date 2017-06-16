//
//  WithDrawDetail.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "WithDrawDetail.h"
#import "CXCTwoLableSheet.h"
@interface WithDrawDetail ()<UITextFieldDelegate,CXCTwoLableSheetDelegate >
{
    UIScrollView *bgScrollView;
    BOOL isHaveDian;//判断小数点

}

@end

@implementation WithDrawDetail

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
    [navTitle setText:@"提现"];
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    bgScrollView.showsHorizontalScrollIndicator = FALSE;
    
    UIView*topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 446*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:topView];
    
    
    UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(300*Width, 50*Width, 150*Width, 150*Width)];
    [topImgV setImage:[UIImage imageNamed:@"withdrawcash_icon_glod"]];
    [topView addSubview:topImgV];
    
    UILabel *promeLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, topImgV.bottom, CXCWidth, 80*Width)];
    promeLabel.text =@"我的金币";
    promeLabel.textAlignment =NSTextAlignmentCenter;
    promeLabel.textColor =BlackColor ;
    promeLabel.font =[UIFont systemFontOfSize:14];
    [topView addSubview:promeLabel ];
    
    UILabel *coinLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, promeLabel.bottom, CXCWidth, 132*Width)];
    coinLabel.text =@"1000";
    coinLabel.tag =200;
    coinLabel.textAlignment =NSTextAlignmentCenter;
    coinLabel.textColor =BlackColor ;
    coinLabel.font =[UIFont systemFontOfSize:60];
    [topView addSubview:coinLabel ];
    
    UIButton *middleBgView =[[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+20*Width, CXCWidth, 136*Width)];
    middleBgView.backgroundColor =[UIColor whiteColor];
    [bgScrollView   addSubview:middleBgView];
    [middleBgView addTarget:self action:@selector(showCXCActionSheetView) forControlEvents:UIControlEventTouchUpInside];
    
    //银行卡头像背景
    UIImageView *cardPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(24*Width, 32*Width, 72*Width, 72*Width)];
    cardPhoto.userInteractionEnabled = YES;
    cardPhoto.tag =201;
    cardPhoto.image =[UIImage imageNamed:@"withdrawcash_icon_bank_red"];
    [middleBgView addSubview:cardPhoto];
    
    //名称
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, cardPhoto.top-10*Width, 350*Width, 36*Width)];
    
    nameLabel.textColor =BlackColor;
    nameLabel.text =@"中国银行";
    nameLabel.tag =202;
    
    nameLabel.font =[UIFont systemFontOfSize:16];
    [middleBgView addSubview:nameLabel];
    
    //银行卡号
    UILabel *bankLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, nameLabel.bottom+10*Width, 550*Width, 36*Width)];
    bankLabel.textColor =BlackColor;
    bankLabel.text =@"6223 9103 0116 0170";
    bankLabel.tag =203;
    bankLabel.font =[UIFont systemFontOfSize:14];
    [middleBgView addSubview:bankLabel];
    //箭头
    UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 47*Width,40*Width , 40*Width)];
    [middleBgView addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
    
    

    
    UIView *bottomBgView =[[UIView alloc]initWithFrame:CGRectMake(0, middleBgView.bottom+20*Width, CXCWidth, 270*Width)];
    bottomBgView.backgroundColor =[UIColor whiteColor];
    [bgScrollView   addSubview:bottomBgView];
    //提现金额
    UILabel *promNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 0*Width, 350*Width, 80*Width)];
    promNumLabel.textColor =BlackColor;
    promNumLabel.text =@"提现金额";
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
    [inputText setPlaceholder:@"请输入提现金额"];
    [inputText setDelegate:self];
    inputText.keyboardType =UIKeyboardTypeDecimalPad;
    inputText.textAlignment =NSTextAlignmentLeft;
    [inputText setFont:[UIFont boldSystemFontOfSize:28]];
    [inputText setTextColor:[UIColor blackColor]];
    [inputText setFrame:CGRectMake(RMBLabel.right, RMBLabel.top,600*Width,100*Width)];
    [bottomBgView addSubview:inputText];
    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(24*Width, inputText.bottom, CXCWidth, 1.5*Width)];
    [bottomBgView addSubview:xian];
    xian.backgroundColor =BGColor;
    //提现金额
    UILabel *balanceLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, xian.bottom, 500*Width, 80*Width)];
    balanceLabel.textColor =TextColor;
    NSString *totalString =[NSString stringWithFormat:@"当前可提现余额100元,全部提现"];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:textColor.length-4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [balanceLabel setAttributedText:textColor];
    [balanceLabel setTag:205];
    balanceLabel.font =[UIFont systemFontOfSize:14];
    [bottomBgView addSubview:balanceLabel];
    //全部提现
    
    UIButton *drawlsAllBtn =[[UIButton alloc]initWithFrame:CGRectMake(100*Width, xian.bottom, 400*Width, 80*Width)];
    [drawlsAllBtn.layer setCornerRadius:4];
    [drawlsAllBtn setTitleColor:NavColor forState:UIControlStateNormal];
    [drawlsAllBtn.layer setMasksToBounds:YES];
    [drawlsAllBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [drawlsAllBtn addTarget:self action:@selector(allDrawlsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [drawlsAllBtn setTitle:@"" forState:UIControlStateNormal];
    [drawlsAllBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [drawlsAllBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [bottomBgView addSubview:drawlsAllBtn];
    
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(370*Width, bottomBgView.bottom+20*Width, 24*Width, 24*Width)];
    imgV.image =[UIImage imageNamed:@"withdrawcash_icon_remind"];
    [bgScrollView addSubview:imgV];
    
    UILabel *tishiLabel =[[UILabel alloc]initWithFrame:CGRectMake(imgV.right, bottomBgView.bottom , 350*Width, 64*Width)];
    tishiLabel.text =@"提示:1金币等于1元人民币";
    [bgScrollView addSubview:tishiLabel];
    tishiLabel.textColor =TextGrayGrayColor;
    tishiLabel.font =[UIFont systemFontOfSize:12];
    
    
    
    //下一步按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,bottomBgView.bottom+ 106*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(sureDrawls) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
 }
- (void)allDrawlsBtnAction:(UIButton *)btn
{
     
    UITextField *textF =[self.view viewWithTag:204];
    [textF resignFirstResponder];
    textF.text =@"1000";
    
}
-(void)sureDrawls
{


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
    return YES;

    
    
    
    
    
    
    
    
    
    
    return YES;
}
-(void)showCXCActionSheetView
{
    CXCTwoLableSheet *sheet =[[CXCTwoLableSheet alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight) with:@[@[@"潍坊银行",@"62239050849068308690468"],@[@"中国银行",@"3243905864390608593"],@[@"中国银行",@"3243905864390608593"],@[@"中国银行",@"3243905864390608593"],@[@"潍坊银行",@"62239050849068308690468"],@[@"中国银行",@"3243905864390608593"],@[@"潍坊银行",@"62239050849068308690468"],@[@"中国银行",@"3243905864390608593"],]];
    sheet.tag=1111;
    sheet.delegate=self;
    [self.view addSubview:sheet];
    
    

}
- (void)btnClickName:(NSString *)nameString andBankNumber:(NSString *)bankNum
{
    UILabel *nameLabel= [self.view viewWithTag:202];
    [nameLabel setText:nameString];
    
    UILabel *numberLabel= [self.view viewWithTag:203];
    [numberLabel setText:bankNum];
    
    UIView *view= [self.view viewWithTag:1111];
    [view removeFromSuperview];



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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
