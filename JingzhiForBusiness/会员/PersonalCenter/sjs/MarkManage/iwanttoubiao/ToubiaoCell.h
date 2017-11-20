//
//  ToubiaoCell.h
//  家装
//
//  Created by Admin on 2017/10/30.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToubiaoCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)UILabel * timeLabel;//时间
@property(strong,nonatomic)UILabel * countLabel;//内容
@property(strong,nonatomic)UILabel * payLabel;//消耗金币
@property(strong,nonatomic)UILabel * numberLabel;//企业数

@end
