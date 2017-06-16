//
//  AddBankCardVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AddBankCardVC.h"

@interface AddBankCardVC ()<UITextFieldDelegate>
{
    UIScrollView *bgScrollView;
    NSString *bankName;

}
@end

@implementation AddBankCardVC

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
    [navTitle setText:@"添加银行卡"];
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
    NSArray*leftArr =@[@"姓名",@"银行卡账号",@"开户行",@"支行",@"设置成默认银行卡",@"代理级别",@"身份证号",@"身份证件",@"",@"",@"",@"",] ;
    NSArray *rightArr =@[@"输入姓名",@"输入银行卡账号",@"选择开户行",@"输入支行",@"",@"",@"",@"",];
    //列表
    for (int i=0; i<5; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        bgview.frame =CGRectMake(0, 20*Width+80*Width*i, CXCWidth, 80*Width);
        if (i!=4) {
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 80*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = TextColor;
        [bgview addSubview:labe];
        if (i!=2) {
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            [inputText setPlaceholder:rightArr[i]];
            [inputText setDelegate:self];
            inputText.textAlignment =NSTextAlignmentRight;
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:[UIColor blackColor]];
            [inputText setFrame:CGRectMake(290*Width, 0,430*Width,80*Width)];
//            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [bgview addSubview:inputText];
            
            
        }else if(i==2)
        {
            //代理级别与上传身份证
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(290*Width, 0,580*Width,80*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(chooseBank) forControlEvents:UIControlEventTouchUpInside];
            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,380*Width , 80*Width)];
            wzlabe.text = rightArr[i];
            wzlabe.tag =20+i;
            wzlabe.textAlignment=NSTextAlignmentRight;
            wzlabe.font = [UIFont systemFontOfSize:16];
            wzlabe.textColor = TextGrayGrayColor;
            [chooseBtn addSubview:wzlabe];
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 20*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
            

            
        
        }
        }else if(i==4)
        {
            //代理级别与上传身份证
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(20*Width,0 ,500*Width,80*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(isDefultChoosen:) forControlEvents:UIControlEventTouchUpInside];
            chooseBtn.selected =NO;
            //选圈
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width, 20*Width,40*Width , 40*Width)];
            [chooseBtn addSubview:jiantou];
            jiantou.tag=2001;
            [jiantou setImage:[UIImage imageNamed:@"adress_btn_radio"]];

            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(jiantou.right+20*Width, 0,580*Width , 80*Width)];
            wzlabe.text = leftArr[i];
            wzlabe.tag =20+i;
            wzlabe.font = [UIFont systemFontOfSize:16];
            wzlabe.textColor = TextColor;
            [chooseBtn addSubview:wzlabe];
            
            
        }
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,78*Width, CXCWidth, 2*Width);
        
        
        
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,550*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认添加" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
    
    
}
- (void)chooseBank
{
    
    //选择代理
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"选择银行" cancelTitle:@"取消"destructiveTitle:nil                                                            withNumber:@"7"
        withLineNumber:@"1"
        otherTitles:@[@"中国银行",@"建设银行",@"招商银行",@"农业银行",@"光大银行",@"农商银行"]
        otherImages:nil
        selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                if (index<0||index>5) {
                    return;
                 }
                bankName =[NSString stringWithFormat:@"%ld",index];
                NSLog(@"%zd", index);
            [self bankName];
                                                          }];
    
  
    
    [actionSheet show];
    
    

    
    
}
- (void)bankName
{
    NSArray *arr =@[@"中国银行",@"建设银行",@"招商银行",@"农业银行",@"光大银行",@"农商银行"];
    UILabel *label =[self.view viewWithTag:22];
    label.textColor =[UIColor blackColor];
    label.text =arr[[bankName integerValue]];
    
}
- (void)isDefultChoosen:(UIButton *)btn
{

    UIImageView *img =[self.view viewWithTag:2001];
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        [img setImage:[UIImage imageNamed:@"adress_btn_radio_sel"]];

    }else
    {
        [img setImage:[UIImage imageNamed:@"adress_btn_radio"]];

    }
    


}



- (void)nextStep
{


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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    UITextField *nameTextF =[self.view viewWithTag:10];
    UITextField *numTextF =[self.view viewWithTag:11];
    UITextField *addressTextF =[self.view viewWithTag:13];
    [nameTextF resignFirstResponder];
    [numTextF resignFirstResponder];
    [addressTextF resignFirstResponder];


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
