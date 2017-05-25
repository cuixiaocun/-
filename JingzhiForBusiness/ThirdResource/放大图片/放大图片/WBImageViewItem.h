//
//  WBImageViewItem.h
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBImageView.h"
@interface WBImageViewItem : EGOImageView

@property (nonatomic,copy) NSArray *dataList;

@property (assign) NSInteger index;

//在WBImageView上的原有的Frame
@property (assign) CGRect originFrame;
//保存原有的superview （WBImageView）
@property (nonatomic,weak) WBImageView *originSuperView;

-(CGRect)getNewFrameAtWindow:(CGRect)originFrame;


@end
