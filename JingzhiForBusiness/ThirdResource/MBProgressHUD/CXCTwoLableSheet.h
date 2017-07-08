//
//  CXCTwoLableSheet.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理
@protocol CXCTwoLableSheetDelegate <NSObject>

-(void)btnClickName:(NSString *)nameString andBankNumber:(NSString *)bankNum withid:(NSString *)idstring withIsDefult:(NSString *)isDefult;
-(void)hiddenCXCActionSheet;
@end


@interface CXCTwoLableSheet : UIView
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,retain)NSArray *leftArr;//@[@[@"",@""],@[@"",@""]];
@property(assign,nonatomic)id<CXCTwoLableSheetDelegate>delegate;


- (id)initWithFrame:(CGRect)frame with:(NSArray *)arr;

@end
