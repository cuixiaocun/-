//
//  MYSignUp.m
//  家装
//
//  Created by Admin on 2017/9/27.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MYSignUp.h"
#import "YHInformationVC.h"
@interface MYSignUp ()
{
    TPKeyboardAvoidingScrollView *bgScrollView;

}
@end

@implementation MYSignUp

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
    [navTitle setText:@"报名管理"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    [self mainView];
}
- (void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)mainView
{
    bgScrollView =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 20*Width)];
    [imgV setBackgroundColor:BGColor];
    [bgScrollView addSubview:imgV];
    
    NSArray *rightArr =@[@"优惠信息",@"我的优惠券",@"",@"",@"",];
    
    //列表
    for (int i=0; i<2; i++) {
        UIButton *bgview =[[UIButton alloc]initWithFrame:CGRectMake(0, 106*Width*i+20*Width, CXCWidth, 106*Width)];
        bgview.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:bgview];
        bgview.tag =100+i;
        [bgview addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 106*Width)];
        labe.text = rightArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = TextColor;
        [bgview addSubview:labe];
        
        //箭头
        UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width, 35*Width,30*Width , 30*Width)];
        [bgview addSubview:jiantou];
        [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,104*Width, CXCWidth, 2*Width);
        }
 
}
- (void)btnAction:(UIButton *)btn
{
    
    if (btn.tag ==100) {
    
        YHInformationVC *yhInfor =[[YHInformationVC alloc]init];
        [self.navigationController pushViewController:yhInfor animated:YES];
        
    }
    
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
