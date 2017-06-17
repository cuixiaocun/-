//
//  ComMallView.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallView.h"
@implementation ComMallView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self collectionCM];
    return self;
}
-(void)collectionCM
{
    //初始化图片数组
//    _iconMCVArray = [NSArray arrayWithObjects:@"icon_waimai",@"icon_chaoshi",@"icon_weidian",@"icon_tuangou",@"icon_caishi",nil];
//    self.promptMCVArray = @[@"外卖",@"超市",@"微店",@"团购",@"菜市场"];
    //设置背景颜色
    self.backgroundColor = [UIColor clearColor];
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionview滚动方向
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(0, 0);
    
    
    //3\初始化collextionVIewCell
    mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self addSubview:mainCMallCollectionView];
    [mainCMallCollectionView setBackgroundColor:BGColor];
    
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [mainCMallCollectionView registerClass:[ComMallCollectionViewCell class] forCellWithReuseIdentifier:@"cellCMId"];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置代理
    mainCMallCollectionView.delegate = self;
    mainCMallCollectionView.dataSource = self;
    
    mainCMallCollectionView.scrollEnabled = NO;
    
    [mainCMallCollectionView reloadData];
    
}


//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
        return 4;
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(337.5*Width,420*Width);
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20*Width;
}
//设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(22*Width, 22*Width,22*Width,22*Width);
}

//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = (ComMallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellCMId" forIndexPath:indexPath];
    _cell.backgroundColor = [UIColor whiteColor];
    return _cell;
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.CMallDelegate btnClickPush:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    
}

@end
