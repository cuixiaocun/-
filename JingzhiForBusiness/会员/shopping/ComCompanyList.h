//
//  ComCompanyList.h
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

@interface ComCompanyList : STableViewController
{
    NSMutableArray *infoArray;
    NSInteger pageCount;   //总页数
}
@property(nonatomic,assign)NSString *btnNameString;


@end
