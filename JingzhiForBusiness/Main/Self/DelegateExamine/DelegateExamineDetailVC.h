//
//  DelegateExamineDetailVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AgenExmineDelegate <NSObject>
- (void)reloadTheinformation;
@end
@interface DelegateExamineDetailVC : UIViewController
@property(nonatomic,strong)NSDictionary *angeDic;
@property(assign,nonatomic)id<AgenExmineDelegate>delegate;

@end
