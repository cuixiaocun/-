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
    NSString *bankNameIndex;
    NSMutableArray *bankTitleArr;
    NSMutableArray *bankIdArr;
    NSString *isDefultStr;//是：true否：false

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
    //提现按钮
    if (_bankDetailDic) {
        
    
    UIButton *  withDrawlsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withDrawlsBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    withDrawlsBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [withDrawlsBtn setTitle:@"删除" forState:UIControlStateNormal];
    [withDrawlsBtn addTarget:self action:@selector(deleteTheBankCard) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:withDrawlsBtn];
}
    bankTitleArr =[[NSMutableArray  alloc]init];
    bankIdArr=[[NSMutableArray  alloc]init];
    for(int i=0;i<_bankArr.count;i++)
    {
        [bankIdArr addObject:[_bankArr[i] objectForKey:@"code"]];
        [bankTitleArr addObject:[_bankArr[i] objectForKey:@"val"]];

    
    }
    isDefultStr =@"false";
    NSLog(@"%@--%@",bankIdArr,bankTitleArr);
    [self mainView];
    
    
    
    
    
}
- (void)deleteTheBankCard
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSString *url ;
    [dic1 setDictionary:@{
                          @"id":[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"id"]],

//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                          }];
    
    url =@"home/Account/remove";
       
    [PublicMethod AFNetworkPOSTurl:url paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            [ProgressHUD showSuccess:@"银行卡删除成功"];
            
            [self performSelector:@selector(bankCartDeleteSuccess) withObject:nil afterDelay:0.5f];
            
            
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500*Width)];
    NSArray*leftArr =@[@"姓名",@"银行卡账号",@"开户行",@"支行",@"设置成默认银行卡",@"代理级别",@"身份证号",@"身份证件",@"",@"",@"",@"",] ;
    NSArray *rightArr =[[NSArray alloc]init];
    if (_bankDetailDic) {
        
        rightArr =@[[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"name"]],[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"number"]],[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"bankname"]],[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"branch"]]];
    }else
    {
        rightArr =@[@"",@"",@"",@"",@"",@"",@"",@""];
        
        
        
    }

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
        
            [inputText setText:rightArr[i]];
            
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
            [wzlabe setText:rightArr[i]];

            wzlabe.textAlignment=NSTextAlignmentRight;
            wzlabe.font = [UIFont systemFontOfSize:16];
            if (_bankDetailDic) {
                wzlabe.textColor = [UIColor blackColor];

            }else
            {
                wzlabe.textColor = TextGrayGrayColor;

            }
            [chooseBtn addSubview:wzlabe];
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 20*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
            

            
        
        }
        }else if(i==4)
        {
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(20*Width,0 ,500*Width,80*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(isDefultChoosen:) forControlEvents:UIControlEventTouchUpInside];
            chooseBtn.selected =NO;
            //选圈
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width, 20*Width,40*Width , 40*Width)];
            [chooseBtn addSubview:jiantou];
            jiantou.tag=2001;
            
            if (_bankDetailDic) {
                
                if ([[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"isdefault"]]isEqualToString:@"1"]) {
                    [jiantou setImage:[UIImage imageNamed:@"adress_btn_radio_sel"]];
                    isDefultStr =@"ture";
                    chooseBtn.selected =YES;

                    
                }else if([[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"isdefault"]]isEqualToString:@"2"])
                {
                    [jiantou setImage:[UIImage imageNamed:@"adress_btn_radio"]];
                    isDefultStr =@"false";
                    chooseBtn.selected =NO;

                    
                }

            }else
            {
            
                [jiantou setImage:[UIImage imageNamed:@"adress_btn_radio"]];

            }

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
    [nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
    
    
}
- (void)chooseBank
{
    
    UITextField *nameTF =[self.view viewWithTag:10];
    UITextField *bankNumTF =[self.view viewWithTag:11];
    UITextField *bankAddressTF =[self.view viewWithTag:13];
    

    [nameTF resignFirstResponder];
    [bankNumTF resignFirstResponder];
    [bankAddressTF resignFirstResponder];

    
    //选择银行
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"选择银行" cancelTitle:@"取消"destructiveTitle:nil                                                            withNumber:@"7"
        withLineNumber:@"1"
        otherTitles:bankTitleArr
        otherImages:nil
        selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                if (index<0||index>_bankArr.count-1) {
                    return;
                 }
                bankNameIndex =[NSString stringWithFormat:@"%ld",index];
                NSLog(@"%zd", index);
            [self bankName];
        }];
    
  
    
    [actionSheet show];
    
    

    
    
}
- (void)bankName
{
    UILabel *label =[self.view viewWithTag:22];
    label.textColor =[UIColor blackColor];
    label.text =bankTitleArr[[bankNameIndex integerValue]];
    
}
- (void)isDefultChoosen:(UIButton *)btn
{

    UIImageView *img =[self.view viewWithTag:2001];
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        [img setImage:[UIImage imageNamed:@"adress_btn_radio_sel"]];
        isDefultStr =@"ture";

    }else
    {
        [img setImage:[UIImage imageNamed:@"adress_btn_radio"]];
        isDefultStr =@"false";

    }
    


}



- (void)nextStep
{
    
    
    UITextField *nameTF =[self.view viewWithTag:10];
    UITextField *bankNumTF =[self.view viewWithTag:11];
    UITextField *bankAddressTF =[self.view viewWithTag:13];
  
    [nameTF resignFirstResponder];
    [bankNumTF resignFirstResponder];
    [bankAddressTF resignFirstResponder];
    NSString *bankNameId=bankIdArr[[bankNameIndex integerValue]];
    NSString *bankNamestr=bankTitleArr[[bankNameIndex integerValue]];

    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSString *url ;
    
    if (_bankDetailDic) {
        url =@"home/Account/savebank";
        [dic1 setDictionary:@{
                              @"id":[NSString stringWithFormat:@"%@",[_bankDetailDic objectForKey:@"id"]],
                              @"number":[NSString stringWithFormat:@"%@",bankNumTF.text],

                              @"name":[NSString stringWithFormat:@"%@",nameTF.text],
                              @"code":bankNameId,
                              @"branch":[NSString stringWithFormat:@"%@",bankAddressTF.text],
                              @"bankname":bankNamestr,
                              @"default":isDefultStr,
//                              @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                              }];

    }else
    {
        url =@"home/Account/addbank";
        [dic1 setDictionary:@{
                              @"name":[NSString stringWithFormat:@"%@",nameTF.text],
                              @"code":bankNameId,
                              @"branch":bankNamestr,
                              @"number":[NSString stringWithFormat:@"%@",bankNumTF.text],
                              @"bankname":[NSString stringWithFormat:@"%@",bankAddressTF.text],
                              @"default":isDefultStr,
                              
//                              @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]
                              }];


        
    }

    [PublicMethod AFNetworkPOSTurl:url paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            if (_bankDetailDic) {
                [MBProgressHUD  showSuccess:@"修改成功" ToView:self.view];
//                [ProgressHUD showSuccess:@"修改成功"];
            }else
            {
                [MBProgressHUD  showSuccess:@"添加成功" ToView:self.view];
//                [ProgressHUD showSuccess:@"添加成功"];
            }

            [self performSelector:@selector(bankCartSuccess) withObject:nil afterDelay:1];
        
        
            }
        
    } fail:^(NSError *error) {
        
    }];
    



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
- (void)bankCartSuccess{
    
    [self.navigationController popViewControllerAnimated:YES];
    [_delegate needReloadData  ];

}
- (void)bankCartDeleteSuccess{
    [self.navigationController popViewControllerAnimated:YES];

    [_delegate needReloadData  ];

    
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
