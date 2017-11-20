//
//  ToubiaoDetailGSCell.h
//  家装
//
//  Created by Admin on 2017/10/30.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToubiaoDetailGSCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,retain)NSDictionary *dic;
@property(strong,nonatomic)UILabel * timeLabel;//时间
@property(strong,nonatomic)UILabel * companyLabel;//公司
@property(strong,nonatomic)UILabel * lyLabel;//留言
@property(strong,nonatomic)UILabel * statusLabel;//状态

//@property(strong,nonatomic)UIButton * noBtn;//未签单
//@property(strong,nonatomic)UIButton * yesBtn;//已签单
@end
