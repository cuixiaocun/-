//
//  HomeOneCollectionViewCell.m
//  家装
//
//  Created by Admin on 2017/9/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HomeOneCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeOneCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor redColor];
        self.topMCImage = [[UIImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,220*Width,170*Width)];
        [_topMCImage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504784758317&di=909f8f5abe4ccdaf94d88b4119a8e8b2&imgtype=0&src=http%3A%2F%2Fpic72.nipic.com%2Ffile%2F20150716%2F21422793_145446329000_2.jpg"]];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_topMCImage.bottom,220*Width,50*Width)];
        self.promtpmcLabel.textColor = [UIColor blackColor];
        //        self.promtpmcLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"歌尔绿城";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
//    self.topMCImage.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"img"]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    self.pricesLabel.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"price"]];
    
    
    
}

@end
