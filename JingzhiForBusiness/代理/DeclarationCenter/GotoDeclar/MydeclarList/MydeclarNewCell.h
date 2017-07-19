//
//  MydeclarNewCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加代理，用于点击事件
@protocol MydeclarDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andTag:(NSInteger)tag;
@end

@interface MydeclarNewCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,retain)NSDictionary *agenDic;
@property(strong,nonatomic)UIButton * rejectBtn;//取消
@property(strong,nonatomic)UIButton * seeBtn;//查看物流
@property(assign,nonatomic)id<MydeclarDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
