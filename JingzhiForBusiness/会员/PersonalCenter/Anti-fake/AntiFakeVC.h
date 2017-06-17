//
//  Anti-fakeVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/17.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AntiFakeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
}
@property(nonatomic,retain)NSDictionary *dic;

@end
