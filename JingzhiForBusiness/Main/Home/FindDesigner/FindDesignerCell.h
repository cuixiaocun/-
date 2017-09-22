//
//  FindDesignerCell.h
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FindCesignerDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andBtnActionTag:(NSInteger)tag;
@end

@interface FindDesignerCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,strong)UIImageView *phoneImageV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *caseLabel;
@property(nonatomic,strong)UILabel *collegesLabel;
@property(nonatomic,strong)UILabel *ideaLabel;
@property(nonatomic,strong)UIButton *appointmentBtn;
@property(nonatomic,strong)UIImageView *xianImageV;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property(assign,nonatomic)id<FindCesignerDelegate>delegate;


@end
