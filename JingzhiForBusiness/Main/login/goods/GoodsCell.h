//
//  GoodsCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/2.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
//添加代理，用于按钮加减的实现
@protocol GoodsCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
@end
@interface GoodsCell : UITableViewCell
@property(strong,nonatomic)UILabel *goodsTitleLab;//商品名称
@property(strong,nonatomic)UILabel *numTitleLab;//箱盒
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *goodsNumLab;//购买数量
@property(strong,nonatomic)UILabel *numCountLab;//购买商品的数量
@property(strong,nonatomic)UIButton *addBtn;//添加商品数量
@property(strong,nonatomic)UIButton *deleteBtn;//删除商品数量
@property(strong,nonatomic)UILabel *priceTotalLab;//具体价格

@property(assign,nonatomic)BOOL selectState;//选中状态

@property(assign,nonatomic)id<GoodsCellDelegate>delegate;


//赋值
-(void)addTheValue:(GoodsModel *)goodsModel;


@end
