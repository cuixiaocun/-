//
//  ShopNewsListCell.h
//  家装
//
//  Created by Admin on 2017/11/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopNewsListCell : UITableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,retain)NSDictionary *dic;
@end
