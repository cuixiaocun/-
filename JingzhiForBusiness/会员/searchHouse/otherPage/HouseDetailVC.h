//
//  HouseDetailVC.h
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDLabTagsView.h"
@interface HouseDetailVC : UIViewController
@property(nonatomic,strong)UILabel*nameLabel;

@property(nonatomic,strong)UILabel*priceLabel;
@property(nonatomic,strong)UILabel*pianquLabel;
@property(nonatomic,strong)UILabel*addressLabel;
@property(nonatomic,strong)UILabel*begainSellLabel;
@property(nonatomic,strong)UILabel*kfsLabel;
@property(nonatomic,strong)SDLabTagsView*tagLabel;
@property(nonatomic,strong)UILabel*introduceLabel;
@property (nonatomic,strong)NSMutableArray *dataArr;//标签
@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图

@end
