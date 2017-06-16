//
//  LogisticsCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLLabel/MLLabel.h>
#import <MLLabel/MLLinkLabel.h>
#import <MLLabel/NSString+MLExpression.h>
#import <MLLabel/NSAttributedString+MLExpression.h>
@interface LogisticsCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, strong) MLLinkLabel *rightLabel;


@end
