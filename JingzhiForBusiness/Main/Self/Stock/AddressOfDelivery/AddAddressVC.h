//
//  AddAddressVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于按钮加减的实现
@protocol AddAddressDelegate <NSObject>
- (void)needReloadDataAddress;
@end

@interface AddAddressVC : UIViewController
@property(nonatomic,retain)NSDictionary *dic;
@property(assign,nonatomic)id<AddAddressDelegate>delegate;


@end
