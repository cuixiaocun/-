//
//  HYConfirmOrderCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYConfirmOrderCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;//详情页面的
@property(nonatomic,retain)NSDictionary *dicForGoods;//确认订单页面的;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)EGOImageView *goodsImgView;//图片
@property(strong,nonatomic)UILabel *goodsTitleLab;//商品名称
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *promptLabel;//提示信息
@end
