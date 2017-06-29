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

@interface LoginPage : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
}
@property(assign,nonatomic)id<LoginDelegate>delegate;
@property(strong,nonatomic)NSString * status;//页面
@property (nonatomic,strong) UITableView *nameTableView;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
