//
//  IsTureAlterView.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IsTureAlterViewDelegate <NSObject>
-(void)tureBtnAction;
-(void)cancelBtnActin;

@end

@interface IsTureAlterView : UIView
@property(nonatomic,strong) UIView* blackBgView;//输入框背景透明黑
@property(nonatomic,strong) UIView *alterView;//弹出输入框
- (instancetype)initWithTitile:(NSString*)titileString;

@property(assign,nonatomic)id<IsTureAlterViewDelegate>delegate;

@end
