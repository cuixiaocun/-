//
//  TenderCell.h
//  家装
//
//  Created by Admin on 2017/9/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TenderCell;
@protocol TenderCellDelegate <NSObject>
- (void)LookManage:(TenderCell *)cell;
@end

@interface TenderCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (weak, nonatomic) id<TenderCellDelegate>delegate;

@property(strong,nonatomic)UIButton * seeLogBtn;//查看物流

@end
