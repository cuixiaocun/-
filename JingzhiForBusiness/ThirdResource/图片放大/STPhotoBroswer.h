//
//  STPhotoBroswer.h
//  STPhotoBroeser
//
//  Created by StriEver on 16/3/16.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPhotoBroswer : UIView
/**
 * @brief 初始化方法  图片以数组的形式传入, 需要显示的当前图片的索引
 *
 * @param  imageArray需要显示的图片以数组的形式传入.
 * @param  index 需要显示的当前图片的索引
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index;
- (void)show;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com