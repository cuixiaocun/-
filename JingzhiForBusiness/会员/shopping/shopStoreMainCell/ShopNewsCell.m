//
//  ShopNewsCell.m
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopNewsCell.h"

@implementation ShopNewsCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //shang边文字
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*Width,0*Width,600*Width,90*Width)];
        
        _titleLabel.font =[UIFont systemFontOfSize:14];
        _titleLabel.text =@"住宅风水事项有哪些？";
        _titleLabel.textColor =BlackColor;
        [self addSubview:_titleLabel];
        
        
        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(30*Width, _titleLabel.bottom, 300*Width, 80*Width)];
        _timeLabel.text =@"2017-09-08 11:12:12";
        _timeLabel.font =[UIFont systemFontOfSize:13];
        _timeLabel.textColor =TextGrayColor;
//        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:_timeLabel];
        UIImageView *xian =[[UIImageView alloc]init];
        [self addSubview:xian];
        xian.backgroundColor =BGColor;
        xian.frame =CGRectMake(0, 0, CXCWidth, 1.5*Width);
        
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    
    NSString *titleContent =[NSString stringWithFormat:@"%@",[_dic  objectForKey:@"title"]];
    _titleLabel.text = titleContent;
    _titleLabel.frame =CGRectMake(30*Width,0*Width,600*Width,90*Width);
    _timeLabel.text =[PublicMethod timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[_dic  objectForKey:@"dateline"]]];
    
}




@end
