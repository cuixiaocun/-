//
//  IWantDecorateVC.m
//  家装
//
//  Created by Admin on 2017/9/21.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "IWantDecorateVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MOFSPickerManager.h"
#import "ZHPickView.h"

@interface IWantDecorateVC ()<UITextFieldDelegate,ZHPickViewDelegate>
{
    TPKeyboardAvoidingScrollView *bgScrollView;

}
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation IWantDecorateVC

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
    [returnBtn setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];

    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"我要装修"];
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
    [_pickview remove];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)mainView
{
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 530*Width)];
    imgV.image =[UIImage imageNamed:@"home_icon_shenqing"];
    [bgScrollView addSubview:imgV];
    
    NSArray *rightArr =@[@"您的姓名",@"联系方式",@"装修面积",@"选择价格",@"选择房屋所在城市" ,@"小区名称",@"",@"",@"",];

    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(15*Width, imgV.bottom+20*Width, 720*Width, 740*Width)];
    bgview.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:bgview];

    
    //列表
    for (int i=0; i<6; i++) {
        if(i!=3&&i!=4){
            
            UIImageView *bgImg = [[UIImageView alloc] init];
            bgImg.userInteractionEnabled =YES;
            [bgImg setFrame:CGRectMake(20*Width, 120*Width*i+20*Width,680*Width,100*Width)];
            [bgImg setImage:[UIImage imageNamed:@"home_icon_cell"]];
            [bgview addSubview:bgImg];
            
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            inputText.returnKeyType = UIReturnKeyDone;
            if(i==1)
            {
                [inputText setKeyboardType:UIKeyboardTypePhonePad];
            }
            [inputText setPlaceholder:rightArr[i]];
            [inputText setDelegate:self];
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:[UIColor blackColor]];
            [inputText setFrame:CGRectMake(20*Width, 20*Width,640*Width,60*Width)];
            
            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [bgImg addSubview:inputText];
            
    
        
        }else
        {
            //选择角色
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(20*Width, 120*Width*i+20*Width,680*Width,100*Width)];
            [bgview addSubview:chooseBtn];
            [chooseBtn setBackgroundImage:[UIImage imageNamed:@"home_icon_cell"] forState:UIControlStateNormal];
            
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(levelChoosen:) forControlEvents:UIControlEventTouchUpInside];
            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, 20*Width,400*Width , 60*Width)];
            wzlabe.text = rightArr[i];
            if(i==3)
            {
                if ( [wzlabe.text isEqualToString:@"选择价格"]) {
                    wzlabe.textColor = TextGrayGrayColor;
                }else
                {
                    wzlabe.textColor = [UIColor blackColor];
                    
                }

            }else if(i==4)
            {
                if ( [wzlabe.text isEqualToString:@"选择房屋所在城市"]) {
                    wzlabe.textColor = TextGrayGrayColor;
                }else
                {
                    wzlabe.textColor = [UIColor blackColor];
                    
                }

            
            }
            
            wzlabe.tag =20+i;
            wzlabe.font = [UIFont systemFontOfSize:16];
            [chooseBtn addSubview:wzlabe];
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(630*Width, 40*Width,14*Width , 10*Width)];
            [chooseBtn addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"sf_icon_down"]];
        }
    }
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,bgview.bottom+100 *Width , 670*Width, 98*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.shadowColor = NavColor.CGColor;
    
    layer.cornerRadius = 44*Width;
    [bgScrollView.layer addSublayer:layer];
    //注册按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,bgview.bottom+100 *Width , 670*Width, 98*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:44*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
}
- (void)levelChoosen:(UIButton*)btn
{    [_pickview  remove];
    for (int i=0; i<6; i++) {
        UITextField *inputText = [self.view viewWithTag:10+i];
        [inputText resignFirstResponder];
    }

    if (btn.tag==14) {
        UILabel*addressLabel = [self.view viewWithTag:24];
        
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:nil numberOfComponents:2 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
            NSArray *array = [address
                              componentsSeparatedByString:@"-"];//字符串按照-分隔成数组
            NSLog(@"array=%@=",array);
            addressLabel.text = array[1];
            addressLabel.textColor =TextColor;
        } cancelBlock:^{
            
        }];
   
    }else
    {
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"8万以上",@"5-8万",@"3-5万",@"3万以下"] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 103;
        [_pickview show];

    
    }
    

}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if(pickView.tag==103)
    {
        UILabel *typeLabel =[self.view viewWithTag:23];
        typeLabel.text =resultString;
        typeLabel.textColor =TextColor;

    }

}

- (void)nextStep
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    
    return YES;
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [_pickview remove];
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
