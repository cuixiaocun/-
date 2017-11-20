//
//  YHQCell.h
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHQCell : UITableViewCell
@property(strong,nonatomic)UIImageView *bgImgView;//图片
@property(strong,nonatomic)UIImageView *proImgView;//图片
@property(strong,nonatomic)UILabel *priceLab;//具体价格
@property(strong,nonatomic)UILabel *limitLab;//限制条件
@property(nonatomic,retain)NSDictionary *dic;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
