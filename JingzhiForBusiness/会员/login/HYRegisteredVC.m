//
//  HYRegisteredVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYRegisteredVC.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "LoginPage.h"
#import "SelfDetailVC.h"
@interface HYRegisteredVC ()<UITextFieldDelegate,SRActionSheetDelegate,BMKLocationServiceDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    NSString *levelString;
    BMKLocationService* _locService;

}

@end
@implementation HYRegisteredVC
-(void)viewWillAppear:(BOOL)animated {
    _locService.delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    _locService.delegate = nil;
}


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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"推荐人",@"手机号",@"密码",@"确认密码",@"代理",@"身份证号",@"身份证件",@"",@"",@"",@"",] ;
    NSArray *rightArr =@[@"推荐人账号",@"手机号",@"6-16位数字、字母或字符",@"确认密码",@"选择代理",@"身份证号",@"上传身份证件",@"",@"",@"",@"",];
    //列表
    for (int i=0; i<5; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i!=4) {
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
            
            
        }
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,700*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"注册" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)nextStep
{
    UITextField *account =[self.view viewWithTag:11];
    UITextField *password =[self.view viewWithTag:12];
    UITextField *password2 =[self.view viewWithTag:13];
    [ProgressHUD show:@"正在请求。。。"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"account":[NSString stringWithFormat:@"%@",account.text],@"password":[NSString stringWithFormat:@"%@",password.text],@"password2":[NSString stringWithFormat:@"%@",password2.text]}];
        //        NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];
        NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"Home/login/regMember" paraments:dic1 addView:self.view success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                for (UIViewController *controller in self.navigationController.viewControllers) {

                    [ProgressHUD  showSuccess:@"注册成功"];
                    
                    if ([controller isKindOfClass:[LoginPage  class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }else if ([controller isKindOfClass:[SelfDetailVC  class]])
                    {
                        LoginPage*loginPage =[[LoginPage alloc]init];
                        [self.navigationController pushViewController:loginPage animated:YES];
                        
                    }
 
               }
          }
            
        } fail:^(NSError *error) {
            
        }];
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    if (btn.tag==14) {
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
        
        
        
        
        
    }
    
    
}
-(void) actionSheetButtonAtIndex:(NSInteger)buttonIndex
{
    UILabel *labelOne  =[self.view viewWithTag:24];
    labelOne.textColor =[UIColor blackColor];
    levelString =[NSString stringWithFormat:@"%d",buttonIndex];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_locService stopUserLocationService];
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
