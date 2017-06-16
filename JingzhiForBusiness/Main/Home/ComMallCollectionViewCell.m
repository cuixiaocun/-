//
//  ComMallCollectionViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallCollectionViewCell.h"

@implementation ComMallCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor whiteColor];
        self.topMCImage = [[UIImageView alloc] initWithFrame:CGRectMake(15*Width,15*Width,307.5*Width,225*Width)];
        self.topMCImage.backgroundColor = [UIColor redColor];
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*Width,_topMCImage.bottom,307*Width,100*Width)];
        self.promtpmcLabel.textColor = [UIColor blackColor];
        self.promtpmcLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"温碧泉里头白真凝润四件套（护肤）";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
        self.pricesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*Width,_promtpmcLabel.bottom,307*Width,50*Width)];
        self.pricesLabel.textColor = NavColor;
//        self.pricesLabel.textAlignment = NSTextAlignmentCenter;
        self.pricesLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.pricesLabel.backgroundColor = [UIColor clearColor];
        _pricesLabel.text =@"¥500.00";
        [self.contentView addSubview:self.pricesLabel];

    }
    return self;
}

@end
