//
//  ComCompanyList.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ComCompanyList.h"
#import "MenuChooseVC.h"
#import "MJRefresh.h"
#import "ComCompanyCell.h"
#import "ShopStoreMainVC.h"
@interface ComCompanyList ()<UITextFieldDelegate,MenuChooseDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSInteger currentPage; //当前页
    UIScrollView*topView;
    NSArray *goodsArr;
    
    NSString *statuString;
    NSIndexPath *index;
    NSString *typeStr;

    
}
@property (nonatomic,retain) UICollectionView *mainCMallCollectionView;//按钮视图

@end

@implementation ComCompanyList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    currentPage =0;
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    UIView *navBgView =[[UIView alloc]initWithFrame:CGRectMake(140*Width, Frame_rectStatus+8,470*Width , 28)];
    [topImageView addSubview:navBgView];
    [navBgView.layer setCornerRadius:14];
    navBgView.backgroundColor =BGColor;
    UIImageView *bigShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(18, 6, 16, 16)];
    bigShowImgV.image =[UIImage imageNamed:@"sf_icon_search"];
    [navBgView addSubview:bigShowImgV];
    UITextField *searchTextField = [[UITextField alloc] init];
    [searchTextField setPlaceholder:@"请输入问题"];
    [searchTextField setDelegate:self];
    searchTextField.tag =30;
    [searchTextField setFont:[UIFont systemFontOfSize:14]];
    [searchTextField setTextColor:[UIColor blackColor]];
    [searchTextField setFrame:CGRectMake(bigShowImgV.right+10, 0,350*Width,28)];
    searchTextField.returnKeyType=UIReturnKeySearch;
    [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [navBgView addSubview:searchTextField];
    
    
    
    //搜索按钮
    UIButton *  searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    searchBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];
    NSArray *btnArr =@[@"全部",@"基础建材",@"家居定制",@"家电",@"配饰",@"其他"];
    topView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, 85*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    topView.showsVerticalScrollIndicator = FALSE;
    topView.showsHorizontalScrollIndicator = FALSE;
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    

    for (int i=0; i<btnArr.count; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statuBtn.frame = CGRectMake(CXCWidth/4*i, 0,CXCWidth/4-2*Width ,85*Width);
        if (i==0) {
            statuBtn.selected =YES;
        }
        
        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
        statuBtn.tag =220+i;
        [statuBtn addTarget:self action:@selector(changeStatuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:statuBtn];
    }
    [topView setContentSize:CGSizeMake(CXCWidth/4*btnArr.count, 85*Width)];

  
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topView addSubview:xian];
    xian.frame =CGRectMake(0,83*Width, CXCWidth, 2*Width);
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus+1+85*Width, CXCWidth,CXCHeight-Frame_NavAndStatus-85*Width) collectionViewLayout:layout];
    [self.view addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCMallCollectionView registerClass:[ComCompanyCell     class] forCellWithReuseIdentifier:NSStringFromClass([ComCompanyCell class])];
    
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    //    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _mainCMallCollectionView.backgroundColor =[UIColor whiteColor];
    
    //设置代理
    _mainCMallCollectionView.delegate = self;
    _mainCMallCollectionView.dataSource = self;
    [_mainCMallCollectionView reloadData];
    [self addFooter];
    
    
    
}
- (void)changeStatuBtn:(UIButton *)btn
{
//    UIImageView *imageview =(UIImageView *)[self.view viewWithTag:14];
    
    [UIView animateWithDuration:0.15 animations:^{
//        [imageview setFrame:CGRectMake(CXCWidth/3*(btn.tag-220), 64+85*Width, CXCWidth/3, 3*Width)];
        
    }completion:^(BOOL finished){
        
    }];
    
    typeStr =[NSString stringWithFormat:@"%ld",btn.tag];
    
    
    
    for (int i=0; i<6; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    statuString =[NSString stringWithFormat:@"%ld",btn.tag-220];
    btn.selected =YES;
    
    currentPage=0;
    [self getInfoList];
    [_mainCMallCollectionView reloadData];



}
- (void)getInfoList
{

}
-(void)btnClickBtn:(UIButton *)cell
{
    
    
}

- (void)withDrawlsBtnAction
{
    
}
- (void)returnBtnAction
{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(CXCWidth,250*Width);
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
    ComCompanyCell* onecell = (ComCompanyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ComCompanyCell class]) forIndexPath:indexPath];
    
    onecell.backgroundColor = [UIColor whiteColor];
    //    _cell.dic =goodsArr[indexPath.row];
    return onecell;
    
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopStoreMainVC*goode =[[ShopStoreMainVC alloc]init];
//    goode.goodsId =[NSString stringWithFormat:@"%@",[goodsArr[indexPath.row] objectForKey:@"id"]];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController  pushViewController:goode animated:YES];
    
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
- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [_mainCMallCollectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        //        // 增加5条假数据
        //        for (int i = 0; i<5; i++) {
        //            [vc.fakeColors insertObject:MJRandomColor atIndex:0];
        //        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.mainCMallCollectionView reloadData];
            // 结束刷新
            [vc.mainCMallCollectionView headerEndRefreshing];
        });
    } dateKey:@"collection"];
    // dateKey用于存储刷新时间，也可以不传值，可以保证不同界面拥有不同的刷新时间
    
#warning 自动刷新(一进入程序就下拉刷新)
    [_mainCMallCollectionView headerBeginRefreshing];
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
