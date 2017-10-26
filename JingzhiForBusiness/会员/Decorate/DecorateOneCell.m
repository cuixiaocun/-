//
//  DecorateOneCell.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateOneCell.h"

@implementation DecorateOneCell
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
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_topMCImage.bottom,336*Width,50*Width)];
        self.promtpmcLabel.textColor = TextColor;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"现代简约中式效果图-恒大路线";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_promtpmcLabel.bottom,336*Width,50*Width)];
        self.nameLabel.textColor = TextGrayColor;
        self.nameLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.text =@"山东桥通天下";
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [_topMCImage sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"photo"]]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"title"]];
    self.nameLabel.text =[NSString stringWithFormat:@"%@",[[[_dic objectForKey:@"ext"] objectForKey:@"company"] objectForKey:@"name"] ];
    
    
    
}


@end
