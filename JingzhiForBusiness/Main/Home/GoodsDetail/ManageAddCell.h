//
//  ManageAddCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于按钮加减的实现
@protocol ManageAddCellDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andTag:(int)tag;
@end

@interface ManageAddCell : UITableViewCell
{
    UILabel* nameLabe;
    UILabel* telphoneLabel;
    UILabel* addressLabel;
    UIImageView *isAddressImgV;



}
@property(strong,nonatomic)UIImageView *isSelectImg;//是否选中图片

@property(assign,nonatomic)id<ManageAddCellDelegate>delegate;
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
