//
//  DecorateTwoCell.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateTwoCell.h"

@implementation DecorateTwoCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor redColor];
        self.topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,336*Width,250*Width)];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_topMCImage.bottom,336*Width,70*Width)];
        self.promtpmcLabel.textColor = TextColor;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"现代简约中式效果图-恒大路线";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    self.topMCImage.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"img"]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    
    
    
}

@end
