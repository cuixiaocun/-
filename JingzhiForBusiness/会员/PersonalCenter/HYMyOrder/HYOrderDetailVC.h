//
//  HYOrderDetailVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYOrderDetailVC : UIViewController
@property(strong,nonatomic)EGOImageView *goodsImgView;//图片
@property(strong,nonatomic)UILabel *goodsTitleLab;//商品名称
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *promptLabel;//提示信息
@property(nonatomic,retain)NSDictionary *dic;

@end
