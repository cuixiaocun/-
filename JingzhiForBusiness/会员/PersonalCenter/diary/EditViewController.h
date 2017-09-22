//
//  EditViewController.h
//  qunfa
//
//  Created by Admin on 2017/8/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理
@protocol EditDelegate <NSObject>
- (void)needReloadDataEdit;
@end

@interface EditViewController : UIViewController
@property(nonatomic,strong)NSDictionary *dic;
@property(assign,nonatomic)id<EditDelegate>delegate;
@property(nonatomic,assign)NSString *navString;


@end
