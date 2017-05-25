//
//  STImageVIew.h
//  STPhotoBroeser
//
//  Created by StriEver on 16/3/15.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STImageViewDelegate;
@interface STImageVIew : UIImageView
@property (nonatomic, weak)id<STImageViewDelegate>delegate;
- (void)resetView;
@end
@protocol STImageViewDelegate <NSObject>

- (void)stImageVIewSingleClick:(STImageVIew *)imageView;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com