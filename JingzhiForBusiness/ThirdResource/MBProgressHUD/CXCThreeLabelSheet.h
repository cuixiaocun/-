//
//  CXCThreeLabelSheet.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于按钮加减的实现
@protocol CXCThreeLabelSheetDelegate <NSObject>

-(void)btnClickName:(NSString *)nameString andPhone:(NSString *)phone andAdress:(NSString *)adress;
-(void)hiddenCXCActionSheet;
@end

@interface CXCThreeLabelSheet : UIView
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,retain)NSArray *leftArr;//@[@[@"",@""],@[@"",@""]];
@property(assign,nonatomic)id<CXCThreeLabelSheetDelegate>delegate;


- (id)initWithFrame:(CGRect)frame with:(NSArray *)arr;


@end
