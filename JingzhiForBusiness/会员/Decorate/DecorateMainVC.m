//
//  DecorateMainVC.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateMainVC.h"
#import "DecorateOneCell.h"
#import "DecorateTwoCell.h"
#import "DecorateThreeCell.h"
#import "DecorateFourCell.h"
#import "KnowledgeVC.h"
#import "DecorateBestVC.h"
#import "StudyDecorateVC.h"
#import "DiaryMainVC.h"
#import "AKGallery.h"

@interface DecorateMainVC ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    NSMutableArray *jpsjArr;
    NSMutableArray *topArr;
    NSMutableArray *xzxArr;
    NSMutableArray *zxrjArr;
    NSMutableArray *wdzqArr;



    
}
@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图

@end

@implementation DecorateMainVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
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
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, Frame_rectStatus, 550*Width, Frame_rectNav)];
    [navTitle setText:@"装修"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
//    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
  
//    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(CXCWidth-Frame_rectNav, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
//    [rightBtn setImage:[UIImage imageNamed:@"sf_icon_search"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//    [topImageView addSubview:rightBtn];
    topArr =[[NSMutableArray alloc]init];
    jpsjArr =[[NSMutableArray alloc]init];
    xzxArr =[[NSMutableArray alloc]init];
    zxrjArr =[[NSMutableArray alloc]init];
    wdzqArr =[[NSMutableArray alloc]init];

    [self makeThisView];
    [self getInfor];
}
- (void)rightBtnAction
{
//    ClassificationList*search =[[ClassificationList alloc]init];
//    [self.navigationController pushViewController:search animated:YES];
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//    
    
    
}
- (void)changeTheme
{
    NSLog(@"装修换城市了啊");
}
- (void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight)];
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
    NSArray *topArr =@[@"zx_icon_zal",@"home_icon_xue",@"zx_icon_rj",@"zx_icon_twt",@"home_icon_zxgs",@"home_icon_wyzx",@"home_icon_jcsc",@"home_icon_more",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    NSArray*bottomArr =@[@"找案例",@"学装修",@"看日记",@"提问题",@"",@"",];
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
    
 
    
    
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(CXCWidth, 100*Width);
    layout.footerReferenceSize = CGSizeMake(CXCWidth, 80*Width);
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,btnView.bottom+0*Width, CXCWidth,0*Width) collectionViewLayout:layout];
    [bgScrollView addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCMallCollectionView registerClass:[DecorateOneCell class] forCellWithReuseIdentifier:NSStringFromClass([DecorateOneCell class])];
    [_mainCMallCollectionView registerClass:[DecorateTwoCell class] forCellWithReuseIdentifier:NSStringFromClass([DecorateTwoCell class])];
    [_mainCMallCollectionView registerClass:[DecorateThreeCell class] forCellWithReuseIdentifier:NSStringFromClass([DecorateThreeCell class])];
    [_mainCMallCollectionView registerClass:[DecorateFourCell class] forCellWithReuseIdentifier:NSStringFromClass([DecorateFourCell class])];

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

- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {
        
        DecorateBestVC*search =[[DecorateBestVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (btn.tag==301)
    {
        StudyDecorateVC*search =[[StudyDecorateVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        
    }else if (btn.tag==302)
    {
        DiaryMainVC*search =[[DiaryMainVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }else if (btn.tag==303)
    {

//
        [[self rdv_tabBarController] setSelectedIndex:3];


    }
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section ==0) {
        return jpsjArr.count;
    }else if (section ==1) {
        return xzxArr.count;
    }else if (section ==2) {
        return zxrjArr.count;
    }else {
        return wdzqArr.count;
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
            botLabel.text =[NSString stringWithFormat:@"%@",@"    设计案例"];
            
        }else if(indexPath.section ==1) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    学装修"];
            
        }else if(indexPath.section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    装修日记"];
            
        }else if(indexPath.section ==3) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    问答专区"];
            
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
- (void)chooseMore:(UIButton *)btn
{
    if (btn.tag==440) {
        DecorateBestVC*search =[[DecorateBestVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }else if (btn.tag==441) {
        StudyDecorateVC*search =[[StudyDecorateVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        

    }else if (btn.tag==442) {
        DiaryMainVC*search =[[DiaryMainVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    }else if (btn.tag==443) {
        KnowledgeVC  *search =[[KnowledgeVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(340*Width,360*Width);
        
    }else if (indexPath.section==1) {
        return CGSizeMake(340*Width,330*Width);
        
    }else if (indexPath.section==2) {
        return CGSizeMake(340*Width,340*Width);
        
    }else {
        return CGSizeMake(CXCWidth ,185*Width);
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
        
    }else if (section==2) {
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
        
    }else  {
        return UIEdgeInsetsMake(0*Width,0*Width,0*Width,0*Width);
        
    }
    
}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        DecorateOneCell* onecell = (DecorateOneCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DecorateOneCell class]) forIndexPath:indexPath];
        onecell.backgroundColor = [UIColor whiteColor];
        onecell.dic =jpsjArr[indexPath.row];
        return onecell;
        
    }else  if (indexPath.section==1) {
        DecorateTwoCell*twocell = (DecorateTwoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DecorateTwoCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
            twocell.dic =xzxArr[indexPath.row];
        return twocell;
        
    }else  if (indexPath.section==3) {
        DecorateFourCell*twocell = (DecorateFourCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DecorateFourCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
            twocell.dic =wdzqArr[indexPath.row];
        return twocell;
        
    }else {
        
        DecorateThreeCell*threecell = (DecorateThreeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DecorateThreeCell class]) forIndexPath:indexPath];
        threecell.backgroundColor = [UIColor whiteColor];
        threecell.dic =zxrjArr[indexPath.row];
        return threecell;
    }
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [self jxsjWithId:[jpsjArr[indexPath.row] objectForKey:@"case_id"]];

    }else if (indexPath.section==1) {
        StudyDecorateVC*search =[[StudyDecorateVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
        
    }else if (indexPath.section==2) {
        DiaryMainVC*search =[[DiaryMainVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
    }else if (indexPath.section==3) {
        KnowledgeVC  *search =[[KnowledgeVC alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        
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
//    BannarDetailVC *notice =[[BannarDetailVC alloc]init];
//    notice.bannarDic =[imgArr objectAtIndex:index];
//    [self.navigationController pushViewController:notice animated:YES];
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)getInfor
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          }];
    
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?article-index.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"])
        {
            
            NSArray *topArry =[[dict objectForKey:@"data"] objectForKey:@"top_advs"];
            
            for (int i=0; i<topArry.count; i++) {
                [topArr insertObject:[NSString stringWithFormat:@"%@%@",IMAGEURL,[topArry[i] objectForKey:@"thumb"]] atIndex:i];
            }
            NSLog(@"thumb =thun=%@",topArr);
            cycleScrollView2.imageURLStringsGroup = topArr;//放上图片
            jpsjArr=[[dict objectForKey:@"data"] objectForKey:@"jpsj"];
            xzxArr=[[dict objectForKey:@"data"] objectForKey:@"xzx"];
            zxrjArr=[[dict objectForKey:@"data"] objectForKey:@"zxrj"];
            wdzqArr=[[dict objectForKey:@"data"] objectForKey:@"wdzq"];
           
        

            [self reloadDataView];
            
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (void)reloadDataView
{
    [_mainCMallCollectionView reloadData];
    _mainCMallCollectionView.height =   ((int)(jpsjArr.count+1)/2)*380*Width+((int)(xzxArr.count+1)/2)*350*Width+((int)(zxrjArr.count+1)/2)*360*Width+(wdzqArr.count)*205*Width+180*4*Width+80*Width;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, _mainCMallCollectionView.bottom)];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
