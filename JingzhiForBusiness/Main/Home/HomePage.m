//
//  HomePage.m
//  Demo_simple
//
//  Created by  on 15/7/8.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "HomePage.h"
#import "Harpy.h"
@interface HomePage ()<SDCycleScrollViewDelegate>
{

    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *imagesArray;//滚动图片数组
    NSArray *picArr;
    NSString *sharePhone;//传到广告页面的图片
    SDCycleScrollView *cycleScrollView2;//这个是轮播
       
}
@end

@implementation HomePage

//
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    
}
//首页
- (void)viewDidLoad {
    [super viewDidLoad];
    [Harpy checkVersion];
    [self.view setBackgroundColor:BGColor];
  
            //图片
            UIImageView *imageview =[[UIImageView alloc] init];
            [imageview setBackgroundColor:NavColor];
            [imageview setFrame:CGRectMake(0, 0, CXCWidth, 44+Frame_Y)];
            [self.view addSubview:imageview];
            [self.view sendSubviewToBack:imageview];
            //标题
            UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, Frame_Y, CXCWidth, 44)];
            [navTitle setText:@"心体荟控价管理系统"];
            [navTitle setTextAlignment:NSTextAlignmentCenter];
            [navTitle setBackgroundColor:[UIColor clearColor]];
            [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
            [navTitle setNumberOfLines:0];
            [navTitle setTextColor:[UIColor whiteColor]];
            [self.view addSubview:navTitle];
    [self makeThisView];
    [PublicMethod getAppKey];
    
   }

////首页页面布局
-(void)makeThisView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44+Frame_Y, CXCWidth, CXCHeight-44-Frame_Y-49)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 570)];
    //顶部广告图
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth, 310*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    //商品腰线
    
    
    
    
    
    
    
//    
//    //顶部功能选择按钮
//    NSArray *gnBtnArray1 = @[@"home_jiaofei.png",@"home_linli.png",@"home_yiliao.png",@"home_yanglao.png",@"home_baoxiu.png",@"home_fangke.png",@"home_anbao.png",@"home_fuwu.png",@"",@"",@"",@"",@""];
//    NSArray *wzBtnArray1 = @[@"乐购",@"邻里圈",@"健康管家",@"居家养老",@"我要报修",@"访客授权",@"智能安保",@"生活服务",@""];
//    for (int i =0; i<4; i++) {
//        UIButton *gnBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        [gnBtn setFrame:CGRectMake(25*Width+337.5*Width*(i%2), , 337.5*Width, 92.5)];
//        [gnBtn setBackgroundColor:[UIColor whiteColor]];
//        [gnBtn setTag:i+10];
//        [gnBtn addTarget:self action:@selector(gnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [bgScrollView addSubview:gnBtn];
//        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(50/2, 12.5, 30, 30)];
//        [imgV setImage:[UIImage   imageNamed:[NSString stringWithFormat:@"%@",gnBtnArray1[i]]]];
//        [gnBtn addSubview:imgV];
//        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0,imgV.bottom+10, 80, 20)];
//        labe.textColor = TextGrayColor;
//        labe.text = wzBtnArray1[i];
//        labe.textAlignment = NSTextAlignmentCenter;
//        labe.font = [UIFont boldSystemFontOfSize:14];
//        [gnBtn addSubview:labe];
//        
//    }
//    
//    
//    [self getInforBanner];
    
}
//
////的获取bannar，若一张就用EGOImageButton，若多张就用CycleScrollView  ads--上面的广告  ads2--下面的热门推荐
//- (void)getInforBanner
//{
//    
//        [ProgressHUD show:@"加载中"];
//
//    NSString *url=[NSString stringWithFormat:@"/ad/getByCid"];
//    NSDictionary *parameter = @{
//                                @"cid":[NSString stringWithFormat:@"%@",[PublicMethod getObjectForKey:@"cid"]],
//                                @"location":@"1",
//                                @"deviceType":@"2"
//                                };
//    
//    [PublicMethod AFNetworkPOSTurl:url paraments:parameter success:^(id responseDic) {
//
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"请求成功JSON:%@", dict);
//        
//        if (dict) {
//            if ([[dict  objectForKey:@"result"] boolValue]) {
//                
//                picArr =[dict objectForKey:@"ads"];
//                imagesArray =[[NSMutableArray alloc]init];
//                NSMutableArray * titleArr=[[NSMutableArray alloc]init];
//                for (NSDictionary *dic in picArr) {
//                    [titleArr  addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]]];
//                    [imagesArray addObject:[NSString stringWithFormat:@"%@/%@",IMAGEURL,[dic objectForKey:@"icon"]]];
//                }
//                    cycleScrollView2.imageURLStringsGroup = imagesArray;
//                    cycleScrollView2.titlesGroup = titleArr;
//                
//                [ProgressHUD dismiss];
//                    
//                
//            }else{
//                
//                [ProgressHUD showError:@""];
//            }
//        }
//        
//        
//    } fail:^(NSError *error) {
//        NSLog(@"网络连接失败");
//
//        [ProgressHUD showError:@"网络连接失败"];
//        
//    }];
//    
//}
//
//-(void)gnBtnClick:(UIButton *)sender
//{
//
////    LinliquanVC *linliVC =[[LinliquanVC alloc]init];
////    [self.leveyTabBarController hidesTabBar:YES animated:YES];
////
////    [self.navigationController pushViewController:linliVC animated:YES];
//    
//    
//}
//    
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"---点击了第%ld张图片", (long)index);
//    
//}
- (void)getInfor
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"uname":@"123",@"a":@"e24354",@"password":@"213",@"deviceType":@"2",@"w":@"2345"}];
    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];
    NSLog(@"%@",dic);
    [PublicMethod AFNetworkPOSTurl:@"接口名" paraments:dic success:^(id responseDic) {
        
    } fail:^(NSError *error) {
    
    }];

}
@end
