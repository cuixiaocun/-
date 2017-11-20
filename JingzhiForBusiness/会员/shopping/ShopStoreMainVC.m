//
//  ShopStoreMainVC.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopStoreMainVC.h"
#import "TXScrollLabelView.h"
#import "ShopStoreOneMainCell.h"
#import "ComMallCollectionViewCell.h"
#import "ShopStoreQuanCell.h"
#import "ShopStoreShowCell.h"
#import "ShopStoreTalkCell.h"
#import "ShopNewsCell.h"
#import "FindCompanyTwoCell.h"
#import "ShopStoreDetailVC.h"
#import "TalkShopStoreVC.h"
#import "GoodsDetailVC.h"
#import "ShopGoodsListVC.h"
#import "ShopNewsDetailVC.h"
#import "YHQListVC.h"
#import "ShopNewsListVC.h"
#import "ShopTalkListVC.h"
@interface ShopStoreMainVC ()<UICollectionViewDataSource,UICollectionViewDelegate,TXScrollLabelViewDelegate>
{
    UIScrollView *bgScrollView;//
    UIView *topview ;
    NSMutableArray *plArr;
    NSMutableArray *yhhdArr;
    NSMutableArray *yhqArr;
    NSMutableArray *goodsArr;
    NSDictionary *detailDic;
    UIView *topview2;
    float indexHeightAll;
}
@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图
@property(nonatomic,strong)UIImageView *phoneImageV;
@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation ShopStoreMainVC

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
    [navTitle setText:@"商铺"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    plArr =[[NSMutableArray alloc]init];
    detailDic =[[NSMutableDictionary alloc]init];
    goodsArr =[[NSMutableArray alloc]init];
    yhqArr =[[NSMutableArray alloc]init];
    yhhdArr =[[NSMutableArray alloc]init];
    indexHeightAll =0.0;

    [self getInfor];
    [self getyhq];
    [self getNews];
    [self getPL ];
    [self getGoods];
    [self mainView];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    
    topview =[[UIView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 330*Width)];
    topview.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:topview];
    //图片
    _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
    _phoneImageV.backgroundColor =BGColor;
    _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 190*Width, 190*Width);
    [bgScrollView addSubview:_phoneImageV];
    //名称
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_phoneImageV.top, 460*Width, 60*Width)];
    _nameLabel.text = @"北京凯虹装饰";
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.numberOfLines =0;
    _nameLabel.font =[UIFont systemFontOfSize:14];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:_nameLabel];
    NSArray *arr =@[@"电话:1000-10000000",@"入驻时间:2009-09-02"];
    for(int i=0;i<2;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_nameLabel.bottom+i*60*Width, 400*Width, 60*Width)];
        label.text = [NSString stringWithFormat:@"%@",arr[i]];
        label.textColor=TextColor;
        label.numberOfLines =0;
        label.tag =4800+i;
        label.font =[UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:label];
        
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [bgScrollView addSubview:xian];
    xian.frame =CGRectMake(0,_phoneImageV.bottom+28.5*Width, CXCWidth, 1.5*Width);
    
    NSArray *arr2 =@[@"信誉:",@"口碑:09",@"关注:20"];
    for(int i=0;i<3;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(187.5*i*Width,xian.bottom, 187.5*Width, 90*Width)];
        if (i==0) {
            label.frame =CGRectMake(20*Width, xian.bottom,80*Width, 90*Width);
            UIImage *heartImg =[UIImage imageNamed:@"mall_icon_xinyu"];

            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(label.right,xian.bottom+(90*Width-heartImg.size.height-2)/2,heartImg.size.width*3 , heartImg.size.height-1)];
            img.tag =1200;
            img.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mall_icon_xinyu"]];
            [bgScrollView addSubview:img];
            

        }else if(i==1)
        {
            label.frame =CGRectMake(350*Width, xian.bottom, 200*Width, 90*Width);
            label.tag =190;
            
        }else
        {
            label.tag =191;
            label.frame =CGRectMake(550*Width, xian.bottom, 200*Width, 90*Width);

        }
        label.text = [NSString stringWithFormat:@"%@",arr2[i]];
        label.textColor=TextGrayColor;
        label.numberOfLines =0;
        
        label.font =[UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:label];
        
    }
    

    
    //商品详情
    
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(CXCWidth, 100*Width);
    layout.footerReferenceSize = CGSizeMake(CXCWidth, 80*Width);
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topview.bottom, CXCWidth,0*Width) collectionViewLayout:layout];
    [bgScrollView addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    
    
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId


    [_mainCMallCollectionView registerClass:[ShopStoreOneMainCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopStoreOneMainCell class])];
    [_mainCMallCollectionView registerClass:[ComMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ComMallCollectionViewCell class])];
    [_mainCMallCollectionView registerClass:[ShopStoreQuanCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopStoreQuanCell class])];
    [_mainCMallCollectionView registerClass:[ShopNewsCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopNewsCell class])];
    [_mainCMallCollectionView registerClass:[ShopStoreShowCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopStoreShowCell class])];
    [_mainCMallCollectionView registerClass:[ShopStoreTalkCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopStoreTalkCell class])];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _mainCMallCollectionView.backgroundColor =[UIColor whiteColor];
    
    //设置代理
    _mainCMallCollectionView.delegate = self;
    _mainCMallCollectionView.dataSource = self;
    _mainCMallCollectionView.scrollEnabled = NO;
    [_mainCMallCollectionView reloadData];
    
//    [bgScrollView setContentSize:CGSizeMake(CXCWidth,100000)];
//    _mainCMallCollectionView.height = 100000 ;//高度=(数量/2+1)*440*width+20*width
    
//    //确认提交按钮
//    UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shopCartBtn setFrame:CGRectMake(0*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
//    [shopCartBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:112/255.0 blue:48/255.0 alpha:1]];
//    [shopCartBtn setTitle:@"关注" forState:UIControlStateNormal];
//    [shopCartBtn.titleLabel setTextColor:[UIColor whiteColor]];
//    [shopCartBtn addTarget:self action:@selector(guanzhuBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:shopCartBtn];
//
//    //确认提交按钮
//    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [buyBtn setFrame:CGRectMake(375*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
//    [buyBtn setBackgroundColor:[UIColor colorWithRed:230/255.00 green:47/255.00 blue:44/255.00 alpha:1]];
//    buyBtn.layer.borderColor =[UIColor blueColor].CGColor;
//    [buyBtn setTitle:@"委托设计" forState:UIControlStateNormal];
//    [buyBtn.titleLabel setTextColor:[UIColor whiteColor]];
//    [buyBtn addTarget:self action:@selector(weituoBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:buyBtn];
    

}
- (void)guanzhuBtnAction
{
    
}
- (void)weituoBtnAction
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
        
    }else if(section==1)
    {
        return goodsArr.count;
        
    }else if(section==2)
    {
        return yhqArr.count;
    }else if(section==3)
    {
        return yhhdArr.count;
    }
    else
//    新闻列表---》》》
    return plArr.count;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = nil;
    UICollectionReusableView *footer =nil;
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        [header.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        
        header.backgroundColor =BGColor;
        UILabel *xianV =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth,80*Width)];
        xianV.backgroundColor =BGColor;
        [header addSubview:xianV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,20*Width,CXCWidth,80*Width)];
        botLabel.font =[UIFont systemFontOfSize:16];
        botLabel.textColor =BlackColor;
        botLabel.backgroundColor =[UIColor whiteColor];
        if (indexPath.section ==0) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    商家介绍"];
            [header addSubview:botLabel];
            
        }else if(indexPath.section ==1) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    所有产品"];
            [header addSubview:botLabel];
            
        }else if(indexPath.section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    热门优惠券"];
            [header addSubview:botLabel];
            
        }else if(indexPath.section ==3) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    店铺新闻"];
            [header addSubview:botLabel];
            
        }else
        {
            botLabel.userInteractionEnabled =YES;
            [header addSubview:botLabel];
            
            botLabel.text =[NSString stringWithFormat:@"%@",@"    口碑评分"];
            UIButton*   talkBtn = [[UIButton alloc]init];
            [talkBtn setBackgroundColor:NavColor];
            [talkBtn.layer setCornerRadius:2];
            [talkBtn.layer setMasksToBounds:YES];
            talkBtn.frame =CGRectMake(600*Width,30*Width , 130*Width, 60*Width);
            [talkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [talkBtn setTitle:@"评价" forState:UIControlStateNormal];
            talkBtn.tag=130;
            [talkBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [talkBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:talkBtn];
            
        }
        
        return header;
    }
    //    如果底部视图
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
       footer=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        [footer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
        addressBtn.tag=440+indexPath.section;
        [footer addSubview:addressBtn];
        [addressBtn addTarget:self action:@selector(chooseMore:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *addLabel = [[UILabel alloc] init];
        [addLabel setText:@"查看全部 >"];
        addLabel.tag =30;
        addLabel.textColor =BlackColor;
        addLabel.textAlignment =NSTextAlignmentCenter;
        [addLabel setFont:[UIFont systemFontOfSize:14]];
        [addLabel setFrame:CGRectMake(0*Width,1.5*Width,CXCWidth , 78.5*Width)];
        addLabel.backgroundColor =[UIColor whiteColor];
        [addressBtn addSubview:addLabel];
        [addressBtn setBackgroundColor:[UIColor whiteColor]];
        UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 0*Width, 690*Width, 1.5*Width)];
        addressBtn.backgroundColor =BGColor;
        [addressBtn addSubview:addShowImgV];
        
        return footer;
        
    }
    return nil;
}
- (void)btnAction:(UIButton *)btn
{
    TalkShopStoreVC*talk =[[TalkShopStoreVC alloc]init];
    talk.shopId =_shopId;
    [self.navigationController pushViewController:talk animated:YES];
    
}
- (void)chooseMore:(UIButton *)btn
{
    if (btn.tag==440) {
        
        ShopStoreDetailVC *talk =[[ShopStoreDetailVC alloc]init];
        talk.shopId =_shopId;
        [self.navigationController pushViewController:talk animated:YES];
    }else  if (btn.tag==441) {
        
        ShopGoodsListVC *class =[[ShopGoodsListVC   alloc]init];
        class.shop_id =_shopId;
        [self.navigationController pushViewController:class animated:YES];
    }else  if (btn.tag==442) {
        YHQListVC *class =[[YHQListVC   alloc]init];
        class.shopId =_shopId;
        [self.navigationController pushViewController:class animated:YES];
    }else  if (btn.tag==443) {
        ShopNewsListVC *talk =[[ShopNewsListVC alloc]init];
        talk.shopId =_shopId;
        [self.navigationController pushViewController:talk animated:YES];
        
    }else {
        ShopTalkListVC *talk =[[ShopTalkListVC alloc]init];
        talk.shopId =_shopId;
        [self.navigationController pushViewController:talk animated:YES];
    }
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        NSString *ideaContent =[NSString stringWithFormat:@"所在地点:%@",[detailDic objectForKey:@"addr" ]];
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        [self heightwithHeight:ideaSize.height+330*Width];

        return CGSizeMake(CXCWidth,ideaSize.height+330*Width)  ;
    }else if (indexPath.section==1) {
        if (indexPath.row%2==0) {
            [self heightwithHeight:500*Width];
            
        }

        return CGSizeMake(340*Width,480*Width);
    }else if (indexPath.section==2) {
        
        [self heightwithHeight:360*Width];

        return CGSizeMake(CXCWidth,360*Width);
        
    }else if (indexPath.section==3) {
        [self heightwithHeight:180*Width];

        return CGSizeMake(CXCWidth,180*Width);
        
    }else{
        NSString *ideaContent =[plArr[indexPath.row] objectForKey:@"content"];
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(560*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        [self heightwithHeight:170*Width+ideaSize.height];

        return CGSizeMake(CXCWidth,170*Width+ideaSize.height);
    }
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
    if (section==1) {
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
    }else  {
        return UIEdgeInsetsZero;
    }
    
}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        ShopStoreOneMainCell* onecell = (ShopStoreOneMainCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopStoreOneMainCell class]) forIndexPath:indexPath];
        onecell.backgroundColor = [UIColor whiteColor];
        onecell.dic =detailDic;
        return onecell;
        
    }else  if (indexPath.section==1) {
        ComMallCollectionViewCell*twocell = (ComMallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ComMallCollectionViewCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =goodsArr[indexPath.row];
        return twocell;
        
    }else  if (indexPath.section==2) {
        ShopStoreQuanCell*twocell = (ShopStoreQuanCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopStoreQuanCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =yhqArr[indexPath.row];
        return twocell;
        
    }else  if (indexPath.section==3) {
        ShopNewsCell*twocell = (ShopNewsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopNewsCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =yhhdArr[indexPath.row];
        return twocell;
    }else  {
        ShopStoreTalkCell*twocell = (ShopStoreTalkCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopStoreTalkCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =plArr[indexPath.row];
        return twocell;
    }
    
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        
    }else if (indexPath.section==1) {
        GoodsDetailVC *good =[[GoodsDetailVC alloc]init];
        good.goodsId =[NSString stringWithFormat:@"%@",[goodsArr[indexPath.row] objectForKey:@"product_id"]];
        [self.navigationController pushViewController:good animated:YES];
       
    }else if (indexPath.section==2) {
        
        
    }else if (indexPath.section==3) {
        ShopNewsDetailVC *good =[[ShopNewsDetailVC alloc]init];
        good.newsId =[NSString stringWithFormat:@"%@",[yhhdArr[indexPath.row] objectForKey:@"news_id"]];
        [self.navigationController pushViewController:good animated:YES];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CXCWidth,100*Width);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(CXCWidth,80*Width);
}
- (void)addWith:(TXScrollLabelViewType)type velocity:(CGFloat)velocity isArray:(BOOL)isArray  withArr:(NSArray *)stringArray{
    
    /** Step1: 滚动文字 */
    NSString *scrollTitle = @"";
    NSArray *scrollTexts = stringArray;
    
    /** Step2: 创建 ScrollLabelView */
    TXScrollLabelView *scrollLabelView = nil;
    if (isArray) {
        scrollLabelView = [TXScrollLabelView scrollWithTextArray:scrollTexts type:type velocity:velocity options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    }else {
        scrollLabelView = [TXScrollLabelView scrollWithTitle:scrollTitle type:type velocity:velocity options:UIViewAnimationOptionCurveEaseInOut];
    }
    /** Step3: 设置代理进行回调 */
    scrollLabelView.scrollLabelViewDelegate = self;
    
    /** Step4: 布局(Required) */
    scrollLabelView.frame = CGRectMake(270*Width, 0, 460*Width, 90*Width);
    [topview2 addSubview:scrollLabelView];
    scrollLabelView.scrollSpace = 10;
    scrollLabelView.backgroundColor =[UIColor whiteColor];
    scrollLabelView.font = [UIFont systemFontOfSize:14];
    scrollLabelView.layer.cornerRadius = 5;
    /** Step5: 开始滚动(Start scrolling!) */
    [scrollLabelView beginScrolling];
}
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, (long)index);
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    //    NoticeDetailVC *notice =[[NoticeDetailVC alloc]init];
    //    notice.contentString =[titleArr[index] objectForKey:@"content"];
    //    notice.titleString =[titleArr[index] objectForKey:@"title"];
    //    [self.navigationController pushViewController:notice animated:YES];
}
- (void)getInfor
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"shop_id":[NSString stringWithFormat:@"%@",_shopId],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?shop-index.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]] isEqualToString:@"212"]){
            [self.navigationController popViewControllerAnimated:YES];
        }

        else{

            detailDic =[[dict objectForKey:@"data"] objectForKey:@"shop"];
            [_phoneImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[detailDic objectForKey:@"logo"]]]];
            _nameLabel.text =[detailDic objectForKey:@"name"];
            UILabel *gzLabel =[self.view viewWithTag:4800];
            gzLabel.text =[NSString stringWithFormat:@"电话:%@", IsNilString([detailDic  objectForKey:@"phone"])?@"":[detailDic objectForKey:@"phone"]];
            UILabel *yysLabel =[self.view viewWithTag:4801];

            yysLabel.text =[NSString stringWithFormat:@"入驻时间:%@",[PublicMethod timeWithTimeIntervalString:[detailDic objectForKey:@"dateline"]]];


            UIImageView *img =[self.view viewWithTag:1200];
            UIImage *heartImg =[UIImage imageNamed:@"mall_icon_xinyu"];
            NSString *score =[NSString stringWithFormat:@"%@",[detailDic  objectForKey:@"audit"]];
            img.frame =CGRectMake(100*Width,_phoneImageV.bottom+30*Width+(90*Width-heartImg.size.height-2)/2,heartImg.size.width*[score integerValue], heartImg.size.height-1);

            UILabel *sjLabel =[self.view viewWithTag:190];
            sjLabel.text =[NSString stringWithFormat:@"口碑:%@",[detailDic  objectForKey:@"avg_score"]];

            UILabel *fwLabel =[self.view viewWithTag:191];
            fwLabel.text =[NSString stringWithFormat:@"关注:%@", [detailDic  objectForKey:@"views"] ];

            indexHeightAll = 0.0;
            [self reloadCollectionViewData];



        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)getPL{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"shop_id":[NSString stringWithFormat:@"%@",_shopId],
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?shop-comment_list" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            if (![[[dict objectForKey:@"data"] objectForKey:@"items"]isEqual:[NSNull null]]) {
                plArr  =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"items"]];
                indexHeightAll = 0.0;
                [self reloadCollectionViewData];
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)getGoods{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"limit":@"4",
                          @"page":@"1",
                          @"shop_id":[NSString stringWithFormat:@"%@",_shopId],
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?product-shop_items.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            if (![[[dict objectForKey:@"data"] objectForKey:@"items"]isEqual:[NSNull null]]) {
                goodsArr  =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"items"]];
                indexHeightAll = 0.0;
                [self reloadCollectionViewData];            }
            
        }
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)getyhq{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"limit":@"4",
                          @"page":@"1",
                          @"shop_id":[NSString stringWithFormat:@"%@",_shopId],
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?product-coupon.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            if (![[[dict objectForKey:@"data"] objectForKey:@"item"]isEqual:[NSNull null]]) {
                yhqArr  =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"item"]];
                indexHeightAll = 0.0;
                [self reloadCollectionViewData];
                
            }
            
        }
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)getNews{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"shop_id":[NSString stringWithFormat:@"%@",_shopId],
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?shop-news" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            if (![[[dict objectForKey:@"data"] objectForKey:@"items"]isEqual:[NSNull null]]) {
                yhhdArr  =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"items"]];
                indexHeightAll = 0.0;
                [self reloadCollectionViewData];
                
            }
            
        }
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)reloadCollectionViewData
{
    
    [_mainCMallCollectionView reloadData];
    NSLog(@"最近一次 %f",_mainCMallCollectionView.height);
    NSLog(@"%f",bgScrollView.height);
    
}
- (float)heightwithHeight:(float)height{
    
    indexHeightAll =indexHeightAll+height;
    _mainCMallCollectionView.height =indexHeightAll+900*Width;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, indexHeightAll+330*Width+900*Width)];
    return height;
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
