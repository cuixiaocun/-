//
//  HYPersonalCenterVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SJSPersonalCenterDelegate <NSObject>
-(void)setSelectedIndex:(NSUInteger)intage;
@end

@interface SJSPersonalCenterVC : UIViewController
@property(assign,nonatomic)id<SJSPersonalCenterDelegate>delegate;
@property(strong,nonatomic)UILabel *roleLabel;//角色
@property(strong,nonatomic)UILabel *nameLabel;//姓名
@property(strong,nonatomic)UILabel *yuyueLabel;//预约
@property(strong,nonatomic)UIButton *baomingLabel;//报名
@property(strong,nonatomic)UIButton *coinLabel;//金币
@property(strong,nonatomic)UIButton *voucherLabel;//优惠券

@end
