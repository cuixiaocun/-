//
//  PersonalDetail.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PersonalDetail.h"

@interface PersonalDetail ()
{
    //底部scrollview
    UIScrollView *bgScrollView;
    
    
}
@end

@implementation PersonalDetail

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    
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
    [navTitle setText:@"个人信息"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    [self mainView];
}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mainView
{
    
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator =
    NO;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1300*Width)];
    NSArray*leftArr =@[@"会员号",@"推荐人",@"已消费",@"余额",@"",@"",@"",] ;
    NSArray *rightArr =@[@"15602140123",@"秋叶原贸易",@"¥40.00",@"¥1803.99",];
    //列表
    for (int i=0; i<4; i++) {
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        bgview.frame =CGRectMake(0, 20*Width+82*i*Width, CXCWidth, 82*Width);
        [bgScrollView addSubview:bgview];
        
        UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0,200*Width , 82*Width)];
        labe.text = leftArr[i];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = BlackColor;
        [bgview addSubview:labe];
        //右边显示
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text = rightArr[i];
        rightLabel.frame =CGRectMake(250*Width ,0, 460*Width,82*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =200+i;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = BlackColor;
        [bgview addSubview:rightLabel];
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
        
        
        
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
