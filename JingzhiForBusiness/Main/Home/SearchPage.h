//
//  SearchPage.h
//  Demo_simple
//
//  Created by Doron on 16/1/11.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "STableViewController.h"
#import "PublicMethod.h"
#import "STableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

@interface SearchPage : STableViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDataSource>{
    NSMutableArray *infoArray;  //存放列表数据
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
}


@end
