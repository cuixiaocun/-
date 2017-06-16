//
//  GoOrderCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于下单
@protocol goOrderCellDelegate <NSObject>

-(void)goOrderBtnClick:(UITableViewCell *)cell andActionTag:(NSInteger)tag;
@end

@interface GoOrderCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,retain)NSDictionary *dic;

@property(assign,nonatomic)id<goOrderCellDelegate>delegate;
@property(strong,nonatomic)UILabel *goodsTitleLab;//商品名称
@property(strong,nonatomic)UILabel *numTitleLab;//箱盒
@property(strong,nonatomic)UILabel *numCountLab;//购买商品的数量
@property(strong,nonatomic)UIButton *addBtn;//添加商品数量
@property(strong,nonatomic)UIButton *deleteBtn;//删除商品数量
@end
