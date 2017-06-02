//
//  GoodsModel.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/2.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
@property(strong,nonatomic)NSString *imageName;//商品图片
@property(strong,nonatomic)NSString *goodsTitle;//商品标题
@property(strong,nonatomic)NSString *goodsPrice;//商品单价
@property(assign,nonatomic)BOOL selectState;//是否选中状态
@property(assign,nonatomic)int goodsNum;//商品个数
@property(strong,nonatomic)NSString *goodsTotalPrice;
-(instancetype)initWithDict:(NSDictionary *)dict;


@end
