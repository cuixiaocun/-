//
//  WebImgViewTwo.h
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBImageViewItem;
@interface WebImgViewTwo : UIView
//根据index索引值 获取对应的item
@property (nonatomic,copy) NSArray *dataList;

-(WBImageViewItem*)itemAtIndex:(NSInteger)index;

+(CGFloat) heightForCount:(int)count;

@end
