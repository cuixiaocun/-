//
//  RabatForInCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RabatInfoDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andInTag:(int)flag;
@end

@interface RabatForInCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dicForIn;//进款
@property(assign,nonatomic)id<RabatInfoDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType2:(NSString *)statu;//
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)statu;//1代表未转账2代表已转账3代表以完成


@end
