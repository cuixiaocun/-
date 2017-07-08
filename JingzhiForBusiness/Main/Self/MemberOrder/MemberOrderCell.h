//
//  MemberOrderCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MemberOrderCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andTag:(int)tag;
@end

@interface MemberOrderCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)UIButton * seeBtn;//查看详情
@property(strong,nonatomic)UIButton * deliverBtn;//发货
@property(strong,nonatomic)UIButton * rejectBtn;//查看详情
@property(strong,nonatomic)UIButton * loginDetailBtn;//查看物流详情


@property(assign,nonatomic)id<MemberOrderCellDelegate>delegate;

@end
