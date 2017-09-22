//
//  FindDesignerThreeCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FindDesignerThreeCell.h"

@implementation FindDesignerThreeCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
                //shang边文字
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(25*Width,10*Width,650*Width,100*Width)];
        _titleLabel.font =[UIFont systemFontOfSize:14];
        _titleLabel.text =@"住宅风水事项有哪些？";
        _titleLabel.textColor =BlackColor;
        _titleLabel.numberOfLines=0;
        [self addSubview:_titleLabel];
        
        //中间文字
        _numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(25*Width,_titleLabel.bottom+10*Width,400*Width,50*Width)];
        _numberLabel.font =[UIFont systemFontOfSize:13];
        _numberLabel.text =@"2015-09-01 11:11:15";
        _numberLabel.textColor =TextGrayColor;
        [self addSubview:_numberLabel];
        UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(0*Width,178.5*Width,CXCWidth,1.5*Width)];
        xianV.backgroundColor =BGColor;
        [self addSubview:xianV];
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    
    
}

@end
