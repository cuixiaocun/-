//
//  HouseDetailMainVC.m
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HouseDetailMainVC.h"
#import "TagsModel.h"
#import "HouseDMCollectionViewCell.h"   
#import "HouseDMTwoCollectionViewCell.h"
#import "HouseDetailVC.h"
#import "OtherPlanVC.h"
#import "DesignPlanVC.h"
#import "AKGallery.h"
@interface HouseDetailMainVC ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    //替代导航栏的imageview
    UIImageView *topImageView;
    UIImageView* topImageViewNomal;
    UIView *tabbarView;
    NSArray *photoOfArr;
}

@end

@implementation HouseDetailMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    photoOfArr =[[NSArray alloc]init];
    
    [self mainView];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView.delegate =self;
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =BGColor   ;
    topImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topImageView];
    topImageView.alpha =0.0;
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"歌尔绿城"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [topImageView addSubview:navTitle];
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //右
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"details_btn_white"] forState:UIControlStateNormal];
    [topImageView addSubview:shareBtn];
    
    
    topImageViewNomal= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageViewNomal.userInteractionEnabled = YES;
    topImageViewNomal.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topImageViewNomal];
    topImageViewNomal.alpha =1.0;
    
    
    //添加返回按钮
    UIButton *  returnBtnNomal = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtnNomal.frame = CGRectMake(0, 20, 44, 44);
    [returnBtnNomal setImage:[UIImage imageNamed:@"sf_icon_xiang_goBack"] forState:UIControlStateNormal];
    [returnBtnNomal addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageViewNomal addSubview:returnBtnNomal];
    //    //右
    UIButton *shareBtnNomal = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
    shareBtnNomal.backgroundColor = [UIColor clearColor];
    [shareBtnNomal addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtnNomal setImage:[UIImage imageNamed:@"details_btn_cart"] forState:UIControlStateNormal];
    [topImageViewNomal addSubview:shareBtnNomal];
    
    UIImageView *touImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 556*Width)];
    touImageView.image =[UIImage imageNamed:@"timg-8.jpeg"];
    touImageView.backgroundColor =[UIColor grayColor];
    [bgScrollView addSubview:touImageView];
    [touImageView setUserInteractionEnabled:YES];
    
    
    
    UIImageView *tmImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 556*Width)];
    tmImgV.backgroundColor =[UIColor blackColor];
    tmImgV.alpha =0.2;
    [bgScrollView addSubview:tmImgV];
    
    for (int i=0;i<3; i++) {
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(46*Width, 360*Width+65*i*Width, Width*650, 65*Width)];
        label.textColor =[UIColor whiteColor];
        label.tag =110+i;
        if (i==0) {
            label.font =[UIFont boldSystemFontOfSize:18];
            _nameLabel=label;
            label.text =@"歌尔绿洲";


        }else if(i==1)
        {
            label.font =[UIFont boldSystemFontOfSize:14];
            _junjiaLabel =label;
            label.text =@"均价12000/㎡";

        }else if(i==2)

        {
            label.font =[UIFont boldSystemFontOfSize:14];
            _pianquLabel =label;
            label.text =@"高新城市广场";

        }
        [touImageView addSubview:label];
        
    }
    
    UIButton *playBtn =[[UIButton alloc]initWithFrame:CGRectMake(570*Width, 486*Width,180*Width , 70*Width)];
    [touImageView addSubview:playBtn];
    [playBtn addTarget:self action:@selector(playPhoto) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width, 19*Width, 32*Width, 32*Width)];
    addShowImgV.image =[UIImage imageNamed:@"sf_btn_all_pic"];
    [playBtn addSubview:addShowImgV];
    

    UILabel *addLabel = [[UILabel alloc] init];
    [addLabel setText:@"共100张"];
    addLabel.tag =30;
    addLabel.textAlignment=NSTextAlignmentCenter;
    addLabel.textColor =[UIColor whiteColor];
    [addLabel setFont:[UIFont systemFontOfSize:12]];
    addLabel.backgroundColor =[UIColor blackColor];
    addLabel.layer.borderColor =BGColor.CGColor;
    [addLabel setFrame:CGRectMake(addShowImgV.right+ 30*Width, addShowImgV.top,110*Width,32*Width)];
    [addLabel.layer setMasksToBounds:YES];
    [addLabel.layer setCornerRadius:16*Width];

    [playBtn addSubview:addLabel];
    
    tabbarView =[[UIView alloc]initWithFrame:CGRectMake(0, touImageView.bottom, CXCWidth, 190*Width)];
    tabbarView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:tabbarView];
    NSArray *topArr =@[@"sfxq_icon_xq",@"sfxq_icon_fangan",@"sfxq_icon_huxing",@"sfxq_icon_shijing",@"sfxq_icon_yangban",@"",@"",@"",@"",@"",@"",];
    NSArray*bottomArr =@[@"详情",@"设计方案",@"户型图",@"实景图",@"样板间",@"",@"",];
    for (int i=0; i<5; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(41*Width+141*Width*i,0,100*Width,190*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [tabbarView addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(18*Width,40*Width,64*Width,50*Width)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
        topImgV.tag =1100+i;
        [btn addSubview:topImgV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(-20*Width,topImgV.bottom+20*Width,140*Width,40*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.textColor =BlackColor;
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
    }
    UIView*middleLabel =[[UIView alloc]init];
    middleLabel.frame =CGRectMake(0, tabbarView.bottom+20*Width, CXCWidth, 315*Width);
    middleLabel.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:middleLabel];

    for (int i=0; i<4; i++) {
        //文字
        if (i<3) {
            UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,30*Width+i*65*Width,CXCWidth,65*Width)];
            botLabel.font =[UIFont systemFontOfSize:13];
            botLabel.textColor =BlackColor;
            if (i==0) {
                _addressLabel =botLabel;
                _addressLabel.text =@"地区：高新区健康街与淮安路交汇处东南300米";
            }else if (i==1) {
                _begainSellLabel =botLabel;
                _begainSellLabel.text =@"开盘：2017年09月07日28号楼加推";
            }else if (i==2) {
                _kfsLabel =botLabel;
                _kfsLabel.text =@"开发商：潍坊歌尔职业有限公司";
            }
            [middleLabel addSubview:botLabel];

        }else
        {
            _tagLabel =[SDLabTagsView sdLabTagsViewWithTagsArr:self.dataArr];
            _tagLabel.frame =CGRectMake(24*Width, _kfsLabel.bottom, 460*Width, (_tagLabel.rowNumber+1)*40*Width);
            
            [middleLabel addSubview:_tagLabel];
        
        
        }
        
        
    }
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(CXCWidth, 100*Width);
    layout.footerReferenceSize = CGSizeMake(CXCWidth, 80*Width);
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, middleLabel.bottom, CXCWidth,0*Width) collectionViewLayout:layout];
    [bgScrollView addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCMallCollectionView registerClass:[HouseDMCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HouseDMCollectionViewCell class])];
    [_mainCMallCollectionView registerClass:[HouseDMTwoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HouseDMTwoCollectionViewCell class])];

    
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
    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor colorWithRed:59/255.00 green:63/255.00 blue:80/255.00 alpha:1]];
    [self.view addSubview:bottomBgview];
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(50*Width, 0, 500*Width, 100*Width)];
    [subPromLabel setText:@"喜欢这个风格？找TA设计"];
    [subPromLabel  setFont:[UIFont systemFontOfSize:16]];
    [bottomBgview  addSubview:subPromLabel];
    [subPromLabel  setTextColor:[UIColor whiteColor]];
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(540*Width,20*Width , 170*Width, 60*Width)];
    [confirmBtn setBackgroundColor:orangeColor];
    confirmBtn.layer.cornerRadius =30*Width;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmBtn setTitle:@"免费设计" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(searchSheji) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];
    

       
}
- (void)searchSheji
{


}
- (NSMutableArray *)dataArr{
    {
        if (!_dataArr){
            NSArray *dataArr =@[@{@"color":@"eb3027",@"title":@"住宅"},@{@"color":@"22b6ff",@"title":@"五证齐全"},@{@"color":@"51b20a",@"title":@"车位充足"},@{@"color":@"eb3027",@"title":@"创意地产"}];
            NSMutableArray *tempArr =[NSMutableArray array];
            for (NSDictionary *dict in dataArr){
                TagsModel *model =[[TagsModel alloc]initWithTagsDict:dict];
                [tempArr addObject:model];
            }
            _dataArr =[tempArr copy];
        }
        return _dataArr;
    }
    
}

- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag==300) {
        HouseDetailVC *house =[[HouseDetailVC alloc]init];
        [self.navigationController pushViewController:house animated:YES];
    }else if (btn.tag==301)
    {
        DesignPlanVC *house =[[DesignPlanVC alloc]init];
        [self.navigationController pushViewController:house animated:YES];
    
    }else if (btn.tag==302)
    {
        OtherPlanVC *house =[[OtherPlanVC alloc]init];
        house.navString =@"户型图";
        [self.navigationController pushViewController:house animated:YES];
    }else if (btn.tag==303)
    {
        OtherPlanVC *house =[[OtherPlanVC alloc]init];
        house.navString =@"实景图";
        [self.navigationController pushViewController:house animated:YES];
    }else if (btn.tag==304)
    {
        OtherPlanVC *house =[[OtherPlanVC alloc]init];
        house.navString =@"样板间";
        [self.navigationController pushViewController:house animated:YES];
    }
}
- (void)playPhoto
{
    NSMutableArray* arr= @[].mutableCopy;
    photoOfArr =@[@"timg-8.jpeg",@"timg-8.jpeg",@"timg-8.jpeg",@"timg-8.jpeg",@"timg-8.jpeg",@"timg-8.jpeg"];
    
    for (int  i = 0; i<photoOfArr.count; i++) {
        //        NSLog(@"%@",[NSString stringWithFormat:@"%@",_arr_Imgs]);
        
        AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:nil img:[UIImage imageNamed:[NSString stringWithFormat:@"%@",photoOfArr[i]]]];
        [arr addObject:item];
    }
    //判断 当前显示那一页数据
    
    AKGallery* gallery = AKGallery.new;
    gallery.items=arr;
    gallery.custUI=AKGalleryCustUI.new;
    gallery.selectIndex=0;
    gallery.completion=^{
        NSLog(@"completion gallery");
        
    };
    [self presentAKGallery:gallery animated:YES completion:nil];
    
    


}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shateButton
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==bgScrollView)
    {
        
        //相对于图片的偏移量
        CGFloat reOffset = scrollView.contentOffset.y ;
        //    (kOriginalImageHeight - 64)这个数值决定了导航条在图片上滑时开始出现  alpha 从 0 ~ 0.99 变化
        //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
        CGFloat alpha = reOffset /(556.0*Width-64) ;
        NSLog(@"reOffset=%f",reOffset);
        // 设置导航条的背景图片 其透明度随  alpha 值 而改变
        topImageView.alpha =alpha;
        topImageViewNomal.alpha =1-alpha;
        
    }else
    {
        
        bgScrollView.userInteractionEnabled = YES;//控制是否可以响应用户点击事件（touch）
        bgScrollView.scrollEnabled = YES;//控制是否可以滚动
    }
    
    
    //  = [self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
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
            botLabel.text =[NSString stringWithFormat:@"%@",@"    户型图"];
            
        }else if(indexPath.section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    实景图"];
            
        }else if(indexPath.section ==3) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    样板间"];
            
        }
        [header addSubview:botLabel];
        
        return header;
    }
    //    如果底部视图
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        
        UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
        [footer addSubview:addressBtn];
        addressBtn.tag =110+indexPath.section;
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
- (void)chooseMore:(UIButton*)btn
{
    NSLog(@"%ld",btn.tag);

}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(340*Width,360*Width);
        
    }else {
        return CGSizeMake(340*Width,260*Width);
        
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
    
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
        
    
}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HouseDMCollectionViewCell* onecell = (HouseDMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HouseDMCollectionViewCell class]) forIndexPath:indexPath];
        onecell.backgroundColor = [UIColor whiteColor];
        //    _cell.dic =goodsArr[indexPath.row];
        return onecell;
        
    }else
    {
        
        HouseDMTwoCollectionViewCell*twocell = (HouseDMTwoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HouseDMTwoCollectionViewCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        //    _cell.dic =goodsArr[indexPath.row];
        return twocell;
        
    }
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    GoodsDetailVC*goode =[[GoodsDetailVC alloc]init];
//    goode.goodsId =[NSString stringWithFormat:@"%@",[goodsArr[indexPath.row] objectForKey:@"id"]];
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//    [self.navigationController  pushViewController:goode animated:YES];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CXCWidth,100*Width);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{    return CGSizeMake(CXCWidth,80*Width);
    
    
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
