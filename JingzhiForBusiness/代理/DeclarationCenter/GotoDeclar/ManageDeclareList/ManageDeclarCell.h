//
//  ManageDeclarCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于按钮加减的实现
@protocol ManagerDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
@end

@interface ManageDeclarCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(assign,nonatomic)id<ManagerDelegate>delegate;


@end
