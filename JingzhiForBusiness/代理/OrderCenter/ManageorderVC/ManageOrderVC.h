//
//  ManageOrderVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"


@interface ManageOrderVC :STableViewController
{
    NSMutableArray *infoArray;  //存放列表数据
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
    
}
@property(nonatomic,copy)NSString *statusString;

@end
