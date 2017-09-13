//
//  DiaryDetailTableViewCell.h
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLLabel/MLLabel.h>
#import <MLLabel/MLLinkLabel.h>
#import <MLLabel/NSString+MLExpression.h>
#import <MLLabel/NSAttributedString+MLExpression.h>
#import "WBImageView.h"

@interface DiaryDetailTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, strong) MLLinkLabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) WBImageView *webImage;
@property(nonatomic,retain)NSDictionary *dic;

@end
