//
//  ChangePassword.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "LoginPage.h"
@interface ChangePasswordVC ()<UITextFieldDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;


}

@end

@implementation ChangePasswordVC

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
    [navTitle setText:@"修改密码"];
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

    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator =
    NO;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1300*Width)];
    NSArray*leftArr =@[@"原密码：",@"新密码：",@"确认密码：",@"",@"",@"",@"",] ;
    NSArray *rightArr =@[@"请输入原密码",@"请输入新密码",@"确认密码",@"",];
    //列表
    for (int i=0; i<3; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        bgview.frame =CGRectMake(0, 20*Width+100*i*Width, CXCWidth, 100*Width);
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0,200*Width , 99*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = BlackColor;
        [bgview addSubview:labe];
        //右边
        UITextField *inputText = [[UITextField alloc] init];
        [inputText setTag:i+70];
        [inputText setDelegate:self];
        inputText.placeholder =rightArr[i];
        [inputText setFont:[UIFont systemFontOfSize:16]];
        [inputText setTextColor:[UIColor blackColor]];
        inputText.secureTextEntry =YES;
        [inputText setFrame:CGRectMake(200*Width, 0,520*Width,99*Width)];
        [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
        [bgview addSubview:inputText];
    
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,98.5*Width, CXCWidth, 1.5*Width);
        
        
        
    }
    //确认修改按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,470*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
}
-(void)confirmBtn
{
    
    UITextField *beforeTextfield =[self.view viewWithTag:70];
    if (IsNilString( beforeTextfield.text)) {
        [MBProgressHUD showError:@"原密码为空！" ToView:self.view];
        return;
    }
    UITextField *passtwordTextfield =[self.view viewWithTag:71];
    UITextField *secondtextfield =[self.view viewWithTag:72];
    if (![passtwordTextfield.text isEqualToString:secondtextfield.text]) {
        [MBProgressHUD showError:@"两次新密码不一致！" ToView:self.view];
        return;
        
    }
    UITextField *beforPassword = (UITextField *)[self.view viewWithTag:70];
    UITextField *afterPassword = (UITextField *)[self.view viewWithTag:71];
    UITextField *afterPasswordAgain = (UITextField *)[self.view viewWithTag:72];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"oldpwd":[NSString stringWithFormat:@"%@",beforeTextfield.text],
                          @"newpwd1":[NSString stringWithFormat:@"%@",passtwordTextfield.text],
                          @"newpwd2":[NSString stringWithFormat:@"%@",secondtextfield.text],
                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]]
                          
                          }];
    
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"Home/Member/editpwd" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
       
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            LoginPage *login =[[LoginPage alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            
        }
        
    } fail:^(NSError *error) {
        
    }];



}
- (void)returnBtnAction
{
    [self.navigationController   popViewControllerAnimated:YES];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
        if (existedLength - selectedLength + replaceLength >= 17) {
            [MBProgressHUD showError:@"密码为8-16位" ToView:self.view];
            
            [textField resignFirstResponder];
            return NO;
            
        }
        
        return YES;
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i=0; i<3; i++) {
        UITextField *textF =[self.view   viewWithTag:70+i];
        [textF resignFirstResponder];
        
    }


}

-(void)changeMima
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
