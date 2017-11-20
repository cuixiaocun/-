//
//  ShopNewsDetailVC.h
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopNewsDetailVC : UIViewController
@property(nonatomic,copy)NSString *newsId;
@property(nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong) UILabel *jianjieLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@end
