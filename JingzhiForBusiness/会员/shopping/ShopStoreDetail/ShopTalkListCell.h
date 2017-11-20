//
//  ShopTalkListCell.h
//  家装
//
//  Created by Admin on 2017/11/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface ShopTalkListCell : UITableViewCell
{
    UIImageView *xian;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,retain)NSDictionary *dic;
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) StarView *starImgView;
@property (nonatomic,strong) UIImageView *xian;
@property (nonatomic,strong) UIView *bottomV;


@end
