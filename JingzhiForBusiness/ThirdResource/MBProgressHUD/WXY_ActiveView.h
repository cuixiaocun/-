//
//  WXY_ActiveView.h
//  AppBuilder
//
//  Created by wang rain on 12-3-1.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXY_ActiveView : UIView{
    UIImageView *animationView;
    NSString *middle_title;
    NSInteger middle_titleFont;
    UIColor *middle_titleColor;
}

@property(nonatomic,retain) UIImageView *animationView;
@property(nonatomic,retain) NSString *middle_title;
@property(nonatomic,assign) NSInteger middle_titleFont;
@property(nonatomic,retain) UIColor *middle_titleColor;

-(void)stopActiveView;
-(void)setMiddleTitleText:(NSString *)text andFontOfInteger:(NSInteger)i andColor:(UIColor *)color;

@end
