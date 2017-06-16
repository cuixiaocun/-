//
//  RebateCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RebateCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dicForOut;//出款

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)statu;//1代表未转账2代表已转账3代表以完成
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType2:(NSString *)statu;//1代表未转账2代表已转账3代表以完成


@end
