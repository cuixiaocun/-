//
//  DeclarDetailVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，
@protocol DeclarDetailVCDelegate <NSObject>
- (void)needReload;
@end

@interface DeclarDetailVC : UIViewController
@property(nonatomic,copy)NSString *isHavePass;
@property(nonatomic,copy)NSString *ismy;//0代理报单，1下级报单
@property(nonatomic,copy)NSString *orderId;//
@property(assign,nonatomic)id<DeclarDetailVCDelegate>delegate;

@end
