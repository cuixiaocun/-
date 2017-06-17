//
//  GoodsDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/17.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "HYConfirmOrderVC.h"
@interface GoodsDetailVC ()<UIScrollViewDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    //替代导航栏的imageview
    UIImageView *topImageView;
    UIImageView* topImageViewNomal;
   
}
@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
       [self mainView];

    
   }

- (void)shateButton
{

    
    
    
    
    

}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView.delegate =self;
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =[UIColor whiteColor];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 2800*Width)];
    topImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    topImageView.alpha =0.0;
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //右
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth   -100, 0, 100, 64)];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [topImageView addSubview:returnBtn];
    
    
    topImageViewNomal= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageViewNomal.userInteractionEnabled = YES;
    topImageViewNomal.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topImageViewNomal];
    topImageViewNomal.alpha =1.0;

    
    //添加返回按钮
    UIButton *  returnBtnNomal = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtnNomal.frame = CGRectMake(0, 20, 44, 44);
    [returnBtnNomal setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtnNomal addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageViewNomal addSubview:returnBtnNomal];
    //右
    UIButton *shareBtnNomal = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth   -100, 0, 100, 64)];
    shareBtnNomal.backgroundColor = [UIColor clearColor];
    [shareBtnNomal addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtnNomal setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [topImageViewNomal addSubview:shareBtnNomal];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"产品详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [topImageView addSubview:navTitle];

    
    
    
    UIImageView *touImgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth,560*Width)];
    touImgView.backgroundColor =TextGrayGray3Color;
    [bgScrollView addSubview:touImgView];
    
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 20*Width+touImgView.bottom, 670*Width, 80*Width)];
    nameLabel.text =@"商品名称";
    nameLabel.textColor =BlackColor;
    nameLabel.font =[UIFont systemFontOfSize:14];
    [bgScrollView addSubview:nameLabel];
    
    UILabel *jifenLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, nameLabel.bottom+15*Width, 500*Width, 30*Width)];
    jifenLabel.text =@"最高可抵扣积分：300";
    jifenLabel.font =[UIFont  systemFontOfSize:12];
    jifenLabel.textColor =TextGrayGrayColor;
    [bgScrollView addSubview:jifenLabel];
    
    UILabel *pricesLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, jifenLabel.bottom+15*Width, 500*Width, 60*Width)];
    pricesLabel.text =@"¥ 300.00";
    pricesLabel.font =[UIFont  systemFontOfSize:16];
    pricesLabel.textColor =NavColor;
    [bgScrollView addSubview:pricesLabel];

    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(0, pricesLabel.bottom+10*Width, CXCWidth, 20*Width)];
    xian.backgroundColor =BGColor;
    [bgScrollView addSubview:xian];
    
    //确认提交按钮
    UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartBtn setFrame:CGRectMake(0*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
    [shopCartBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:112/255.0 blue:48/255.0 alpha:1]];
    [shopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCartBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [shopCartBtn addTarget:self action:@selector(shopCartBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCartBtn];
    
    //确认提交按钮
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(375*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
    [buyBtn setBackgroundColor:NavColor];
    buyBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];

    
    
    
    
    
    
    

}
-(void)shopCartBtnAction
{

}
- (void)buyBtnAction
{
    HYConfirmOrderVC *confirmOrderVC =[[HYConfirmOrderVC alloc]init];
    [self.navigationController pushViewController:confirmOrderVC animated:YES];
    
}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight;
    
    sectionHeaderHeight =560*Width;
    
        //去掉UItableview的section的headerview黏性
        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    NSLog(@"scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
    
    //相对于图片的偏移量
    CGFloat reOffset = scrollView.contentOffset.y ;
    //    (kOriginalImageHeight - 64)这个数值决定了导航条在图片上滑时开始出现  alpha 从 0 ~ 0.99 变化
    //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
    CGFloat alpha = reOffset /(560.0*Width-64) ;
    NSLog(@"reOffset=%f",reOffset);

//    if (alpha <= 1)//下拉永不显示导航栏
//    {
//        alpha = 0;
//    }
//    else//上划前一个导航栏的长度是渐变的
//    {
//        alpha -= 1;
//    }
    // 设置导航条的背景图片 其透明度随  alpha 值 而改变
    topImageView.alpha =alpha;
    topImageViewNomal.alpha =1-alpha;
    
    //  = [self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
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
