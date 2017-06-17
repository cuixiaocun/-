//
//  HYPersonalCenterVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于按钮加减的实现
@protocol HYPersonalCenterDelegate <NSObject>

-(void)setSelectedIndex:(NSUInteger)intage;
@end

@interface HYPersonalCenterVC : UIViewController
@property(assign,nonatomic)id<HYPersonalCenterDelegate>delegate;

@end
