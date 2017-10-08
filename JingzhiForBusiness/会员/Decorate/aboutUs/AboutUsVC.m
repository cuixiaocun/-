//
//  AboutUsVC.m
//  家装
//
//  Created by Admin on 2017/10/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme) name:ThemeNotificationInformatica object:nil];
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, Frame_rectStatus , 550*Width, Frame_rectNav)];
    [navTitle setText:@"关于我们"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
//    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(CXCWidth-Frame_rectNav, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
//    [rightBtn setImage:[UIImage imageNamed:@"home_icon_search"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//
//    [topImageView addSubview:rightBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)changeTheme
{
    
    
    
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
