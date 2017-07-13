//
//  MemberDeliverVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MemberDeliverVC.h"

@interface MemberDeliverVC ()<UITextFieldDelegate>
{
    NSArray *logArr;//物流公司的
    NSString* indexOfArr;
    NSMutableArray *codeArr;
    NSMutableArray *nameArr;
    
}
@end

@implementation MemberDeliverVC
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
    [navTitle setText:@"会员发货"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    logArr =[[NSArray alloc]init];
    [self orderlogistics];
    
    [self mainView];
}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)mainView
{
    self.view.backgroundColor =BGColor;
   //    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 2000*Width)];
    UIView * bottomBgView =[[UIView alloc]init];
    [bottomBgView setBackgroundColor:[UIColor whiteColor]];
    bottomBgView.frame =CGRectMake(0, 64+20*Width, CXCWidth,106*2*Width);;
    [self.view addSubview:bottomBgView];
    NSArray*leftArr =@[@"快递公司",@"运单号"] ;
    NSArray *rightArr =@[@"选择快递",@"填写单号"];

    //列表
    for (int i=0; i<2; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bottomBgView addSubview:bgview];
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor grayColor];
        [bgview addSubview:labe];
        if (i==1) {
            //UITextField
            UITextField *inputText = [[UITextField alloc] init];
            [inputText setTag:i+10];
            [inputText setKeyboardType:UIKeyboardTypePhonePad];
            [inputText setPlaceholder:rightArr[i]];
            [inputText setDelegate:self];
            inputText.textAlignment = NSTextAlignmentRight;
            [inputText setFont:[UIFont systemFontOfSize:16]];
            [inputText setTextColor:[UIColor blackColor]];
            [inputText setFrame:CGRectMake(290*Width, 0,415*Width,106*Width)];
            [inputText setClearButtonMode:UITextFieldViewModeWhileEditing];
            [bgview addSubview:inputText];
            
        }else
        {
            //快递公司
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(290*Width, 0,580*Width,106*Width)];
            [bgview addSubview:chooseBtn];
            chooseBtn.tag =10+i;
            [chooseBtn addTarget:self action:@selector(expressChoosen:) forControlEvents:UIControlEventTouchUpInside];
            //文字
            UILabel* wzlabe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,380*Width , 106*Width)];
            wzlabe.text = rightArr[i];
            wzlabe.tag =20+i;
            wzlabe.font = [UIFont systemFontOfSize:16];
            wzlabe.textColor = TextGrayGrayColor;
            [chooseBtn addSubview:wzlabe];
            wzlabe.textAlignment =NSTextAlignmentRight;
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
        bgview.frame =CGRectMake(0, i*106*Width, CXCWidth, 106*Width);
            
            
        
    }
    //下一步按钮
    UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,64+410*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:4];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"确认发货" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
    
    
    
}
- (void)expressChoosen:(UIButton *)btn
{
    //选择快递
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"选择快递公司" cancelTitle:@"取消"destructiveTitle:nil                                                            withNumber:[NSString stringWithFormat:@"%ld",logArr.count+2]
                                                             withLineNumber:@"1"
                                                                otherTitles:nameArr
                                                                otherImages:nil
                                                          selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                              if (index<0||index>logArr.count-1) {
                                                                  return;
                                                              }
                                                              indexOfArr =[NSString stringWithFormat:@"%ld",index];
                                                              NSLog(@"%zd", index);
                                                              [self bankName];
                                                          }];
    
    
    
    [actionSheet show];
    
    
    
    
    
}
- (void)bankName
{
    UILabel *label =[self.view viewWithTag:20];
    label.textColor =[UIColor blackColor];
    label.text =nameArr[[indexOfArr integerValue]];
    
}

- (void)nextStep
{
    
    UITextField* inputText =[self.view viewWithTag:11];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"id":[NSString stringWithFormat:@"%@",_orderId],
                          @"code":[NSString stringWithFormat:@"%@",codeArr[[indexOfArr integerValue]]],
                          @"logistics":[NSString stringWithFormat:@"%@",inputText.text],

//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          }
     ];
    [PublicMethod AFNetworkPOSTurl:@"home/AgenOrder/deliver" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary*  agenDict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil] ;
        if([ [NSString stringWithFormat:@"%@",[agenDict objectForKey:@"code"]]isEqualToString:@"0"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self performSelector:@selector(delayMethodSucess) withObject:nil afterDelay:0.5f];
        }
        
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)delayMethodSucess
{
    [ProgressHUD showSuccess:@"发货成功"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITextField *textF =[self.view viewWithTag:11];
    [textF resignFirstResponder];

}
- (void)orderlogistics
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    
    [dic1 setDictionary:@{}];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgenOrder/logistics" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            logArr =[dict objectForKey:@"data"];
            nameArr =[[NSMutableArray  alloc]init];
            codeArr=[[NSMutableArray  alloc]init];
            for(int i=0;i<logArr.count;i++)
            {
                [codeArr addObject:[logArr[i] objectForKey:@"code"]];
                [nameArr addObject:[logArr[i] objectForKey:@"name"]];
                
            }

        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
    
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
