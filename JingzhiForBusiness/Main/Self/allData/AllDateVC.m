//
//  AllDateVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AllDateVC.h"
#import "ZHPickView.h"

@interface AllDateVC ()<ZHPickViewDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
}
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation AllDateVC

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
    [navTitle setText:@"销售数据"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    //搜索按钮
    UIButton *  searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    searchBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(getInfoList) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];

    
    [self mainView];
    [self getInfoList];
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    
    NSArray*arr =@[@"选择起始时间",@"选择结束时间"];
    for (int i=0; i<2;i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(375*Width*i,0, 375*Width, 100*Width)];
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        btn.tag =300+i;
        btn.titleLabel.font =[UIFont systemFontOfSize:14];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImageView*sXian =[[UIImageView alloc]initWithFrame:CGRectMake(375*Width, 20*Width, 1*Width, 40*Width)];
    sXian.backgroundColor =BGColor;
    [bgScrollView addSubview:sXian];
    
    NSArray*leftArr =@[@"会员订单",@"总金额",@"订单量",@"下属代理",@"报单量",@"报单额",@"下单量",@"下单额",@"",@"",@"",] ;
    NSArray*rightArr =@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",] ;
    
    for (int i=0; i<8; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        bgview.frame =CGRectMake(0, 120*Width+i*82*Width, CXCWidth, 82*Width);

        if (i>2) {
            bgview.frame =CGRectMake(0, 140*Width+i*82*Width, CXCWidth, 82*Width);

        }
        //左边提示
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [bgview addSubview:labe];
        if (i==0||i==3) {
            labe.font = [UIFont systemFontOfSize:16];
            labe.textColor = TextColor;

        }
        //右边显示
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text = rightArr[i];
        rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =200+i;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = BlackColor;
        [bgview addSubview:rightLabel];
        //分割线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
        
    }
    
    
    



}
- (void)chooseTime:(UIButton*)btn
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    [_pickview  remove];
    
    NSDate *date=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    //        isBegin =NO;
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickview.delegate=self;
    _pickview .tag = btn.tag-100;
    [_pickview show];
    
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (pickView.tag ==200)
    {
        UIButton *btn = [self.view viewWithTag:300];
        
        if ([resultString isEqualToString:@"0"]) {
            [btn setTitle:@"选择起始时间" forState:UIControlStateNormal ];
            [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
            return;
            
        }
        
        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        
        NSInteger time1 = timr;
        
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformat=[[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        
        if(time1>time2+60){
            
            [ProgressHUD showError:@"时间不能晚于今天"];
            return;
            
        }else
        {
            [btn setTitle:[dateFormatter stringFromDate:cellDate] forState:UIControlStateNormal ];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            
        }
        
        
    }else
    {
        if ([resultString isEqualToString:@"0"]) {
            UIButton *btn = [self.view viewWithTag:301];
            [btn setTitle:@"选择结束时间" forState:UIControlStateNormal ];
            
            [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
            
            return;
            
        }
        
        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        NSInteger time1 = timr;
        
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        if(time1>time2+60){
            
            
            [ProgressHUD showError:@"时间不能晚于今天"];
            return;
            
        }else
        {
            UIButton *btn = [self.view viewWithTag:301];
            [btn setTitle:[dateFormatter stringFromDate:cellDate] forState:UIControlStateNormal ];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            
        }
        
        
    }
    
}
- (void)getInfoList
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];

    //始末时间
    UIButton *begainBtn =[self.view viewWithTag:300];
    UIButton *endBtn =[self.view viewWithTag:301];
    if (![begainBtn.currentTitle isEqualToString:@"选择起始时间"]) {
        [dic1 setObject:[NSString stringWithFormat:@"%@ 00:00:00",begainBtn.currentTitle] forKey:@"begintime"];
        
    }
    if(![endBtn.currentTitle isEqualToString:@"选择结束时间"]) {
        [dic1 setObject:[NSString stringWithFormat:@"%@ 23:59:59",endBtn.currentTitle] forKey:@"endtime"];
    }
    
    [PublicMethod AFNetworkPOSTurl:@"Home/Agen/getAgenSubdntCount" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            UILabel*oneLabel =[self.view viewWithTag:201];
            UILabel*twoLabel =[self.view viewWithTag:202];
            UILabel*threeLabel =[self.view viewWithTag:204];
            UILabel*fourLabel =[self.view viewWithTag:205];
            UILabel*fiveLabel =[self.view viewWithTag:206];
            UILabel*sixLabel =[self.view viewWithTag:207];
            oneLabel.text =[NSString stringWithFormat:@"%@元",[[[dict objectForKey:@"data"] objectForKey:@"memberTotal"] objectForKey:@"total"]];
            twoLabel.text =[NSString stringWithFormat:@"%@",[[[dict objectForKey:@"data"] objectForKey:@"memberTotal"] objectForKey:@"count"]];
            fourLabel.text =[NSString stringWithFormat:@"%@元",[[[dict objectForKey:@"data"] objectForKey:@"agenOnlineTotal"] objectForKey:@"total"]];
            threeLabel.text =[NSString stringWithFormat:@"%@",[[[dict objectForKey:@"data"] objectForKey:@"agenOnlineTotal"] objectForKey:@"count"]];
            sixLabel.text =[NSString stringWithFormat:@"%@元",[[[dict objectForKey:@"data"] objectForKey:@"agenOrderTotal"] objectForKey:@"total"]];
            fiveLabel.text =[NSString stringWithFormat:@"%@",[[[dict objectForKey:@"data"] objectForKey:@"agenOrderTotal"] objectForKey:@"count"]];

         
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
