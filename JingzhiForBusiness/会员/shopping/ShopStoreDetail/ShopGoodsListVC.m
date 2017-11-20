//
//  ShopGoodsListVC.m
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopGoodsListVC.h"
#import "MenuChooseVC.h"
#import "ComMallCollectionViewCell.h"
#import "MJRefresh.h"
#import "GoodsDetailVC.h"
@interface ShopGoodsListVC ()<UITextFieldDelegate,MenuChooseDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSInteger currentPage; //当前页
    MenuChooseVC*topView;
    NSArray *goodsArr;
    NSMutableArray *typeArry;//分类
    NSMutableArray *orderArry;//排序
    NSMutableArray *infoArray;//数据
    BOOL isMore;
    NSString *orderString;
    NSString *cateId;
    
    
    
}
@property (nonatomic,retain) UICollectionView *mainCMallCollectionView;//按钮视图

@end

@implementation ShopGoodsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    currentPage =1;
    isMore =YES;
    orderString =@"";
    cateId =@"";
    orderArry =[[NSMutableArray alloc]init];
    infoArray  =[[NSMutableArray alloc]init];
    cateId =_typeIdString;
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
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"商铺商品"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus+1, CXCWidth,CXCHeight-Frame_NavAndStatus) collectionViewLayout:layout];
    [self.view addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCMallCollectionView registerClass:[ComMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ComMallCollectionViewCell class])];
    
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    //    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _mainCMallCollectionView.backgroundColor =[UIColor whiteColor];
    //设置代理
    _mainCMallCollectionView.delegate = self;
    _mainCMallCollectionView.dataSource = self;
    [_mainCMallCollectionView reloadData];
    [self addFooter];
    [self addHeader];
    typeArry =[[NSMutableArray alloc]init];
    [self getInfoList];
    
}
-(void)btnClickBtn:(UIButton *)cell
{
    if (cell.tag==230) {
        topView.addressArr =typeArry;
        topView.typeString =@"area_list";
        topView.level = 3;
        NSLog(@"cityArr = %@",typeArry[cell.tag-230]);
    }else
    {
        topView.addressArr =orderArry;
        topView.typeString =@"area_list";
        topView.level = 1;
        NSLog(@"cityArr = %@",orderArry[cell.tag-230]);
    }
    
}
-(void)chooseBtnReturn:(UIButton *)btn withStringId:(NSString *)stringId
{
    if (btn.tag==230) {
        cateId =stringId;
    }else{
        orderString =stringId;
    }
    currentPage=1;
    [self performSelector:@selector(getInfoList)];
}
- (void)withDrawlsBtnAction
{
    currentPage=1;
    [self getInfoList];
}
- (void)returnBtnAction
{
    [topView.oneLinkageDropMenu dismiss];
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
    return infoArray.count;
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(340*Width,480*Width);
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
    onecell.dic =infoArray[indexPath.row];
    return onecell;
    
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailVC*goode =[[GoodsDetailVC alloc]init];
    goode.goodsId =[NSString stringWithFormat:@"%@",[infoArray[indexPath.row] objectForKey:@"product_id"]];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController  pushViewController:goode animated:YES];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [_mainCMallCollectionView addFooterWithCallback:^{
        if (isMore==YES) {
            [vc getInfoList];
        }else{
        }
    }];
}
- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [_mainCMallCollectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        isMore =YES;
        currentPage=1;
        [vc getInfoList];
    } dateKey:@"collection"];
#warning 自动刷新(一进入程序就下拉刷新)
    //    [_mainCMallCollectionView headerBeginRefreshing];
}

- (void)getInfoList
{
    UITextField *textF =[self.view viewWithTag:30];
    [textF resignFirstResponder];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    if (_shop_id) {
        [dic1 setDictionary:@{
                              @"shop_id":[NSString stringWithFormat:@"%@",_shop_id],
                              @"page":[NSString stringWithFormat:@"%ld",(long)currentPage],
                              @"limit":@"10",
                              }];
    }
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?product-shop_items.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"])
        {
            orderArry =[[NSMutableArray alloc] init];
            //Order
            NSArray *orderArr =[[dict objectForKey:@"data"] objectForKey:@"order_list"];
            NSMutableDictionary  *dictionary3 =[[NSMutableDictionary alloc]init];
            [dictionary3 setValue:[NSString stringWithFormat:@"%@",@"不限"] forKey:@"name"];
            [dictionary3 setValue:[NSString stringWithFormat:@"%@",@"0"] forKey:@"zipcode"];
            [orderArry addObject:dictionary3];
            for (int i=0;i<orderArr.count; i++) {
                NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
                [dictionary setValue:[NSString stringWithFormat:@"%@",orderArr[i]] forKey:@"name"];
                [dictionary setValue:[NSString stringWithFormat:@"%d",i+1] forKey:@"zipcode"];
                [orderArry addObject:dictionary];
            }
            {
                if (currentPage==1) {
                    [infoArray removeAllObjects];
                }
                NSMutableArray *array=[[dict objectForKey:@"data"] objectForKey:@"items"];
                if ([infoArray isKindOfClass:[NSNull class]]) {
                    [MBProgressHUD  showSuccess:@"没有更多了" ToView:self.view];
                    [_mainCMallCollectionView reloadData];
                    return ;
                }
                [infoArray addObjectsFromArray:array];
                if ([infoArray count]==0 && currentPage==1) {
                    [MBProgressHUD  showSuccess:@"没有更多了" ToView:self.view];
                }
                if (currentPage==1) {
                    [self.mainCMallCollectionView headerEndRefreshing];
                    [_mainCMallCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                }else{
                    
                    
                    // 结束刷新
                    [self.mainCMallCollectionView footerEndRefreshing];
                    
                }
                if (array.count==10) {
                    [self.mainCMallCollectionView setFooterHidden:NO];
                    isMore =YES;
                    currentPage++;
                }else{
                    isMore =NO;
//                    [MBProgressHUD  showSuccess:@"没有更多了" ToView:self.view];
                    [self.mainCMallCollectionView setFooterHidden:YES];
                }
                
                [_mainCMallCollectionView reloadData];
                
            }
     
        }
        
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    currentPage=1;
    [self getInfoList];
    [textField resignFirstResponder];
    
    return YES;
    
}
@end
