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
#import "TPKeyboardAvoidingScrollView.h"

@interface HYRegisteredVC ()<UITextFieldDelegate,SRActionSheetDelegate,BMKLocationServiceDelegate>
{
    //底部scrollview
    TPKeyboardAvoidingScrollView *bgScrollView;
    NSString *levelString;
    BMKLocationService* _locService;
    NSString *memberlat;
    NSString *memberlng;
    NSMutableArray *delegateArr;
    NSArray *arr ;
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
    delegateArr =[[NSMutableArray alloc]init];
    arr = [[NSArray alloc]init];
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
- (void)getDelegate
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"memberlat":memberlat ,
                          @"memberlng":memberlng,
//                          @"token":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"token"]]
}];
    
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"Home/Index/nearbyagent" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            arr =[dict objectForKey:@"data"];
            for (int i=0; i<arr.count; i++) {
                [delegateArr insertObject:[NSString stringWithFormat:@"%@:%@",[arr[i] objectForKey:@"name"],[arr[i] objectForKey:@"account"]]atIndex:i];
            }
            
        }else
        {
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
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
    NSArray*leftArr =@[@"推荐人",@"昵称",@"手机号",@"密码",@"确认密码",@"代理",@"身份证号",@"身份证件",@"",@"",@"",@"",] ;
    NSArray *rightArr =@[@"推荐人账号(非必填)",@"姓名或昵称",@"手机号",@"6-16位数字、字母或字符",@"确认密码",_delegateNumber?_delegateNumber:@"选择代理" ,@"",@"",@"",@"",];
    
    //列表
    for (int i=0; i<6; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i!=5) {
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            if (i==3||i==4) {
                inputText.secureTextEntry =YES;
                
            }else if(i==2)
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
            if ( [wzlabe.text isEqualToString:@"选择代理"]) {
                wzlabe.textColor = TextGrayGrayColor;

            }else
            {
                wzlabe.textColor = [UIColor blackColor];

            }
            wzlabe.tag =20+i;
            wzlabe.font = [UIFont systemFontOfSize:16];
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
            
        }else if(i<5&&i>0)
        {
            bgview.frame =CGRectMake(0, 40*Width+i*106*Width, CXCWidth, 106*Width);
        }else if (i==6||i==5)
        {
            bgview.frame =CGRectMake(0, 60*Width+i*106*Width, CXCWidth, 106*Width);
        }
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,800*Width , 670*Width, 88*Width)];
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
    UITextField *parent =[self.view viewWithTag:10];
    UITextField *name =[self.view viewWithTag:11];
    UITextField *account =[self.view viewWithTag:12];
    UITextField *password =[self.view viewWithTag:13];
    UITextField *password2 =[self.view viewWithTag:14];
    UILabel*delegateLabel =[self.view viewWithTag:25];
    if (IsNilString(name.text)) {
        [MBProgressHUD showError:@"昵称不能为空" ToView:self.view];
        return;
    }
    if (IsNilString(account.text)) {
        [MBProgressHUD showError:@"手机号不能为空" ToView:self.view];
        return;
    }
    if (IsNilString(password.text)) {
        [MBProgressHUD showError:@"密码不能为空" ToView:self.view];
        return;
    }
    if (IsNilString(password2.text)) {
        [MBProgressHUD showError:@"确认密码不能为空" ToView:self.view];
        return;
    }
        if ([delegateLabel.text isEqualToString:@"选择代理"]) {
        [MBProgressHUD showError:@"请选择代理" ToView:self.view];
        return;
    }
    
    [ProgressHUD show:@"正在请求。。。"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"account":[NSString stringWithFormat:@"%@",account.text],
                          @"password":[NSString stringWithFormat:@"%@",password.text],
                          @"password2":[NSString stringWithFormat:@"%@",password2.text],
                          @"name":[NSString stringWithFormat:@"%@",name.text],
                          @"belongAgen":[NSString stringWithFormat:@"%@",delegateLabel.text],
                          @"parent":[NSString stringWithFormat:@"%@",parent.text]}];
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"Home/Login/regMember" paraments:dic1 addView:self.view success:^(id responseDic) {
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
    if (btn.tag==15) {
        //选择代理
        SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"请选择代理"
                                                                    cancelTitle:@"取消"
                                                               destructiveTitle:nil
                                                                     withNumber:[NSString stringWithFormat:@"%ld",(delegateArr.count+1)] withLineNumber:@"1"
                                                                    otherTitles:delegateArr
                                                                    otherImages:nil
                                                              selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                                  
                                        
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
    UILabel *labelOne  =[self.view viewWithTag:25];
    labelOne.textColor =[UIColor blackColor];
    
    if (buttonIndex<delegateArr.count&&buttonIndex>=0) {
        levelString =[NSString stringWithFormat:@"%@",delegateArr[ buttonIndex]];

        NSRange range = [levelString rangeOfString:@":"];
        range.location =range.location+1;
        levelString = [levelString substringFromIndex:range.location];
    
        NSLog(@"string:%@",levelString);
        labelOne.text =levelString;

    }else
    {
        labelOne.textColor =TextGrayGrayColor;
        labelOne.text =@"选择级别";
    }

    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (textField.tag==12) {
        if (existedLength - selectedLength + replaceLength >= 12) {
            
            [textField resignFirstResponder];
            return NO;
            
            
            
        }
        
    }else if (textField.tag==17)
    {
        if (existedLength - selectedLength + replaceLength >= 19) {
            
            [textField resignFirstResponder];
            return NO;
            
        }
    }else if (textField.tag==13||textField.tag==14)
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
    memberlat =[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    memberlng =[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    [self performSelector:@selector(getDelegate)];
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
