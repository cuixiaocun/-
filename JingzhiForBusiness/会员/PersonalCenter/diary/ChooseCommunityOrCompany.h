//
//  ChooseCommunityOrCompany.h
//  家装
//
//  Created by Admin on 2017/9/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"
@protocol ChooseDelegate <NSObject>

-(void)cellActionCommunityName:(NSString *)communityName withId:(NSString*)nameId andIscompanyOrcommunity:(NSString*)companyOrcommunity;
-(void)cellActionCompanyName:(NSString *)companyName withId:(NSString*)nameId andIscompanyOrcommunity:(NSString*)companyOrcommunity;

@end


@interface ChooseCommunityOrCompany :  STableViewController
{
    NSMutableArray *infoArray;  //存放列表数据
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
}
@property(nonatomic,retain)NSString *communityOrCompany;
@property(assign,nonatomic)id<ChooseDelegate>delegate;

@end
