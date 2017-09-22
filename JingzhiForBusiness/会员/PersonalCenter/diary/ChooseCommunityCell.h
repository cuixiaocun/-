//
//  ChooseCommunityCell.h
//  家装
//
//  Created by Admin on 2017/9/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCommunityCell : UITableViewCell
@property(strong,nonatomic)UILabel * communityLabel;//小区
@property(strong,nonatomic)UILabel * cityLabel;//城市
@property(strong,nonatomic)UILabel * countyLabel;//地区
@property(strong,nonatomic)UIButton *selectBtn ;//
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
