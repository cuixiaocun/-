//
//  HomeOneCollectionViewCell.m
//  家装
//  Created by Admin on 2017/9/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HomeOneCollectionViewCell.h"

@implementation HomeOneCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor redColor];
        self.topMCImage = [[UIImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,220*Width,170*Width)];
        [_topMCImage sd_setImageWithURL:[NSURL URLWithString:@""]];
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_topMCImage.bottom,220*Width,50*Width)];
        self.promtpmcLabel.textColor = [UIColor blackColor];
        //        self.promtpmcLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [_topMCImage sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"title"]];
        
}

@end
