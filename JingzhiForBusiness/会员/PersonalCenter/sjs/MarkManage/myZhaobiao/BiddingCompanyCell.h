//
//  BiddingCompanyCell.h
//  家装
//
//  Created by Admin on 2017/9/28.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLLinkLabel.h"
@protocol BiddingCellDelegate <NSObject>
-(void)setBiddingCompanyCell:(UITableViewCell *)cell andTag:(NSInteger)tag;
@end

@interface BiddingCompanyCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(assign,nonatomic)id<BiddingCellDelegate>delegate;
@property(strong,nonatomic)UIButton * seeLogBtn;//设为中标
@property (nonatomic, strong) MLLinkLabel *contentLabel;

@end
