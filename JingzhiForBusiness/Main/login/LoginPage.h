//
//  LoginPage.h
//  Demo_simple
//
//  Created by Eleven on 15/4/19.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicMethod.h"
//添加代理，用于按钮加减的实现
@protocol LoginDelegate <NSObject>

-(void)backBecauseBackNarrow;// 当是返回按钮
@end

@interface LoginPage : UIViewController<UITextFieldDelegate>
{
}
@property(assign,nonatomic)id<LoginDelegate>delegate;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
