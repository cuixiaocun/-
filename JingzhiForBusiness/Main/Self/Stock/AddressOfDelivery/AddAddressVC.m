//
//  AddAddressVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AddAddressVC.h"
#import "MOFSPickerManager.h"
@interface AddAddressVC ()<UITextFieldDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    
}
@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor =BGColor;
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
    [navTitle setText:@"收货地址管理"];
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
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"姓名：",@"手机号：",@"所在地区：",@"详细地址：",@"",@"",@"",@"",] ;
    //列表
    for (int i=0; i<4; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        bgview.frame =CGRectMake(0, 20*Width+100*i*Width, CXCWidth, 100*Width);
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 99*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = BlackColor;
        [bgview addSubview:labe];
        if (i!=2) {
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            if (i==1) {
                [inputText setKeyboardType:UIKeyboardTypePhonePad];
            }
            [inputText setDelegate:self];
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:[UIColor blackColor]];
            [inputText setFrame:CGRectMake(200*Width, 0,520*Width,99*Width)];
            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [bgview addSubview:inputText];
            
        }else
        {
            //代理级别与上传身份证
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(200*Width, 0,520*Width,99*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(addressChoose) forControlEvents:UIControlEventTouchUpInside];
            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,580*Width , 99*Width)];
            wzlabe.text = @"";
            wzlabe.tag =111;
            wzlabe.font = [UIFont systemFontOfSize:14];
            wzlabe.textColor = [UIColor blackColor];
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
        xian.frame =CGRectMake(0,98.5*Width, CXCWidth, 1.5*Width);
        
        
        
    }
    //保存按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,550*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
    
    
}
//保存按钮
-(void)saveBtn
{
    UITextField *nameTF =[self.view viewWithTag:10];
    UITextField *phoneTF =[self.view viewWithTag:11];
    UITextField *addressTF =[self.view viewWithTag:13];

    [nameTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [addressTF resignFirstResponder];
    if (IsNilString(nameTF.text)) {
        [MBProgressHUD showError:@"姓名不能为空!" ToView:self.view];
        return;
    }
    if (IsNilString(phoneTF.text)) {
        [MBProgressHUD showError:@"电话不能为空!" ToView:self.view];
        return;
    }
    if (IsNilString(addressTF.text)) {
        [MBProgressHUD showError:@"地址不能为空!" ToView:self.view];
        return;
    }


}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addressChoose
{
    UITextField *nameTextF =[self.view viewWithTag:10];
    UITextField *phoneTextF =[self.view viewWithTag:11];
    UITextField *addressTextF =[self.view viewWithTag:13];
    [nameTextF resignFirstResponder];
    [phoneTextF resignFirstResponder];
    [addressTextF resignFirstResponder];

    UILabel *label =[self.view viewWithTag:111];
    

    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"河南省-郑州市" numberOfComponents:3 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
        label.text = address;
    } cancelBlock:^{
        
    }];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITextField *nameTextF =[self.view viewWithTag:10];
    UITextField *phoneTextF =[self.view viewWithTag:11];
    UITextField *addressTextF =[self.view viewWithTag:13];
    [nameTextF resignFirstResponder];
    [phoneTextF resignFirstResponder];
    [addressTextF resignFirstResponder];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;


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
        
    }
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
