//
//  ManageOrderCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于下单
@protocol ManagerOrderCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andActionTag:(NSInteger)tag;
@end


@interface ManageOrderCell :  UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property(assign,nonatomic)id<ManagerOrderCellDelegate>delegate;


@end
