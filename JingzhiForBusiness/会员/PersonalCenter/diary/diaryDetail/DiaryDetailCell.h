//
//  DiaryDetailCell.h
//  家装
//
//  Created by Admin on 2017/9/18.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于点击事件
@protocol DiaryDetialDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andBtnActionTag:(NSInteger)tag;
@end

@interface DiaryDetailCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)UIButton * changeBtn;//change
@property(strong,nonatomic)UIButton * deleteBtn;//delete

@property(assign,nonatomic)id<DiaryDetialDelegate>delegate;


@end
