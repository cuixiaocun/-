//
//  HYMyRecommendVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMyRecommendCell.h"
#import "STableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

@interface HYMyRecommendVC :STableViewController
{
    NSMutableArray *infoArray;  //存放列表数据
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
}

@end
