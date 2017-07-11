//
//  AddBankCardVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于按钮加减的实现
@protocol AddBankDelegate <NSObject>
- (void)needReloadData;
@end

@interface AddBankCardVC : UIViewController
@property(nonatomic,strong)NSArray *bankArr;
@property(nonatomic,strong)NSDictionary *bankDetailDic;
@property(assign,nonatomic)id<AddBankDelegate>delegate;

@end
