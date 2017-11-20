//
//  ComcompanyTableviewCell.h
//  家装
//
//  Created by Admin on 2017/11/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComcompanyTableviewCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *phoneImageV;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *xyzsLabel;
@property(nonatomic,strong)UILabel *spslLabel;
@property(nonatomic,strong)UILabel *lllLabel;//浏览量

@property(nonatomic,strong)UIImageView *xianImageV;
@property(strong,nonatomic)UILabel *promptLabel;//红色信息
@end
