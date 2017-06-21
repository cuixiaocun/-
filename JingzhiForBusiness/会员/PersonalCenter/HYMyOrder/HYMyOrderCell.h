//
//  HYMyOrderCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于点击事件
@protocol HYOrderCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andBtnActionTag:(NSInteger)tag;
@end

@interface HYMyOrderCell : UITableViewCell
@property(strong,nonatomic)EGOImageView *goodsImgView;//图片
@property(strong,nonatomic)UILabel *goodsTitleLab;//商品名称
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *promptLabel;//提示信息
@property(strong,nonatomic)UILabel *allPricesLabel;//提示信息
@property(strong,nonatomic)UIButton * seeBtn;//查看详情
@property(strong,nonatomic)UIButton * deliverBtn;//发货
@property(strong,nonatomic)UIButton * rejectBtn;//查看详情
@property(strong,nonatomic)UIButton * seeLogBtn;//查看物流
@property(strong,nonatomic)UIButton * tureBtn;//确认收货
@property(nonatomic,copy)NSString *status;

@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(assign,nonatomic)id<HYOrderCellDelegate>delegate;


@end
