//
//  DelegateExamineCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

//
@protocol DelegateExamineDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andActionTag:(NSInteger)tag;
@end


@interface DelegateExamineCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(assign,nonatomic)id<DelegateExamineDelegate>delegate;


@end
