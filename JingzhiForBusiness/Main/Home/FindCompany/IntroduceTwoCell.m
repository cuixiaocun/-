//
//  IntroduceTwoCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "IntroduceTwoCell.h"

@implementation IntroduceTwoCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView*  topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,220*Width,165*Width)];
        topMCImage.backgroundColor = BGColor;
        
        [self.contentView addSubview:topMCImage];    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    
    
}

@end
