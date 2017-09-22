//
//  ActivityCell.h
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andBtnActionTag:(NSInteger)tag;
@end
@interface ActivityCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,strong)UIImageView *photoImageV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *appiontLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UIButton *appointmentBtn;
@property(nonatomic,strong)UIImageView *xianImageV;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UIImageView *xian;
@property(assign,nonatomic)id<ActivityDelegate>delegate;


@end
