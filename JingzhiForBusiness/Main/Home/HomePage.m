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
#import "LoginPage.h"
#import "ViewController.h"
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
#import "DropMenuView.h"
#import "FindDesignerVC.h"
#import "FindCompanyVC.h"
#import "DecorateBestVC.h"
#import "KnowledgeVC.h"
#import "ActivityForYouhui.h"
#import "SearchHouseTableViewController.h"
#import "IWantDecorateVC.h"
#import "XYMScanViewController.h"
#import "FreeSendVC.h"
#import "CXCPickView.h"
#import "ShoppingMainVC.h"
#import "DecorateMainVC.h"
#import "SearchHouseVC.h"
#import "AKGallery.h"
@interface HomePage ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,DropMenuViewDelegate,TXScrollLabelViewDelegate,CXCPickerViewDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *imagesArray;//滚动图片数组
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    UIView * bottomView;
    UIView *topview ;
    //collectionViewData
    NSArray *rxlpArr;
    NSArray *jxsjArr;
    NSArray *jjdzArr;
    NSArray *alltitleArr;//公告所有

    NSMutableArray *titleArr;//公告
    NSArray *imgArr;//banner
    CGFloat last ;
    CGFloat lagerst ;
    NSMutableArray *cityArr;

    //替代导航栏的imageview
    UIImageView *topImageView;
    //按钮
    UIButton *nextBtn;
}
@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图
@property(strong, nonatomic) CXCPickView*myPickerView;

@property (weak, nonatomic) TXScrollLabelView *scrollLabelView;//
@property (nonatomic, strong) DropMenuView *oneLinkageDropMenu;
@property (nonatomic, strong) NSArray *addressArr;//地址arr

@end
static NSInteger seq = 0;

@implementation HomePage
-(void)btnClickPush:(NSString *)str
{
}
-(void)viewWillAppear:(BOOL)animated
{
    //黑底白字
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_oneLinkageDropMenu dismiss ];
}
//首页
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%.2f",([[UIScreen mainScreen] bounds].size.height));

    topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_rectStatus+Frame_rectNav)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];

    UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width, Frame_rectStatus,160*Width , Frame_rectNav)];
    [topImageView addSubview:addressBtn];
    [addressBtn addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
    UILabel *addLabel = [[UILabel alloc] init];
    [self getToken];

    if ([PublicMethod getDataStringKey:@"city_id"]) {
        addLabel.text=  [PublicMethod getDataStringKey:@"city_name"];
    }else
    {
        [addLabel setText:@"北京"];
    }
    addLabel.tag =30;
    addLabel.textAlignment  =NSTextAlignmentCenter;
    addLabel.textColor =[UIColor whiteColor];
    [addLabel setFont:[UIFont systemFontOfSize:14]];
    [addLabel setFrame:CGRectMake(20*Width, 0*Width,120*Width,Frame_rectNav)];
    [addressBtn addSubview:addLabel];
    UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(140*Width, 14, 7, 12)];
    addShowImgV.image =[UIImage imageNamed:@"home_icon_morecity"];
    [addressBtn addSubview:addShowImgV];
    
    UIButton *navBgView =[[UIButton alloc]initWithFrame:CGRectMake(180*Width, Frame_rectStatus+8,430*Width , Frame_rectNav-16)];
    navBgView.backgroundColor =[UIColor colorWithRed:252/255.00 green:93/255.00 blue:40/255.00 alpha:1];
    [topImageView addSubview:navBgView];
    [navBgView addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [navBgView.layer setCornerRadius:30*Width];
    
    UIImageView *bigShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(18, 6, 16, 16)];
    bigShowImgV.image =[UIImage imageNamed:@"home_icon_search"];
    [navBgView addSubview:bigShowImgV];
    UILabel *searchTextField = [[UILabel alloc] init];
    [searchTextField setText:@" 万科润朗园"];
    searchTextField.tag =30;
    searchTextField.textColor =[UIColor whiteColor];
    [searchTextField setFont:[UIFont systemFontOfSize:14]];
    [searchTextField setFrame:CGRectMake(bigShowImgV.right+10, 0,150,28)];
    [navBgView addSubview:searchTextField];
  
//    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(CXCWidth-Frame_rectNav, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
//    [rightBtn setImage:[UIImage imageNamed:@"home_btn_scan"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//    [topImageView addSubview:rightBtn];
    [self makeThisView];//主页面
    rxlpArr =[[NSArray alloc]init];
    jxsjArr =[[NSArray alloc]init];
    jjdzArr =[[NSArray alloc]init];
    alltitleArr = [[NSArray alloc]init];
    titleArr =[[NSMutableArray  alloc]init];
    imgArr =[[NSMutableArray alloc]init];
    
    
}
- (void)getToken
{
    if (![PublicMethod getDataStringKey:@"token"]) {
        [PublicMethod AFNetworkPOSTurl:@"mobileapi/?index-gettoken.html" paraments:@{} success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"请求成功JSON:%@", dict);
            [PublicMethod setObject:[dict objectForKey:@"token"]key:@"token"];
            [self getCity];
            NSLog(@"token%@",[PublicMethod getObjectForKey:@"token"]);
        } fail:^(NSError *error) {
            
        }];
        
    }
}
- (void)getCity
{
    
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?index-getcitylist.html" paraments:@{} addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            {
                cityArr =[[NSMutableArray  alloc]init];
                
                NSMutableArray *provinceBeforeArrary =[[NSMutableArray alloc]init];
                provinceBeforeArrary =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"province_list"]];
                
                NSMutableArray  *cityArrary =[[NSMutableArray alloc]init];
                NSMutableArray  *cityAfterArr =[[NSMutableArray alloc]init];
                cityArrary =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"city_list"]];
                
                NSLog(@"%@,12,%@",provinceBeforeArrary,cityArrary);
                
                
                for (int i=0; i<provinceBeforeArrary.count; i++) {
                    NSMutableDictionary *dic= provinceBeforeArrary[i];
                    cityAfterArr =[[NSMutableArray alloc]init];
                    for (int j=0; j<cityArrary.count; j++) {
                        if ([[NSString stringWithFormat:@"%@",[provinceBeforeArrary[i] objectForKey:@"province_id"]]isEqualToString:[NSString stringWithFormat:@"%@", [cityArrary[j] objectForKey:@"province_id"]]]) {
                            [cityAfterArr addObject:cityArrary[j] ];
                            NSLog(@"cityAfterArr = %@",cityAfterArr);
                        }
                    }
                    [dic setObject:cityAfterArr forKey:@"city"];
                    [cityArr addObject:dic];
                    
                }
                
                if (![PublicMethod getDataStringKey:@"city_id"]) {
                    NSArray *arr =[cityArr[0] objectForKey:@"city"];
                    [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"city_id"]] withKey:@"city_id"];
                    [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"city_name"]] withKey:@"city_name"];
                  
                }
                
                    [self getInfor];
                NSLog(@"cityArr = %@",cityArr);

            }
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (void)getInfor
{
  
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?index-index.html" paraments:@{} addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            {
                imgArr  =[[dict objectForKey:@"data"] objectForKey:@"top_advs"];
                rxlpArr =[[dict objectForKey:@"data"] objectForKey:@"rxlp"];
                jxsjArr =[[dict objectForKey:@"data"] objectForKey:@"jpsj"];
                jjdzArr =[[dict objectForKey:@"data"] objectForKey:@"jjsc"];
                alltitleArr =[[dict objectForKey:@"data"] objectForKey:@"ask"];
                titleArr =[[NSMutableArray alloc]init];
                NSArray *arr =[[dict objectForKey:@"data"] objectForKey:@"ask"];
                for (NSDictionary *dic in arr)
                {
                    NSString *titleString =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
                    [titleArr addObject: titleString];
                }
                [self getBanner];
                [self addWith:TXScrollLabelViewTypeFlipNoRepeat velocity:titleArr.count isArray:YES withArr:titleArr];

                [_mainCMallCollectionView reloadData];
                
                _mainCMallCollectionView.height =180*3*Width+((int)(rxlpArr.count+1)/2)*230*Width+((int)(jxsjArr.count+1))/2*360*Width+((int)(jjdzArr.count+1))/2*480*Width;//高度=(数量/2+1)*440*width+20*width
                NSLog(@"mmmmmmm%f----%f===%f---%f",_mainCMallCollectionView.height,_mainCMallCollectionView.bottom,_mainCMallCollectionView.top,topview.bottom);

                [bgScrollView setContentSize:CGSizeMake(CXCWidth, _mainCMallCollectionView.bottom)];
                
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (void)cityListArrInit
{
    
    
    
}
- (void)rightBtnAction
{
    XYMScanViewController *scan =[[XYMScanViewController alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:scan animated:YES];
}
- (void)chooseAddress
{
//    [self.oneLinkageDropMenu removeFromSuperview];
//    self.oneLinkageDropMenu = [[DropMenuView alloc] init];
//    self.oneLinkageDropMenu.delegate = self;
//    [self.oneLinkageDropMenu creatDropView:topImageView withShowTableNum:2 withData:self.addressArr];
    [_myPickerView removeFromSuperview];
    _myPickerView =[[CXCPickView alloc ]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)withArr:cityArr];
    _myPickerView.delegate=self;
    _myPickerView.type =@"cityList";

    [self.view addSubview:_myPickerView];
}
-(void)btnClickBtn:(UIButton *)cell
{
    [self.oneLinkageDropMenu dismiss];
}
- (void)chooseMore:(UIButton*)btn
{
    
    
    NSLog(@"%@",btn);
    if (btn.tag==440) {
        SearchHouseTableViewController  *search =[[SearchHouseTableViewController alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    }else if (btn.tag==441) {
        DecorateBestVC *search =[[DecorateBestVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }else
    {
        ClassificationList*search =[[ClassificationList alloc]init];
        search.btnNameString =@"家居定制";
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }
    
  
}
- (void)withDrawlsBtnAction //寻找
{
    SearchPage  *search =[[SearchPage alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
-(void)getBanner
{
    imagesArray =[[NSMutableArray alloc]init];
    for (int i=0; i<imgArr.count; i++) {
        [imagesArray insertObject:[NSString stringWithFormat:@"%@%@",IMAGEURL,[imgArr[i] objectForKey:@"thumb"]] atIndex:i];
    }
    cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
}

////首页页面布局
-(void)makeThisView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_rectStatus+Frame_rectNav, CXCWidth, CXCHeight-Frame_NavAndStatus-49)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.delegate=self;
    //顶部广告图
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth, 240*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    
    UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0,cycleScrollView2.bottom ,CXCWidth ,230*Width )];
    [btnView setBackgroundColor:[UIColor whiteColor ]];
    [bgScrollView addSubview:btnView];
      NSArray *topArr =@[@"home_icon_xiaoguo",@"home_icon_xue",@"home_icon_jcsc",@"home_icon_designer",@"zx_icon_twt",@"home_icon_zxgs",@"home_icon_wyzx",@"home_icon_jcsc",@"home_icon_hd",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
     NSArray*bottomArr =@[@"搜房",@"装修",@"商城",@"设计师",@"装修公司",@"我要装修",@"建材商城",@"优惠活动",@"",@"",];
    [btnView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *xianImg =[[UIImageView  alloc]initWithFrame:CGRectMake(0,228.5*Width, CXCWidth, 1.5*Width)];
    xianImg.backgroundColor =BGColor;
    [btnView addSubview:xianImg];
    
    
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
    
  
    
//    //按钮
//    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [nextBtn setFrame:CGRectMake(CXCWidth-230*Width,CXCHeight-350*Width , 150*Width, 150*Width)];
//    [nextBtn.layer setCornerRadius:75*Width];
//    [nextBtn.layer setMasksToBounds:YES];
//    nextBtn.alpha=0.9;
//    [nextBtn setImage:[UIImage imageNamed:@"home_icon_publish"] forState:UIControlStateNormal];
//
//    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
//    [nextBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nextBtn];

}
- (void)sendMessage
{    FreeSendVC *free =[[FreeSendVC alloc]init];
    [self.navigationController pushViewController:free animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)hiddenTheTopView
{
    topview.hidden=YES;
    bgScrollView.top =Frame_NavAndStatus;
    
}
- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {

        SearchHouseVC *search =[[SearchHouseVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    }else if (btn.tag==301)
    {
        DecorateMainVC *search =[[DecorateMainVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    
    }else if (btn.tag==302)
    {
        ShoppingMainVC  *notice =[[ShoppingMainVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==303)
    {
        FindDesignerVC  *notice =[[FindDesignerVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//        KnowledgeVC  *notice =[[KnowledgeVC alloc]init];
//        [self.navigationController pushViewController:notice animated:YES];
//        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }else if (btn.tag==304)
    {
        FindCompanyVC  *notice =[[FindCompanyVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==305)
    {
        IWantDecorateVC  *notice =[[IWantDecorateVC alloc]init];
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
        ActivityForYouhui  *notice =[[ActivityForYouhui alloc]init];
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
    if (section==0) {
        return rxlpArr.count;
    }else if (section ==1)
    {
        return jxsjArr.count;
    }else{
        
        return jjdzArr.count;
    }
    
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
            botLabel.text =[NSString stringWithFormat:@"%@",@"    家居定制"];
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
        onecell.dic =rxlpArr[indexPath.row];
        return onecell;

    }else  if (indexPath.section==1) {
        HomeTwoCollectionViewCell*twocell = (HomeTwoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeTwoCollectionViewCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =jxsjArr[indexPath.row];
        return twocell;
    }else {
       HomeThreeCollectionViewCell*threecell = (HomeThreeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeThreeCollectionViewCell class]) forIndexPath:indexPath];
        threecell.backgroundColor = [UIColor whiteColor];
        threecell.dic =jjdzArr[indexPath.row];
        return threecell;
    }
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HouseDetailMainVC*viewController =[[HouseDetailMainVC alloc]init];
        NSLog(@"home_id =%@",[NSString stringWithFormat:@"%@",[rxlpArr[indexPath.row] objectForKey:@"home_id"]]);
        viewController.xinxiTypeId =[NSString stringWithFormat:@"%@",[rxlpArr[indexPath.row] objectForKey:@"xinxitype"]];
        
        viewController.searchId =[NSString stringWithFormat:@"%@",[rxlpArr[indexPath.row] objectForKey:@"home_id"]];
        
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController  pushViewController:viewController animated:YES];
    
    }else  if (indexPath.section==1)
    {
        [self jxsjWithId:[jxsjArr[indexPath.row] objectForKey:@"case_id"]];
        
    }else
    {
        GoodsDetailVC*goode =[[GoodsDetailVC alloc]init];
        goode.goodsId =[NSString stringWithFormat:@"%@",[jjdzArr[indexPath.row] objectForKey:@"product_id"]];
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
    notice.contentString =[alltitleArr[index] objectForKey:@"intro"];
    notice.titleString =[alltitleArr[index] objectForKey:@"title"];
    NSLog(@"%@---%@",notice.titleString,notice.contentString);

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
-(void)dropMenuView:(DropMenuView *)view didSelectName:(NSString *)str
{
    UILabel *btn =[self.view viewWithTag:30];
    btn.text =str;
}
-(void)dissMissLoad
{
    [self.oneLinkageDropMenu dismiss];
}
-(NSArray *)addressArr{
    
    if (_addressArr == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil]];
        
        _addressArr = [dic objectForKey:@"address"];
        NSLog(@"address=%@",_addressArr);
    }
    return _addressArr;
}

- (NSInteger)seq {
    return ++ seq;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //相对于图片的偏移量
    CGFloat reOffset = scrollView.contentOffset.y ;
   
    if (reOffset<last) {
        last =reOffset;
        nextBtn.hidden =NO;
    }else
    {
        last =reOffset;
        nextBtn.hidden =YES;
        
    }

    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
  

    if (bottomOffset-1 <= height)
    {
        //在最底部
        nextBtn.hidden = YES;
    }
    else
    {
      nextBtn.hidden = NO;
    }
    
}
#pragma mark--CXCPickViewDelegate
-(void)tureBtnAction:(NSString *)componentstring forRow:(NSString *)rowString
{
    //选择
    UILabel *typeLabel =[self.view viewWithTag:30];
    typeLabel.text =componentstring;
    NSLog(@"%@---%@",componentstring,rowString);
    [PublicMethod saveDataString:rowString withKey:@"city_id"];
    [PublicMethod saveDataString:componentstring withKey:@"city_name"];
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeNotificationInformatica object:nil];
    
}
- (void)cancelBtnAction:(NSString *)componentstring forRow:(NSString *)rowString
{
    
    
}
- (void)jxsjWithId:(NSString *)stringId
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"case_id":stringId
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?case-detail.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController  success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            NSArray *_dataList =[dict objectForKey:@"data"];
            NSMutableArray* arr= @[].mutableCopy;
            
            for (int  i = 0; i<_dataList.count; i++) {
                
                AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dataList[i] objectForKey:@"photo"]] img:nil];
                [arr addObject:item];
            }
            
            AKGallery* gallery = AKGallery.new;
            gallery.items=arr;
            gallery.custUI=AKGalleryCustUI.new;
            gallery.selectIndex=0;
            gallery.completion=^{
                NSLog(@"completion gallery");
            };
            
            //show gallery
            [self presentAKGallery:gallery animated:YES completion:nil];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}

-(void)presentAKGallery:(AKGallery *)gallery animated:(BOOL)flag completion:(void (^)(void))completion{
    
    //todo:defaults
    
    [gallery.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    [self presentViewController:gallery animated:flag completion:completion];
    
}

@end
