//
//  GoodsModel.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/2.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.imageName = dict[@"imageName"];
        self.goodsTitle = dict[@"goodsTitle"];
        self.goodsPrice = dict[@"goodsPrice"];
        self.goodsNum = [dict[@"goodsNum"]intValue];
        self.selectState = [dict[@"selectState"]boolValue];
        self.goodsTotalPrice=dict[@"goodsTotalPrice"];
        self.boxnum=dict[@"boxnum"];
        self.goodID=dict[@"goodID"];

    }
    return  self;
}

@end
