//
//  DecorateFourCell.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateFourCell.h"

@implementation DecorateFourCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //上边图片
        _topMCImage=[[EGOImageView alloc]initWithFrame:CGRectMake(25*Width,30*Width,32*Width,32*Width)];
        _topMCImage.image =[UIImage imageNamed:@"zx_icon_resolved"];
        [self addSubview:_topMCImage];
    
        //shang边文字
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(_topMCImage.right+10*Width,30*Width,600*Width,32*Width)];
        _titleLabel.font =[UIFont systemFontOfSize:14];
        _titleLabel.text =@"住宅风水事项有哪些？";
        _titleLabel.textColor =BlackColor;
        [self addSubview:_titleLabel];
        
        //中间文字
        _numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(25*Width,_titleLabel.bottom+30*Width,400*Width,50*Width)];
        _numberLabel.font =[UIFont systemFontOfSize:13];
        _numberLabel.text =@"10个回答的";
        _numberLabel.textColor =BlackColor;
        [self addSubview:_numberLabel];
        UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(20*Width,183.5*Width,710*Width,1.5*Width)];
        xianV.backgroundColor =BGColor;
        [self addSubview:xianV];

        
    }
    return self;
}
- (void)myBtnAciton:(UIButton *)btn
{
    
    
}
-(void)setDic:(NSDictionary *)dic
{
    
}

@end
