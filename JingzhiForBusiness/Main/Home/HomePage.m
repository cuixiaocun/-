//
//  HomePage.m
//  Demo_simple
//
//  Created by  on 15/7/8.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "HomePage.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "ShoppingCartVC.h"
#import "LoginPage.h"
#import "ViewController.h"
#import "ComMallView.h"
#import "SearchPage.h"
#import "NoticeVC.h"
#import "GoodsDetailVC.h"
#import "NearlyDelegateVC.h"
#import "HYProblemVC.h"
#import "NoticeDetailVC.h"
#import "BannarDetailVC.h"
#import "TXScrollLabelView.h"
#import "ClassificationList.h"
#import "StudyDecorateVC.h"
#import "HomeOneCollectionViewCell.h"
#import "HomeTwoCollectionViewCell.h"
#import "HomeThreeCollectionViewCell.h"
#import "HouseDetailMainVC.h"

//#import "JPUSHService.h"
@interface HomePage ()<SDCycleScrollViewDelegate,OnClickCMallDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TXScrollLabelViewDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *imagesArray;//滚动图片数组
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    UIView * bottomView;
    UIView *topview ;
    //商品
    UIView *goodsXian;
    NSArray *goodsArr;
    NSMutableArray *titleArr;//公告
    NSArray *imgArr;//banner

}
@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图
@property (nonatomic,weak) id<OnClickCMallDelegate> CMallDelegate;//协议
@property (weak, nonatomic) TXScrollLabelView *scrollLabelView;//

@end
static NSInteger seq = 0;

@implementation HomePage
-(void)btnClickPush:(NSString *)str
{


}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
//首页
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:BGColor];
  
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];

    UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width, 20,140*Width , 44)];
    [topImageView addSubview:addressBtn];
    [addressBtn addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
    UILabel *addLabel = [[UILabel alloc] init];
    [addLabel setText:@"潍坊"];
    addLabel.tag =30;
    addLabel.textColor =[UIColor whiteColor];
    [addLabel setFont:[UIFont systemFontOfSize:14]];
    [addLabel setFrame:CGRectMake(30*Width, 0*Width,75*Width,40)];
    [addressBtn addSubview:addLabel];

    
    UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(100*Width, 25*Width, 15*Width, 24*Width)];
    addShowImgV.image =[UIImage imageNamed:@"home_icon_morecity"];
    [addressBtn addSubview:addShowImgV];
    
    UIButton *navBgView =[[UIButton alloc]initWithFrame:CGRectMake(160*Width, 20+10*Width,430*Width , 60*Width)];
    
    navBgView.backgroundColor =[UIColor colorWithRed:252/255.00 green:93/255.00 blue:40/255.00 alpha:1];
    [topImageView addSubview:navBgView];
    [navBgView addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [navBgView.layer setCornerRadius:30*Width];
    
    UIImageView *bigShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(36*Width, 15*Width, 30*Width, 30*Width)];
    bigShowImgV.image =[UIImage imageNamed:@"home_icon_search"];
    [navBgView addSubview:bigShowImgV];
    UILabel *searchTextField = [[UILabel alloc] init];
    [searchTextField setText:@" 万科润朗园"];
    searchTextField.tag =30;
    searchTextField.textColor =[UIColor whiteColor];
    [searchTextField setFont:[UIFont systemFontOfSize:14]];
    [searchTextField setFrame:CGRectMake(bigShowImgV.right+12*Width, 0,400*Width,60*Width)];
    [navBgView addSubview:searchTextField];
    
    
  
    
    [self makeThisView];//主页面
    [self getBanner];//banner
    [self getNotice];//黄条公告
//    [self getJPUSHServiceTags];//极光推送tags
    [self getGoods];//获取商品
}
- (void)chooseAddress
{
}
- (void)chooseMore:(UIButton*)btn
{
    NSLog(@"%@",btn);

}
- (void)withDrawlsBtnAction //寻找
{
    SearchPage  *search =[[SearchPage alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
-(void)getBanner
{
    cycleScrollView2.imageURLStringsGroup = @[@"home_banner01",@"home_banner01",@"home_banner01"];//放上图片

//    [PublicMethod AFNetworkPOSTurl:@"Home/Index/show" paraments:@{}  addView:self.view success:^(id responseDic) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
//            imgArr=[[NSArray alloc]init];
//            imgArr =  [dict objectForKey:@"data"];
//            imagesArray =[[NSMutableArray alloc]init];
//            
//            for (int i=0; i<imgArr.count; i++) {
//                [imagesArray insertObject:[imgArr[i] objectForKey:@"img"] atIndex:i];
//            }
//            cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
//        }
//        
//    } fail:^(NSError *error) {
//        
//    }];
}
- (void)getNotice
{
    [PublicMethod AFNetworkPOSTurl:@"Home/Index/notice" paraments:@{}  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            NSArray *allArr =[dict objectForKey:@"data"];
            titleArr=[[NSMutableArray alloc]init];
            NSMutableArray* titleArray =[[NSMutableArray alloc]init];
        
            for (int i=0 ; i<allArr.count; i++) {

                if ([[NSString stringWithFormat:@"%@",[allArr[i] objectForKey:@"type"]]isEqualToString:@"2"]) {
                    
                    [titleArray addObject:[NSString stringWithFormat:@"%@",[allArr[i] objectForKey:@"title"]]];
                    
                    [titleArr addObject:allArr[i]];
                    
                }
            }
            [self addWith:TXScrollLabelViewTypeFlipNoRepeat velocity:titleArr.count isArray:YES withArr:titleArray];

        }
        
    } fail:^(NSError *error) {
        
    }];


}

- (void)getGoods
{
//    [PublicMethod AFNetworkPOSTurl:@"Home/Index/product" paraments:@{}  addView:self.view success:^(id responseDic) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
//            goodsArr =[[NSArray alloc]init];
//            goodsArr =[dict objectForKey:@"data"];
//            [_mainCMallCollectionView reloadData];
//    
////            _mainCMallCollectionView.height = (goodsArr.count/2+goodsArr.count%2)*440*Width+20*Width ;//高度=(数量/2+1)*440*width+20*width
////            bottomView.top =  _mainCMallCollectionView.bottom;//得到数量的时候
////            [bgScrollView setContentSize:CGSizeMake(CXCWidth, _mainCMallCollectionView.bottom+64)];
//
//        }
//        
//    } fail:^(NSError *error) {
//        
//    }];
    
    
}
////首页页面布局
-(void)makeThisView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CXCWidth, CXCHeight-64-49)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    //顶部广告图
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth, 240*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    
    UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0,cycleScrollView2.bottom ,CXCWidth ,460*Width )];
    [btnView setBackgroundColor:[UIColor whiteColor ]];
    [bgScrollView addSubview:btnView];
      NSArray *topArr =@[@"home_icon_xiaoguo",@"home_icon_xue",@"home_icon_designer",@"home_icon_gongzhang",@"home_icon_zxgs",@"home_icon_wyzx",@"home_icon_jcsc",@"home_icon_more",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
     NSArray*bottomArr =@[@"效果图",@"学装修",@"设计师",@"找工长",@"装修公司",@"我要装修",@"建材商城",@"更多",@"",@"",];
    [btnView setBackgroundColor:[UIColor whiteColor]];
    for (int i=0; i<8; i++) {
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
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom+10*Width,187*Width,60*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:14];
        botLabel.textColor =BlackColor;
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
    }
    
    topview =[[UIView alloc]initWithFrame:CGRectMake(0, btnView.bottom+1,CXCWidth , 90*Width)];
    topview.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:topview];
    
    //购房指南
    UIImageView *znImgV =[[UIImageView alloc]initWithFrame:CGRectMake(24*Width,27*Width,130*Width,36*Width)];
    znImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"home_icon_zhinan"]];
    [topview addSubview:znImgV];
    
    
    UILabel *prelabel =[[UILabel alloc]initWithFrame:CGRectMake(znImgV.right +24*Width, 25*Width,80*Width, 40*Width)];
    prelabel.text =@"知识";
    prelabel.textAlignment  =NSTextAlignmentCenter;
    [prelabel.layer setBorderWidth:1];
    [prelabel.layer setCornerRadius:2];
    prelabel.layer.borderColor =TextBlueColor.CGColor;
    [prelabel.layer setMasksToBounds:YES];
    prelabel.font =[UIFont systemFontOfSize:12];
    prelabel.textColor =TextBlueColor;
    [topview  addSubview:prelabel ];
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(690*Width, 0*Width, 58*Width, 58*Width)];
    [btn setImage:[UIImage imageNamed:@"vip_btn_close"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(19*Width, 19*Width, 19*Width, 19*Width)];
    [btn addTarget:self action:@selector(hiddenTheTopView) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:btn];
  
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
    [_mainCMallCollectionView registerClass:[HomeOneCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeOneCollectionViewCell class])];
    [_mainCMallCollectionView registerClass:[HomeTwoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeTwoCollectionViewCell class])];
    [_mainCMallCollectionView registerClass:[HomeThreeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeThreeCollectionViewCell class])];

    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _mainCMallCollectionView.backgroundColor =[UIColor whiteColor];

    //设置代理
    _mainCMallCollectionView.delegate = self;
    _mainCMallCollectionView.dataSource = self;
    _mainCMallCollectionView.scrollEnabled = NO;
    [_mainCMallCollectionView reloadData];
    
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 2800*Width+440*Width)];
    _mainCMallCollectionView.height = (14/2+14%2)*440*Width+20*Width ;//高度=(数量/2+1)*440*width+20*width
}
- (void)hiddenTheTopView
{
    topview.hidden=YES;
    bgScrollView.top =64;

}
- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {

        NearlyDelegateVC *search =[[NearlyDelegateVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    }else if (btn.tag==301)
    {
        StudyDecorateVC*search =[[StudyDecorateVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    
    }else if (btn.tag==302)
    {
        NoticeVC  *notice =[[NoticeVC alloc]init];
        notice.hyOrDl =@"HY";
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==303)
    {
        HYProblemVC  *notice =[[HYProblemVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==304)
    {
        HYProblemVC  *notice =[[HYProblemVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==305)
    {
        HYProblemVC  *notice =[[HYProblemVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==306)
    {
        ClassificationList*search =[[ClassificationList alloc]init];
        search.btnNameString =@"基础建材";
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        

    }else if (btn.tag==307)
    {
        HYProblemVC  *notice =[[HYProblemVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }
    }

static MLLinkLabel * kProtypeLabel() {
    static MLLinkLabel *_protypeLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _protypeLabel = [MLLinkLabel new];
        _protypeLabel.font = [UIFont systemFontOfSize:16.0f];
        
        _protypeLabel.numberOfLines = 0;
        _protypeLabel.textInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _protypeLabel.lineHeightMultiple = 1.1f;
    });
    return _protypeLabel;
}


- (CGFloat)heightForExpressionText:(NSAttributedString*)expressionText width:(CGFloat)width
{
    //nib里左右边距是10
    width-=10.0f*2;
    MLLinkLabel *label = kProtypeLabel();
    label.attributedText = expressionText;
    return [label preferredSizeWithMaxWidth:width].height + 5.0f*2; //上下间距
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
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
            botLabel.text =[NSString stringWithFormat:@"%@",@"    热销楼盘"];

        }else if(indexPath.section ==1) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    精选设计案例"];
            
        }else if(indexPath.section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    家居商城"];
            
        }
        [header addSubview:botLabel];

        return header;
    }
//    如果底部视图
        if([kind isEqualToString:UICollectionElementKindSectionFooter]){
            UICollectionReusableView *footer=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
           
            UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
            addressBtn.tag=440+indexPath.section;
            [footer addSubview:addressBtn];
            [addressBtn addTarget:self action:@selector(chooseMore:) forControlEvents:UIControlEventTouchUpInside];
          
            UILabel *addLabel = [[UILabel alloc] init];
            [addLabel setText:@"查看更多 >"];
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
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(220*Width,230*Width);

    }else if (indexPath.section==1) {
        return CGSizeMake(340*Width,360*Width);
        
    }else {
        return CGSizeMake(340*Width,480*Width);
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
    if (section==0) {
        return UIEdgeInsetsMake(10*Width, 20*Width,10*Width,20*Width);

    }else if (section==1) {
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
        
    }else  {
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
        
    }

}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
       HomeOneCollectionViewCell* onecell = (HomeOneCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeOneCollectionViewCell class]) forIndexPath:indexPath];
        onecell.backgroundColor = [UIColor whiteColor];
        //    _cell.dic =goodsArr[indexPath.row];
        return onecell;

    }else  if (indexPath.section==1) {
        HomeTwoCollectionViewCell*twocell = (HomeTwoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeTwoCollectionViewCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        //    _cell.dic =goodsArr[indexPath.row];
        return twocell;
        
    }else {
    
       HomeThreeCollectionViewCell*threecell = (HomeThreeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeThreeCollectionViewCell class]) forIndexPath:indexPath];
        threecell.backgroundColor = [UIColor whiteColor];
        //    _cell.dic =goodsArr[indexPath.row];
        return threecell;

    }
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HouseDetailMainVC*goode =[[HouseDetailMainVC alloc]init];
//        goode.goodsId =[NSString stringWithFormat:@"%@",[goodsArr[indexPath.row] objectForKey:@"id"]];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController  pushViewController:goode animated:YES];
    
    }else
    {
        GoodsDetailVC*goode =[[GoodsDetailVC alloc]init];
        goode.goodsId =[NSString stringWithFormat:@"%@",[goodsArr[indexPath.row] objectForKey:@"id"]];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController  pushViewController:goode animated:YES];
        

    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CXCWidth,100*Width);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{    return CGSizeMake(CXCWidth,80*Width);
    
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BannarDetailVC *notice =[[BannarDetailVC alloc]init];
    notice.bannarDic =[imgArr objectAtIndex:index];
    [self.navigationController pushViewController:notice animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
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
    [topview addSubview:scrollLabelView];
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
    
    NoticeDetailVC *notice =[[NoticeDetailVC alloc]init];
    notice.contentString =[titleArr[index] objectForKey:@"content"];
    notice.titleString =[titleArr[index] objectForKey:@"title"];
    [self.navigationController pushViewController:notice animated:YES];
}

//极光推送的设置tag集合
//- (void)getJPUSHServiceTags
//{
//    [JPUSHService addTags:[self tags] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//        NSLog(@"ertuifghjkl");
//    } seq:(NSInteger)[self seq]];
//}

- (NSSet<NSString *> *)tags {
    NSArray * tagsList = [[NSString stringWithFormat:@"%@",[PublicMethod getDataStringKey:@"registrationID"]] componentsSeparatedByString:@","];
    NSMutableSet * tags = [[NSMutableSet alloc] init];
    [tags addObjectsFromArray:tagsList];
    return tags;
}

- (NSInteger)seq {
    return ++ seq;
}
@end
