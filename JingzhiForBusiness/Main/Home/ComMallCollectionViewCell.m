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
        
        
        self.backgroundColor =[UIColor redColor];
        self.topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(15*Width,15*Width,307.5*Width,220*Width)];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*Width,_topMCImage.bottom,307*Width,100*Width)];
        self.promtpmcLabel.textColor = [UIColor blackColor];
//        self.promtpmcLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"林氏木业地中海小户型布艺沙发组合美式乡村7字型蓝";
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

-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    self.topMCImage.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"img"]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    self.pricesLabel.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"price"]];



}
@end
