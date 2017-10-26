//
//  HouseDetailMainVC.h
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDLabTagsView.h"
@interface HouseDetailMainVC : UIViewController
@property(nonatomic,strong)UILabel*nameLabel;
@property(nonatomic,strong)UILabel*junjiaLabel;
@property(nonatomic,strong)UILabel*pianquLabel;
@property(nonatomic,strong)UILabel*addressLabel;
@property(nonatomic,strong)UILabel*begainSellLabel;
@property(nonatomic,strong)UILabel*jfLabel;

@property(nonatomic,strong)UILabel*kfsLabel;
@property(nonatomic,strong)UILabel*tagLabel;
@property(nonatomic,strong)UILabel*numberLabel;
@property (nonatomic,strong)NSMutableArray *dataArr;//标签
@property (nonatomic,strong)NSString *searchId;//
@property (nonatomic,strong)NSString *xinxiTypeId;//

@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图

//@property(nonatomic,strong)UILabel*nameLabel;
//@property(nonatomic,strong)UILabel*nameLabel;
//@property(nonatomic,strong)UILabel*nameLabel;
//@property(nonatomic,strong)UILabel*nameLabel;

@end
