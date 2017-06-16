//
//  BankCardCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/8.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BankCardCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andTag:(int)tag;
@end


@interface BankCardCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(assign,nonatomic)id<BankCardCellDelegate>delegate;

@end
