//
//  WithDrawDetail.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WithdrawMoneyDelegate <NSObject>
- (void)needReloadDataWithdrawMoney;
@end

@interface WithDrawDetail : UIViewController
@property(assign,nonatomic)id<WithdrawMoneyDelegate>delegate;

@end
