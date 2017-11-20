//
//  ChuliYuyueDetailVC.m
//  家装
//
//  Created by Admin on 2017/10/31.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ChuliYuyueDetailVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ZHPickView.h"

@interface ChuliYuyueDetailVC ()<UITextViewDelegate,ZHPickViewDelegate>
{
    TPKeyboardAvoidingScrollView *bgScrollView;
}
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *needLabel;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UITextView*beizhuTextView;

@end

@implementation ChuliYuyueDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"预约处理"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    [self mainView];
}
-(void)tureBtnAction:(NSString *)componentstring forRow:(NSString *)rowString
{
    //选择
    UILabel *typeLabel =[self.view viewWithTag:44];
    typeLabel.text =componentstring;
    typeLabel.textColor =[UIColor blackColor];
    
}
- (void)cancelBtnAction:(NSString *)componentstring forRow:(NSString *)rowString
{
    //选择
    UILabel *typeLabel =[self.view viewWithTag:44];
    typeLabel.text =componentstring;
    typeLabel.textColor =[UIColor blackColor];
    
    
}
- (void)returnBtnAction
{
    [_pickview remove];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)mainView
{
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus+20*Width, CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    //bgScrollView.backgroundColor =[UIColor redColor];
    bgScrollView.scrollEnabled = YES;
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];

    NSArray*leftArr =@[@"半小时",@"联系人",@"电话",@"备注要求",@"跟进状态",@"",@"",@"",] ;
    NSArray*rightArr =@[@"",@"王先生",@"13709801982",@"尽快处理",@"开工大吉",@"",@"",@"",] ;
    
    for (int i=0; i<6; i++) {
        
        UIView *bgview =[[UIView alloc]init];
        bgview.frame =CGRectMake(0,100*i*Width, CXCWidth, 100*Width);
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        UILabel* leftLabe = [[UILabel alloc]initWithFrame:CGRectMake(100*Width,20*Width ,200*Width , 40*Width)];
        leftLabe.text = leftArr[i];
        leftLabe.font = [UIFont systemFontOfSize:15];
        leftLabe.textColor = BlackColor;
        [bgview addSubview:leftLabe];
        leftLabe.frame = CGRectMake(32*Width,20*Width ,200*Width , 40*Width);
        
        if (i<4) {
            //右边
            UILabel *label = [[UILabel alloc] init];
            [label setTag:i+70];
            label.text =rightArr[i];
            [label setFont:[UIFont systemFontOfSize:16]];
            [label setTextColor:[UIColor blackColor]];
            [label setFrame:CGRectMake(200*Width, 0,520*Width,99*Width)];
            label.textAlignment =NSTextAlignmentRight;
            [bgview addSubview:label];
            if (i==0) {
                self.timeLabel =leftLabe;
            }else if (i==1)
            {
                self.nameLabel =label;
                
            }else if (i==2)
            {
                self.phoneLabel =label;
            }else if (i==3)
            {
                self.needLabel =label;
            }
            
        }else if(i==4)
        {
           
            UIButton* deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteBtn.frame = CGRectMake(300*Width, 0*Width, 450*Width, 99*Width);
            [deleteBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            deleteBtn.tag = 90+i;
            [bgview addSubview:deleteBtn];
            
            UILabel*rightLabel  =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350*Width, 99*Width)];
            rightLabel.text = rightArr[i];
            rightLabel.font = [UIFont systemFontOfSize:15];
            rightLabel.textColor = BlackColor;
            rightLabel.tag =40+i;
            rightLabel.textAlignment =NSTextAlignmentRight;
            [deleteBtn addSubview:rightLabel];
            
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 35*Width,30*Width , 30*Width)];
            [bgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
        }else
        {
            bgview.frame =CGRectMake(0,100*i*Width, CXCWidth, 210*Width);
            //活动内容
            self.beizhuTextView = [[UITextView alloc] initWithFrame:CGRectMake(25*Width,0, 700*Width, 210*Width)];
            self.beizhuTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
            self.beizhuTextView.text=NSLocalizedString(@"商家备注", nil);//提示语
            self.beizhuTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
            self.beizhuTextView.delegate = self;
            self.beizhuTextView.font = [UIFont fontWithName:@"Arial" size:15];
            self.beizhuTextView.backgroundColor = [UIColor clearColor];
            [bgview addSubview:self.beizhuTextView];
            
        }
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,98.5*Width, CXCWidth, 1.5*Width);
        
        if (i==5)
        {
            xian.frame =CGRectMake(0,218.5*Width, CXCWidth, 1.5*Width);
        }
        
        
    }
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,800*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.shadowColor = NavColor.CGColor;
    
    layer.cornerRadius = 44*Width;
    [bgScrollView.layer addSublayer:layer];
    
    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,800*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:44*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"更新状态" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(upDateStatus) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
}

- (void)upDateStatus
{
    
    
}


- (void)sureDrawls
{
    
    
}








- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //oneDay > anotherDay
        return 1;
    }
    else if (result == NSOrderedAscending){
        //oneDay < anotherDay
        return -1;
    }
    //oneDay = anotherDay
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)choose:(UIButton*)btn{
    [_pickview remove];
        _pickview =[[ZHPickView alloc]initPickviewWithArray:@[@"开工大吉",@"水电改造",@"泥瓦工阶段",@"木工阶段",@"油漆阶段",@"安装",@"验收完成",@"",@"",@""] isHaveNavControler:NO];
        _pickview.delegate=self;
        _pickview .tag = 103;
        [_pickview show];
   
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    //选择日期
    UILabel *typeLabel =[self.view viewWithTag:41];
    typeLabel.text =resultString;
    typeLabel.textColor = [UIColor blackColor];
    
    
    
}


-(void) postShadowTap:(UITapGestureRecognizer *)sender
{
}
// - - -- - -- -  -- - - - - -- - - -textField或者textView代理 - -- - - - -- - - -- - - -- - - -- - - -- -
//点击return 按钮 去掉

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"商家备注", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"商家备注", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if ([textView.text isEqualToString:@""])
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text=NSLocalizedString(@"商家备注", nil);
        }
        
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"商家备注", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
