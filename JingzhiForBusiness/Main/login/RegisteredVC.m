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
#import "TPKeyboardAvoidingScrollView.h"
#import "MOFSPickerManager.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface RegisteredVC ()<UITextFieldDelegate,SRActionSheetDelegate,BMKLocationServiceDelegate,SetIDNumberVCDelegate>
{
    //底部scrollview
    TPKeyboardAvoidingScrollView *bgScrollView;
    NSString *levelString;
    BMKLocationService* _locService;
    NSString *memberlat;
    NSString *memberlng;
    NSString *photoString;
}
@end

@implementation RegisteredVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];

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
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"上级代理号",@"昵称",@"链接后缀",@"手机号",@"密码",@"确认密码",@"微信号",@"代理级别",@"所属地区",@"身份证号",@"身份证件",@"",@"",@"",@"",] ;
    NSArray *rightArr =@[@"上级代理号",@"填写代理昵称",@"填写属于自己的后缀",@"手机号",@"6-16位数字、字母或字符",@"确认密码",@"微信号",@"选择级别",@"选择地区",@"身份证号",@"上传身份证件",@"",@"",@""];
    //列表
    for (int i=0; i<11; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i!=7&&i!=8&&i!=10) {
        UITextField *inputText = [[UITextField alloc] init];
        [inputText setTag:i+10];
        if (i==4||i==5) {
            inputText.secureTextEntry =YES;

        }else if(i==3)
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
            //代理级别、选择地区、上传身份证
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
            
        }else if(i<6&&i>0)
        {
            bgview.frame =CGRectMake(0, 40*Width+i*106*Width, CXCWidth, 106*Width);
        }else if (i==6||i==7||i==8)
        {
            bgview.frame =CGRectMake(0, 60*Width+i*106*Width, CXCWidth, 106*Width);
        }else
        {
            bgview.frame =CGRectMake(0, 80*Width+i*106*Width, CXCWidth, 106*Width);
        }
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,1358*Width , 670*Width, 88*Width)];
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
    //判断
    for (int i = 0; i<11; i++) {
        //收起所有键盘
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i+10];
        [inputTExt resignFirstResponder];
        if (i!=7&&i!=8&&i!=10&&i!=0) {
            //不为空
            if([inputTExt.text isEqualToString:@""])
            {
                [MBProgressHUD showError:@"信息不完整" ToView:self.view];
                return;
            }
        }
        if (i==3) {
            //判断手机号
            if (![PublicMethod isMobileNumber:inputTExt.text ]) {
                [MBProgressHUD showError:@"手机号码输入错误" ToView:self.view];
                return;
            }
        }else if(i==9)
        {
            //判断身份证
            if (![PublicMethod judgeIdentityStringValid: inputTExt.text ]) {
                [MBProgressHUD showError:@"身份证输入错误" ToView:self.view];
                return;
            }
        }else if (i==4)
        {
            //判断身份证
            if ( inputTExt.text.length>16||inputTExt.text.length<6) {
                [MBProgressHUD showError:@"密码为8-16位" ToView:self.view];
                return;
            }
        }
    }
    
    UITextField *topAngetNumTF = (UITextField *)[self.view viewWithTag:10];
    
    UITextField *nameTF = (UITextField *)[self.view viewWithTag:11];
    UITextField *lastURLTF = (UITextField *)[self.view viewWithTag:12];
    UITextField *phoneTF = (UITextField *)[self.view viewWithTag:13];
    UITextField *inputTExtMM = (UITextField *)[self.view viewWithTag:14];
    UITextField *inputTExtQRMM = (UITextField *)[self.view viewWithTag:15];
    
    UITextField *wxTF = (UITextField *)[self.view viewWithTag:16];
    UILabel *levelLabel = (UILabel *)[self.view viewWithTag:27];
    UILabel *adressTF = (UILabel *)[self.view viewWithTag:28];
    
    UITextField *idNumTF = (UITextField *)[self.view viewWithTag:19];

    //判断密码是否一致
    if (![inputTExtMM.text isEqualToString:inputTExtQRMM.text]) {
        [MBProgressHUD showError:@"两次密码不一致" ToView:self.view];
        return;
    }
    //判断有没有选择级别
    if ([levelLabel.text isEqualToString:@"选择级别"]) {
        [MBProgressHUD showError:@"请选择级别" ToView:self.view];
        return;
    }
    //判断身份证是否上传
    UILabel *idPhoto =[self.view viewWithTag:30 ];
    if ([idPhoto.text isEqualToString:@"上传身份证件"]) {
        [MBProgressHUD showError:@"请上传身份证" ToView:self.view];
        return;
    }
   
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"upagenaccount":[NSString stringWithFormat:@"%@",topAngetNumTF.text],
                          @"account":[NSString stringWithFormat:@"%@",phoneTF.text],
                          @"password":[NSString stringWithFormat:@"%@",inputTExtMM.text],
                          @"password2":[NSString stringWithFormat:@"%@",inputTExtQRMM.text],
                          @"webchat":[NSString stringWithFormat:@"%@",wxTF.text],
                          @"agenurl":[NSString stringWithFormat:@"%@",lastURLTF.text],
                          @"idcard":[NSString stringWithFormat:@"%@",idNumTF.text],
                          @"idcardimg":[NSString stringWithFormat:@"%@",photoString],
                          @"agenlevel":[NSString stringWithFormat:@"%ld",[levelString integerValue]+1],
                          @"username":[NSString stringWithFormat:@"%@",nameTF.text],
                          @"xianaddress":[NSString stringWithFormat:@"%@",adressTF.text],
                          @"lng":[NSString stringWithFormat:@"%@",memberlng],
                          @"lat":[NSString stringWithFormat:@"%@",memberlat],
                        
                          
                         }];
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"Home/Login/regAgen" paraments:dic1 addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"])
        {
            RegisterAndGoods *registerAndGoods =[[RegisterAndGoods alloc]init];
            registerAndGoods.levelString=levelString;
            registerAndGoods.navTitle =@"注册提报";
            [self.navigationController pushViewController:registerAndGoods animated:YES];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  ;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击其他地方收起键盘
    for (int i = 0; i<11; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i+10];
        [inputTExt resignFirstResponder];
    }


}
- (void)levelChoosen:(UIButton *)btn
{
    //收起键盘
    for (int i = 0; i<11; i++) {
        UITextField *inputTExt = (UITextField *)[self.view viewWithTag:i+10];
        [inputTExt resignFirstResponder];
    }
    if (btn.tag==17) {
        //选择代理
        SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"请选择代理级别"
                                                                    cancelTitle:@"取消"
                                                               destructiveTitle:nil
                                                                     withNumber:@"7" withLineNumber:@"1"
                                                                    otherTitles:@[@"一级代理",@"二级代理",@"三级代理",@"四级代理",@"五级代理",@"六级代理"]
                                                                    otherImages:nil
                                                              selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                                  
                                                                  if (index<0||index>5) {
                                                                      return;
                                                                  }
                                                                  [self actionSheetButtonAtIndex:index];
                                                                  
                                                                  
                                                                  NSLog(@"%zd", index);
                                                              }];
        actionSheet.number=@"7";
        actionSheet.lineNumber=@"1";
        

        [actionSheet show];
        
        
        
        
        
    }else if (btn.tag==20){
    //传图片页面
        SetIDNumberVC *setIdVC =[[SetIDNumberVC alloc]init];
        setIdVC.delegate =self;
        
        [self.navigationController  pushViewController:setIdVC animated:YES];
    }else if (btn.tag==18)
    {
        UILabel *label =[self.view viewWithTag:28];
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"河南省-郑州市" numberOfComponents:3 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
            label.text = [address stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            label.textColor =[UIColor blackColor];

        } cancelBlock:^{
            
        }];

    
    }







}
-(void) actionSheetButtonAtIndex:(NSInteger)buttonIndex
{
    UILabel *labelOne  =[self.view viewWithTag:27];
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
    if (textField.tag==13) {
        if (existedLength - selectedLength + replaceLength >= 12) {
            
            [textField resignFirstResponder];
            return NO;
            
            
            
        }

    }else if (textField.tag==19)
    {
        if (existedLength - selectedLength + replaceLength >= 19) {
            
            [textField resignFirstResponder];
            return NO;
           
        }
    }else if (textField.tag==14)
    {
        
        if (existedLength - selectedLength + replaceLength >= 17) {
            [MBProgressHUD showError:@"密码为6-16位" ToView:self.view];
            
            [textField resignFirstResponder];
            return NO;
            
        }
        
        
    }

    
    
    
    

    return YES;
    


}
- (void)successUpPhoto:(NSString *)str
{

    UILabel *labelOne  =[self.view viewWithTag:30];
    labelOne.textColor =NavColor;
    labelOne.text =@"已上传";
    photoString =str;
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
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    memberlat =[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    memberlng =[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    [_locService stopUserLocationService];//取消定位

    
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
