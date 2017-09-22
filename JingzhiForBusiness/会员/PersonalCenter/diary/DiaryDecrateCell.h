//
//  DiaryDecrateCell.h
//  家装
//
//  Created by Admin on 2017/9/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于点击事件
@protocol DiaryDecrateDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andBtnActionTag:(NSInteger)tag;
@end

@interface DiaryDecrateCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)UIButton * changeBtn;//change
@property(strong,nonatomic)UIButton * deleteBtn;//delete
@property(strong,nonatomic)UIButton * seeBtn;//查看详情
@property(strong,nonatomic)UIButton * addBtn;//查看物流
@property(strong,nonatomic)UIButton * tureBtn;//确认收货
@property(assign,nonatomic)id<DiaryDecrateDelegate>delegate;


@end
