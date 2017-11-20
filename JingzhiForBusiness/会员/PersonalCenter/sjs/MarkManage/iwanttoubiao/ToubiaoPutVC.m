//
//  ToubiaoPutVC.m
//  家装
//
//  Created by Admin on 2017/10/30.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ToubiaoPutVC.h"

@interface ToubiaoPutVC ()<UITextViewDelegate>
{
    UIScrollView *bgScrollView;
    UIView *bottomView;

}
@end

@implementation ToubiaoPutVC

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
    [navTitle setText:@"装修投标"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    
    [self mainView];
    
    
    
    
    
}
- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, CXCHeight)];
    
    
    UILabel *promLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 1, CXCWidth, 60*Width)];
    promLabel.backgroundColor =[UIColor colorWithRed:255/255.00 green:240/255.00 blue:210/255.00 alpha:1];
    promLabel.text =[NSString stringWithFormat:@"     投标后查看业主联系方式，消耗金币：50"];
    promLabel.font =[UIFont systemFontOfSize:12];
    promLabel.textColor =NavColor;
    [bgScrollView addSubview:promLabel];
    UIView*contentV =[[UIView alloc]initWithFrame:CGRectMake(0*Width,promLabel.bottom+20*Width, CXCWidth, 210*Width)];
    [bgScrollView addSubview:contentV];
    contentV.backgroundColor =[UIColor whiteColor];
    //活动内容
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(25*Width,10*Width, 700*Width, 190*Width)];
    self.contentTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.contentTextView.text=NSLocalizedString(@"给业主留言", nil);
    //提示语
    self.contentTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.contentTextView.delegate = self;
    self.contentTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.contentTextView.backgroundColor = [UIColor clearColor];
    [contentV addSubview:self.contentTextView];
    
    //地址及以下
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,contentV.bottom,CXCWidth, 520*CXCWidth)];
    [bgScrollView addSubview:bottomView];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,106*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.shadowColor = NavColor.CGColor;
    
    layer.cornerRadius = 44*Width;
    [bottomView.layer addSublayer:layer];
    
    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,106*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:44*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"立即投标" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(sureDrawls) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:nextBtn];
    
    
   
}
- (void)returnBtnAction
{
    
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"给业主留言", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"给业主留言", nil);
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
            textView.text=NSLocalizedString(@"给业主留言", nil);
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
        textView.text=NSLocalizedString(@"给业主留言", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
- (void)sureDrawls
{
    
    NSLog(@"立即投标");
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
