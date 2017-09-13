//
//  ShoppingMainVC.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShoppingMainVC.h"
#import "ComMallCollectionViewCell.h"
#import "GoodsDetailVC.h"
#import "MJRefresh.h"
#import "ClassificationList.h"
@interface ShoppingMainVC ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *imagesArray;//滚动图片数组
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    UIView * bottomView;
    //商品
    UIView *goodsXian;
    NSArray *goodsArr;
    NSArray *imgArr;//banner

}
@property (nonatomic,retain) UICollectionView *mainCMallCollectionView;//按钮视图

@end

@implementation ShoppingMainVC
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
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
//    //添加返回按钮
//    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    returnBtn.frame = CGRectMake(0, 20, 44, 44);
//    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
//    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"商城"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CXCWidth-44, 20, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"home_icon_search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [topImageView addSubview:rightBtn];
    [self getBanner];
    [self makeThisView];
}
- (void)rightBtnAction
{
    ClassificationList*search =[[ClassificationList alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    


}
- (void)returnBtnAction
{


}
- (void)getGoods
{


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////首页页面布局
-(void)makeThisView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, 540*Width)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =BGColor;
    //顶部广告图
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth, 240*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    
    UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0,cycleScrollView2.bottom ,CXCWidth ,200*Width )];
    [btnView setBackgroundColor:[UIColor whiteColor ]];
    [bgScrollView addSubview:btnView];
    NSArray *topArr =@[@"mall_icon_jcjc",@"mall_icon_jiaju",@"mall_icon_jd",@"mall_icon_rzps",@"home_icon_zxgs",@"home_icon_wyzx",@"home_icon_jcsc",@"home_icon_more",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    NSArray*bottomArr =@[@"基础建材",@"家具",@"家电",@"软装配饰",@"",@"",];
    [btnView setBackgroundColor:[UIColor whiteColor]];
    for (int i=0; i<4; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(187*Width*(i%4),200*Width*(i/4),186*Width,200*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [btnView addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(40.5*Width,25*Width,105*Width,105*Width)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
        topImgV.tag =1100+i;
        [btn addSubview:topImgV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom+10*Width,187*Width,70*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:14];
        botLabel.textColor =BlackColor;
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
    }
    
    UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(0,btnView.bottom+20*Width,CXCWidth,80*Width)];
    xianV.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:xianV];
    UILabel *hxian =[[UILabel alloc]initWithFrame:CGRectMake(200*Width,44*Width,350*Width,2*Width)];
    hxian.backgroundColor =BGColor;
    [xianV addSubview:hxian];
    
    //文字
    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(300*Width,0*Width,150*Width,80*Width)];
    botLabel.font =[UIFont systemFontOfSize:16];
    botLabel.textColor =BlackColor;
    botLabel.backgroundColor =[UIColor whiteColor];
    botLabel.textAlignment =NSTextAlignmentCenter;
    botLabel.text =[NSString stringWithFormat:@"%@",@"特卖汇"];
    [xianV addSubview:botLabel];
    

    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(CXCWidth, 80*Width);
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, CXCWidth,CXCHeight-64-49) collectionViewLayout:layout];
    [self.view addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCMallCollectionView registerClass:[ComMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ComMallCollectionViewCell class])];
    
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _mainCMallCollectionView.backgroundColor =[UIColor whiteColor];
    
    //设置代理
    _mainCMallCollectionView.delegate = self;
    _mainCMallCollectionView.dataSource = self;
    [_mainCMallCollectionView reloadData];
    [self addFooter];
    
}

- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {
        
        ClassificationList*search =[[ClassificationList alloc]init];
        search.btnNameString =@"基础建材";
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==301)
    {
        ClassificationList*search =[[ClassificationList alloc]init];
        search.btnNameString =@"家居";
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        
    }else if (btn.tag==302)
    {
        ClassificationList*search =[[ClassificationList alloc]init];
        search.btnNameString =@"家电";
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }else if (btn.tag==303)
    {
        ClassificationList*search =[[ClassificationList alloc]init];
        search.btnNameString =@"软装配饰";
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        [header addSubview:bgScrollView];

    return header;
    }else
        return nil;
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        return CGSizeMake(340*Width,390*Width);
}
//两个cell之间的间距（同一行的cell的间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0*Width;
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0*Width;
    
    
}

////设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
        
    
}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        ComMallCollectionViewCell* onecell = (ComMallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ComMallCollectionViewCell class]) forIndexPath:indexPath];
        onecell.backgroundColor = [UIColor whiteColor];
        //    _cell.dic =goodsArr[indexPath.row];
        return onecell;
        
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailVC*goode =[[GoodsDetailVC alloc]init];
    goode.goodsId =[NSString stringWithFormat:@"%@",[goodsArr[indexPath.row] objectForKey:@"id"]];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController  pushViewController:goode animated:YES];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CXCWidth,540*Width);
    
}
- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [_mainCMallCollectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
//        for (int i = 0; i<5; i++) {
//           [vc.fakeColors addObject:MJRandomColor];
//        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.mainCMallCollectionView reloadData];
            // 结束刷新
            [vc.mainCMallCollectionView footerEndRefreshing];
        });
    }];
}
-(void)getBanner
{
    cycleScrollView2.imageURLStringsGroup = @[@"home_banner01",@"home_banner01",@"home_banner01"];//放上图片
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
