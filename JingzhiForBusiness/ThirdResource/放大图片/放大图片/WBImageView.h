//
//  WBImageView.h
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBImageViewItem;
@interface WBImageView : UIView


//数据
@property (nonatomic,copy) NSArray *dataList;

//根据index索引值 获取对应的item
-(WBImageViewItem*)itemAtIndex:(NSInteger)index;

+(CGFloat) heightForCount:(int)count;
@end
