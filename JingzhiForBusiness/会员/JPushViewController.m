//
//  JPushViewController.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "JPushViewController.h"

@interface JPushViewController ()
{
    UIScrollView *bgScrollView;
}
@end

@implementation JPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    //替代导航栏的imageview
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
    [navTitle setText:@"通知详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    [self makeThisView];
    [PublicMethod getAppKey];
}
- (void)returnBtnAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)makeThisView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-100*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, CXCHeight)];
    
    UILabel *detailLabel =[[UILabel alloc]initWithFrame:CGRectMake(20*Width, 20, CXCWidth-40*Width, 100 )];
    detailLabel.text =[NSString stringWithFormat:@"%@",_detailString];
    [bgScrollView addSubview:detailLabel    ];
    detailLabel.textColor =TextColor;
    detailLabel.numberOfLines =0;
    detailLabel.font =[UIFont systemFontOfSize:15];
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
