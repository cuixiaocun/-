//
//  MyOrderCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于查看物流，审核通过
@protocol MyOrderCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andActionTag:(NSInteger)tag;
@end


@interface MyOrderCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property(assign,nonatomic)id<MyOrderCellDelegate>delegate;

@end
