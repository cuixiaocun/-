//
//  DiaryCell.h
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *promtpmcLabel;
@property (nonatomic,strong) UILabel *styleLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *orangeLabel;
@property (nonatomic,strong) UILabel *decorateLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,retain)NSDictionary *dic;


@end
