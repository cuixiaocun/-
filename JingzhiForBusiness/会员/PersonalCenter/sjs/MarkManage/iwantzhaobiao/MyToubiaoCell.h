//
//  MyToubiaoCell.h
//  家装
//
//  Created by Admin on 2017/10/31.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyToubiaoCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property(strong,nonatomic)UIButton * seeLogBtn;//查看物流

@end
