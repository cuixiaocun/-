//
//  ShopNewsDetailVC.m
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopNewsDetailVC.h"

@interface ShopNewsDetailVC ()
{
    NSDictionary *detailDic;
    UIScrollView *bgScrollView;//
    //注册标签
    UILabel *navTitle;

}
@end

@implementation ShopNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    detailDic =[[NSDictionary alloc]init];
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
    
    navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@""];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:16]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    [self getInfor];
    [self mainView];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    bgScrollView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bgScrollView];
    
    _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(25*Width,0,700*Width,80*Width)];
    _timeLabel.textColor = TextGrayColor;
//    _timeLabel.textAlignment =NSTextAlignmentRight;
    _timeLabel.font = [UIFont fontWithName:@"Arial" size:14];
    _timeLabel.backgroundColor = [UIColor clearColor];
//    _timeLabel.text =[NSString stringWithFormat:@"%@",@"时间"];
    [bgScrollView addSubview:_timeLabel];
    
    _jianjieLabel=[[UILabel alloc]initWithFrame:CGRectMake(25*Width,_timeLabel.bottom,700*Width,80*Width)];
    _jianjieLabel.textColor = TextColor;
//    _jianjieLabel.textAlignment =NSTextAlignmentRight;
    _jianjieLabel.font = [UIFont fontWithName:@"Arial" size:16];
    _jianjieLabel.backgroundColor = [UIColor clearColor];
    _jianjieLabel.text =[NSString stringWithFormat:@"%@",@"内容正在努力编辑中。。。"];
    [bgScrollView addSubview:_jianjieLabel];

}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getInfor{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"news_id":[NSString stringWithFormat:@"%@",_newsId],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?shop-newsdetail" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {

            detailDic =[[dict objectForKey:@"data"] objectForKey:@"detail"];
            navTitle.text =[detailDic  objectForKey:@"title"];
            _timeLabel.text =[PublicMethod timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[detailDic  objectForKey:@"dateline"]]];
            

            NSString *ideaContent3 =[NSString stringWithFormat:@"%@",[detailDic  objectForKey:@"content"]];
            CGSize ideaSize3;//通过文本得到高度
            ideaSize3 = [ideaContent3 boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
            _jianjieLabel .numberOfLines =0;
            _jianjieLabel.text = ideaContent3 ;
            _jianjieLabel.height =ideaSize3.height;
            [bgScrollView setContentSize:CGSizeMake(CXCWidth,_jianjieLabel.bottom)];
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
