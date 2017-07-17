//
//  MyCustomCell.h
//  ShoppingList_Demo
//
//  Created by 李金华 on 15/4/20.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GoodsInfoModel.h"

///添加代理，用于按钮加减的实现
@protocol GoodsInfoCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
@end



@interface MyCustomCell : UITableViewCell
@property(strong,nonatomic)UILabel *goodsTitleLab;//商品名称
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *numCountLab;//购买商品的数量
@property(strong,nonatomic)UIButton *addBtn;//添加商品数量
@property(strong,nonatomic)UIButton *deleteBtn;//删除商品数量
@property(strong,nonatomic)UIButton *deleteAllBtn;//删除商品数量

@property(strong,nonatomic)EGOImageView *goodsImgView;//图片

@property(assign,nonatomic)BOOL selectState;//选中状态

@property(assign,nonatomic)id<GoodsInfoCellDelegate>delegate;


//赋值
-(void)addTheValue:(NSDictionary *)goodsModel;
@end
