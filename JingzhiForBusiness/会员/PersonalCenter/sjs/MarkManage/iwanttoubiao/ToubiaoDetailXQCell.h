//
//  ToubiaoDetailXQCell.h
//  家装
//
//  Created by Admin on 2017/10/30.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToubiaoDetailXQCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)UILabel * timeLabel;//时间
@property(strong,nonatomic)UILabel * biaoStatusLabel;//标题

@property(strong,nonatomic)UILabel * titleLabel;//标题
@property(strong,nonatomic)UILabel * hyLabel;//会员
@property(strong,nonatomic)UILabel * zxTimeLabel;//装修时间
@property(strong,nonatomic)UILabel * countLabel;//售价
@property(strong,nonatomic)UILabel * largeNumberLabel;//最大投标数
@property(strong,nonatomic)UILabel * yiNumberLabel;//已投数
@property(strong,nonatomic)UILabel * addressLabel;//地址
@property(strong,nonatomic)UILabel * phoneLabel;//电话
@property(strong,nonatomic)UILabel * communityLabel;//小区
@property(strong,nonatomic)UILabel * areaLabel;//房屋面积
@property(strong,nonatomic)UILabel * typeLabel;//招标类型
@property(strong,nonatomic)UILabel * styleLabel;//喜欢风格
@property(strong,nonatomic)UILabel * yusuanLabel;//预算范围
@property(strong,nonatomic)UILabel * xuqiuLabel;//服务需求
@property(strong,nonatomic)UILabel * huxingLabel;//空间户型
@property(strong,nonatomic)UILabel * zxfsLabel;//装修方式
@property(strong,nonatomic)UILabel * beizhuLabel;//备注
@property(strong,nonatomic)UIViewController * viewC;//备注

@end
