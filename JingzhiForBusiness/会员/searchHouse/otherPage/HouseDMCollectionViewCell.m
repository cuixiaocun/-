//
//  HouseDMCollectionViewCell.m
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HouseDMCollectionViewCell.h"

@implementation HouseDMCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor whiteColor];
        self.topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,336*Width,225*Width)];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_topMCImage.bottom,336*Width,45*Width)];
        self.promtpmcLabel.textColor = TextColor;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"现代简约中式效果图-恒大路线";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
        self.pricesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_promtpmcLabel.bottom,336*Width,45*Width)];
        self.pricesLabel.textColor = TextGrayColor;
        self.pricesLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.pricesLabel.backgroundColor = [UIColor clearColor];
        _pricesLabel.text =@"山东桥通天下";
        [self.contentView addSubview:self.pricesLabel];
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [self.topMCImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"photo"]]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"title"]];
    self.pricesLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"company_name"]];
    
}


@end
