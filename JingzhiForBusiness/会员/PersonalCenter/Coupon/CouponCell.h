//
//  CouponCell.h
//  家装
//
//  Created by Admin on 2017/9/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell
@property(strong,nonatomic)UIImageView *bgImgView;//图片
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *limitLab;//限制条件
@property(strong,nonatomic)UILabel *promptLabel;//红色信息
@property(strong,nonatomic)UILabel *titleLabel;//标题
@property(strong,nonatomic)UILabel *codeLabel;//优惠码
@property(strong,nonatomic)UILabel *timeLabel;//时间
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
