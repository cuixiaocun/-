//
//  ShopGoodsListVC.h
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopGoodsListVC : UIViewController
@property(nonatomic,assign)NSString *btnNameString;
@property(nonatomic,assign)NSString *typeIdString;
@property(nonatomic,assign)NSString *shop_id;//如果有shop_id就是店铺的，如果没有shop_id就证明是所有的
@end
