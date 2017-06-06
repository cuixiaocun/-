//
//  RegisteredVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/1.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "RegisteredVC.h"
#import "SetIDNumberVC.h"
#import "RegisterAndGoods.h"
@interface RegisteredVC ()<UITextFieldDelegate,UIActionSheetDelegate,SetIDNumberVCDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    NSString *levelString;
}
@end

@implementation RegisteredVC

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
    [navTitle setText:@"注册"];
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"上级代理号",@"手机号",@"密码",@"确认密码",@"微信号",@"代理级别",@"身份证号",@"身份证件",@"",@"",@"",@"",] ;
    NSArray *rightArr =@[@"上级代理号",@"手机号",@"8-16位数字、字母或字符",@"确认密码",@"微信号",@"选择级别",@"身份证号",@"上传身份证件",@"",@"",@"",@"",];
    //列表
    for (int i=0; i<8; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i!=5&&i!=7) {
        UITextField *inputText = [[UITextField alloc] init];
        [inputText setTag:i+10];
        if (i==2||i==3) {
            inputText.secureTextEntry =YES;

        }else if(i==1)
        {
            [inputText setKeyboardType:UIKeyboardTypePhonePad];

        }
        [inputText setPlaceholder:rightArr[i]];
        [inputText setDelegate:self];
        [inputText setFont:[UIFont systemFontOfSize:16]];
        [inputText setTextColor:[UIColor blackColor]];
        [inputText setFrame:CGRectMake(290*Width, 0,580*Width,106*Width)];
        [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
        [bgview addSubview:inputText];
        
        }else
        {
            //代理级别与上传身份证
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(290*Width, 0,580*Width,106*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(levelChoosen:) forControlEvents:UIControlEventTouchUpInside];
            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,580*Width , 106*Width)];
            wzlabe.text = rightArr[i];
            wzlabe.tag =20+i;
            wzlabe.font = [UIFont systemFontOfSize:16];
            wzlabe.textColor = TextGrayGrayColor;
            [chooseBtn addSubview:wzlabe];
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 35*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
        
        
        }
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,104*Width, CXCWidth, 2*Width);
        
        
        if (i==0) {
            bgview.frame =CGRectMake(0, 20*Width, CXCWidth, 106*Width);
            
        }else if(i<4&&i>0)
        {
        
            bgview.frame =CGRectMake(0, 40*Width+i*106*Width, CXCWidth, 106*Width);

        
        }else if (i==4||i==5)
        {
        
            bgview.frame =CGRectMake(0, 60*Width+i*106*Width, CXCWidth, 106*Width);

        
        }else
        {
        
            bgview.frame =CGRectMake(0, 80*Width+i*106*Width, CXCWidth, 106*Width);

        
        }
        
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,1040*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    

    
    

}
- (void)nextStep
{
    
//    //判断
//    for (int i = 0; i<8; i++) {
//        //收起所有键盘
//        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i+10];
//        [inputTExt resignFirstResponder];
//        if (i!=5&&i!=7) {
//            //不为空
//            if([inputTExt.text isEqualToString:@""])
//            {
//                [MBProgressHUD showError:@"信息不完整" ToView:self.view];
//                
//                return;
//            }
//        }
//
//        if (i==1) {
//            //判断手机号
//            if (![PublicMethod isMobileNumber:inputTExt.text ]) {
//                [MBProgressHUD showError:@"手机号码输入错误" ToView:self.view];
//                return;
//            }
//        }else if(i==6)
//        {
//            //判断身份证
//            if (![PublicMethod judgeIdentityStringValid: inputTExt.text ]) {
//                [MBProgressHUD showError:@"身份证输入错误" ToView:self.view];
//                return;
//            }
//            
//        }else if (i==3)
//        {
//            //判断身份证
//            if ( inputTExt.text.length>16||inputTExt.text.length<8) {
//                [MBProgressHUD showError:@"密码为8-16位" ToView:self.view];
//                return;
//            }
//
//        
//        }
//       
//    }
//    
//    
//    //判断密码是否一致
//    UITextField *inputTExtMM = (UITextField *)[self.view viewWithTag:12];
//    UITextField *inputTExtQRMM = (UITextField *)[self.view viewWithTag:13];
//    if (![inputTExtMM.text isEqualToString:inputTExtQRMM.text]) {
//        
//        [MBProgressHUD showError:@"两次密码不一致" ToView:self.view];
//        return;
//    }
//    //判断有没有选择级别
//    UILabel *levelLabel=[self.view viewWithTag:25];
//    
//    if ([levelLabel.text isEqualToString:@"选择级别"]) {
//        [MBProgressHUD showError:@"请选择级别" ToView:self.view];
//        return;
//    }
//    //判断身份证是否上传
//    UILabel *idPhoto =[self.view viewWithTag:27 ];
//    if ([idPhoto.text isEqualToString:@"上传身份证件"]) {
//        [MBProgressHUD showError:@"请上传身份证" ToView:self.view];
//    }
    RegisterAndGoods *registerAndGoods =[[RegisterAndGoods alloc]init];
    registerAndGoods.levelString=levelString;
    registerAndGoods.navTitle =@"注册提报";
    [self.navigationController pushViewController:registerAndGoods animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击其他地方收起键盘
    for (int i = 0; i<8; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i+10];
        [inputTExt resignFirstResponder];
    }


}
- (void)levelChoosen:(UIButton *)btn
{
    //收起键盘
    for (int i = 0; i<8; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i+10];
        [inputTExt resignFirstResponder];
    }
    if (btn.tag==15) {
        //选择代理
        UIActionSheet *sheet;

        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择代理级别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"一级代理",@"二级代理",@"三级代理",@"四级代理",@"五级代理",@"六级代理", nil];
        [sheet showInView:self.view];
        
        
        
    }else{
    //传图片页面
        SetIDNumberVC *setIdVC =[[SetIDNumberVC alloc]init];
        setIdVC.delegate =self;
        
        [self.navigationController  pushViewController:setIdVC animated:YES];
    }







}
-(void)willPresentActionSheet:(UIActionSheet *)actionSheet

{
    
    SEL selector = NSSelectorFromString(@"_alertController");
    
    if ([actionSheet respondsToSelector:selector])//ios8 以后采用UIAlertController来代替uiactionsheet和UIAlertView
        
    {
        
        UIAlertController *alertController = [actionSheet valueForKey:@"_alertController"];
        
        if ([alertController isKindOfClass:[UIAlertController class]])
            
        {
            
            alertController.view.tintColor = TextColor;
            
        }
        
    }
    
    else//ios7 之前采用这样的方式
        
    {
        
        for( UIView * subView in actionSheet.subviews )
            
        {
            
            if( [subView isKindOfClass:[UIButton class]] )
                
            {
                
                UIButton * btn = (UIButton*)subView;
                
                
                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }
            
        }
        
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UILabel *labelOne  =[self.view viewWithTag:25];
    labelOne.textColor =[UIColor blackColor];
    levelString =[NSString stringWithFormat:@"%ld",buttonIndex];

    switch (buttonIndex) {
        case 0:
            
            labelOne.text =@"一级代理";
            break;
        case 1:
            labelOne.text =@"二级代理";

            break;
        case 2:
            labelOne.text =@"三级代理";

            break;
        case 3:
            labelOne.text =@"四级代理";

            break;
        case 4:
            labelOne.text =@"五级代理";

            break;
        case 5:
            labelOne.text =@"六级代理";

            break;
        case 6:
            labelOne.textColor =TextGrayGrayColor;
            labelOne.text =@"选择级别";

            break;
   
        default:
            break;
    }







}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (textField.tag==11) {
        if (existedLength - selectedLength + replaceLength >= 12) {
            
            [textField resignFirstResponder];
            return NO;
            
            
            
        }

    }else if (textField.tag==16)
    {
        if (existedLength - selectedLength + replaceLength >= 19) {
            
            [textField resignFirstResponder];
            return NO;
           
        }
    }else if (textField.tag==12)
    {
        
        if (existedLength - selectedLength + replaceLength >= 17) {
            [MBProgressHUD showError:@"密码为8-16位" ToView:self.view];
            
            [textField resignFirstResponder];
            return NO;
            
        }
        
        
    }

    
    
    
    

    return YES;
    


}
- (void)successUpPhoto
{

    UILabel *labelOne  =[self.view viewWithTag:27];
    labelOne.textColor =NavColor;
    labelOne.text =@"已上传";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
