//
//  PostHeaderCell.h
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLLabel/MLLabel.h>
#import <MLLabel/MLLinkLabel.h>
#import <MLLabel/NSString+MLExpression.h>
#import <MLLabel/NSAttributedString+MLExpression.h>
#import "WebImgViewTwo.h"

@interface PostHeaderCell : UITableViewCell
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic, strong) MLLinkLabel *contentLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *xian;
@property (nonatomic, strong) WebImgViewTwo *webImage;
@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UILabel *seeLabel;
@property (nonatomic,strong) UILabel *talkLabel;
@property (nonatomic,strong) UIView *bottomView;

@property(nonatomic,retain)NSDictionary *dic;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
    

@end
