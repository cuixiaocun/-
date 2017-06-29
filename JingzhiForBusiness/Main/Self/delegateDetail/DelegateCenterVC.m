//
//  DelegateCenterVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DelegateCenterVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MOFSPickerManager.h"

@interface DelegateCenterVC ()<UITextFieldDelegate >
{
    TPKeyboardAvoidingScrollView *bgScrollView;

}
@end

@implementation DelegateCenterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    
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
    [navTitle setText:@"个人信息"];
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
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"账号",@"等级",@"可提现金额",@"发展人",@"上级代理",@"姓名",@"身份证号",@"手机号",@"微信",@"链接后缀",@"地区",@"",] ;
    NSArray *rightArr =@[@"账号",@"等级",@"可提现金额",@"发展人",@"上级代理",@"姓名",@"身份证号",@"手机号",@"微信",@"链接后缀",@"地区",@"",];
    //列表
    for (int i=0; i<11; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i==5||i==7||i==8) {
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            [inputText setPlaceholder:rightArr[i]];
            [inputText setDelegate:self];
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:BlackColor];
            [inputText setFrame:CGRectMake(290*Width, 0,580*Width,82*Width)];
            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [bgview addSubview:inputText];
            
        }else if(i==10)
        {
            //地区选择
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(290*Width, 0,580*Width,82*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(areaChoosen:) forControlEvents:UIControlEventTouchUpInside];
            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,580*Width , 82*Width)];
            wzlabe.text = rightArr[i];
            wzlabe.tag =20+i;
            wzlabe.font = [UIFont systemFontOfSize:16];
            wzlabe.textColor = BlackColor;
            [chooseBtn addSubview:wzlabe];
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 17.5*Width,25*Width , 25*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
            
            
        }else
        {
            
            UILabel* rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(290*Width, 0,580*Width,82*Width)];
            rightLabel.text = rightArr[i];
            rightLabel.tag =20+i;
            rightLabel.font = [UIFont systemFontOfSize:16];
            rightLabel.textColor = TextGrayColor;
            [bgview addSubview:rightLabel];
        
        }
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,80*Width, CXCWidth, 2*Width);
        
        
        if (i<3) {
            bgview.frame =CGRectMake(0, 20*Width+i*82*Width, CXCWidth, 82*Width);
            
        }else if(i<5&&i>2)
        {
            
            bgview.frame =CGRectMake(0, 40*Width+i*82*Width, CXCWidth, 82*Width);
            
            
        }else if (i>4&&i<9)
        {
            
            bgview.frame =CGRectMake(0, 60*Width+i*82*Width, CXCWidth, 82*Width);
            
            
        }else
        {
            
            bgview.frame =CGRectMake(0, 80*Width+i*82*Width, CXCWidth, 82*Width);
            
            
        }
        
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,1080*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveInfo
{
    UITextField *nameText =[self.view viewWithTag:15];
    UITextField *phoneText =[self.view viewWithTag:17];
    UITextField *wxText =[self.view viewWithTag:18];

    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [wxText resignFirstResponder];
    
}
- (void)areaChoosen:(UIButton*)btn
{
    UITextField *nameText =[self.view viewWithTag:15];
    UITextField *phoneText =[self.view viewWithTag:17];
    UITextField *wxText =[self.view viewWithTag:18];

    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [wxText resignFirstResponder];
    

    UILabel*addressLabel = [self.view viewWithTag:30];
    
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"河南省-郑州市" numberOfComponents:3 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
        addressLabel.text = [address stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } cancelBlock:^{
        
    }];
    


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
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