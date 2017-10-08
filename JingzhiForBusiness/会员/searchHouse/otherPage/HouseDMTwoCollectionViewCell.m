//
//  HouseDMTwoCollectionViewCell.m
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HouseDMTwoCollectionViewCell.h"

@implementation HouseDMTwoCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor redColor];
        self.topMCImage = [[UIImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,340*Width,260*Width)];
        [_topMCImage sd_setImageWithURL:[NSURL URLWithString:@""]];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
       
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
   [self.topMCImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"photo"]]]];
    
}

@end
