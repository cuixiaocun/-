//
//  ShopStoreShowCell.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopStoreShowCell.h"

@implementation ShopStoreShowCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor =[UIColor whiteColor];
        
        _bgImgView =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width,0*Width, 340*Width, 250*Width)];
        _bgImgView.image =[UIImage imageNamed:@""];
        [self addSubview:_bgImgView];
        _bgImgView.backgroundColor =BGColor ;
        
        
        
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel *detailLabel =[self viewWithTag:100];
    UILabel *pricesLabel =[self viewWithTag:101];
    UILabel *surplusLabel =[self viewWithTag:103];
    UILabel *timeLabel =[self viewWithTag:102];
    //如果为负的变为绿色
    detailLabel.text =[NSString stringWithFormat:@"%@",[Dict objectForKey:@"info"] ];
    surplusLabel.text =[NSString stringWithFormat:@"%@",[Dict objectForKey:@"stname"] ];
    timeLabel.text =[[NSString stringWithFormat:@"%@",[Dict objectForKey:@"createtime"] ] substringToIndex:11];
    
    if ([[NSString stringWithFormat:@"%@",[Dict objectForKey:@"type"] ]isEqualToString:@"2"]) {
        pricesLabel.textColor =[UIColor colorWithRed:2/255.0 green:196/255.0 blue:66/255.0 alpha:1];
        pricesLabel.text =[NSString stringWithFormat:@"-%@",[Dict objectForKey:@"changemoney"] ];
    }else  if ([[NSString stringWithFormat:@"%@",[Dict objectForKey:@"type"] ]isEqualToString:@"1"])
    {
        pricesLabel.textColor =[UIColor colorWithRed:242/255.0 green:55/255.0 blue:59/255.0 alpha:1];
        pricesLabel.text =[NSString stringWithFormat:@"%@",[Dict objectForKey:@"changemoney"] ];
    }else
    {
        pricesLabel.text =[NSString stringWithFormat:@"%@",[Dict objectForKey:@"changemoney"] ];
    }
    
}


@end
