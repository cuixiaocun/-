//
//  BankCardListVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/8.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardListVC : UIViewController
{
    NSMutableArray *infoArray;  //存放列表数据
}
@property(nonatomic,strong)UITableView *tableView;
@end
