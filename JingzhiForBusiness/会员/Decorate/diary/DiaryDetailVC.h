//
//  DiaryDetailVC.h
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "STableViewController.h"
//#import "DemoTableHeaderView.h"
//#import "DemoTableFooterView.h"


@interface DiaryDetailVC :  UIViewController
{
    NSMutableArray *infoArray;  //存放列表数据
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
    
}
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)UILabel*styleLabel;
@property(nonatomic,strong)UILabel*junjiaLabel;
@property(nonatomic,strong)UILabel*contentLabel;
@property(nonatomic,strong)UILabel*nameLabel;
@property(nonatomic,strong)NSMutableDictionary*heightDic;

@property(nonatomic,strong)UIButton*seeBtn;
@property(nonatomic,strong)UIButton*talkBtn;

@property(nonatomic,strong)UILabel*priceLabel;
@property(nonatomic,strong)UILabel*isquanbaoLabel;
@property(nonatomic,strong)UILabel*kfsLabel;
@property(nonatomic,strong)UILabel*startLabel;
@property(nonatomic,strong)UILabel*endLabel;
@property(nonatomic,strong)UILabel*orangeLabel;
@property(nonatomic,retain)NSString*diary_id;

@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图

@end
