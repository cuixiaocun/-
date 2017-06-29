//
//  CashierVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashierVC : UIViewController
@property (nonatomic,strong) UITableView *selectPayTypeTableView;//支付方式
@property (nonatomic,strong) UIButton *detelBtn;//x按钮
@property (nonatomic,strong) UIImageView *shadowImage;//阴影效果

@property (nonatomic,strong) UIButton *selectPayTreasureButton;//支付宝
@property (nonatomic,strong) UIButton *selectWeChatButton;//微信
@property (nonatomic,strong) UILabel *priceLabel;//价格label
@property (nonatomic,strong) NSString *orderId;//支付id
@property (nonatomic,strong) NSString *orderType;//支付类型
@property (nonatomic,strong) NSDictionary *orderDic;//支付类型

@end
