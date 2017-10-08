//
//  ComCompanyCell.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ComCompanyCell.h"

@implementation ComCompanyCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor =[UIColor whiteColor];
        
        //图片
        _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
        _phoneImageV.backgroundColor =BGColor;
        _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 190*Width, 190*Width);
        [self addSubview:_phoneImageV];
        _promptLabel= [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+30*Width, 25*Width, 110*Width, 40*Width)];
        _promptLabel.text =@"普通商家";
        _promptLabel.textAlignment =NSTextAlignmentCenter  ;
        _promptLabel.backgroundColor =[UIColor colorWithRed:230/255.00 green:76/255.00 blue:42/255.00 alpha:1];
        _promptLabel.layer.cornerRadius=1;
        _promptLabel.layer.masksToBounds = YES;
        _promptLabel.textColor = [UIColor whiteColor] ;
        _promptLabel.font =[UIFont systemFontOfSize:11];
        [self addSubview:_promptLabel];

        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_promptLabel.right+24*Width,_promptLabel.top, 460*Width, 40*Width)];
        _nameLabel.text = @"北京科学方法天华专营店";
        _nameLabel.textColor=TextColor;
        _nameLabel.numberOfLines =0;
        _nameLabel.font =[UIFont systemFontOfSize:13];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        
        //地址
        _phoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+30*Width, _nameLabel.bottom,430*Width, 100*Width)];
        _phoneLabel.numberOfLines =0;
        _phoneLabel.text =@"联系电话：0948-8393134";
        _phoneLabel.font =[UIFont systemFontOfSize:12];
        _phoneLabel.textColor =TextColor;
        [self addSubview:_phoneLabel];
        
        //信誉指数
        _xyzsLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+30*Width, _phoneLabel.bottom, 180*Width, 60*Width)];
        _xyzsLabel.text =@"信誉指数:300";
        _xyzsLabel.font =[UIFont systemFontOfSize:12];
        _xyzsLabel.textColor =TextGrayColor;
        [self addSubview:_xyzsLabel];
        //面积
        _spslLabel =[[UILabel alloc]initWithFrame:CGRectMake(_xyzsLabel.right, _phoneLabel.bottom, 180*Width, 60*Width)];
        _spslLabel.text =@"共有商品:20";
        _spslLabel.font =[UIFont systemFontOfSize:12];
        _spslLabel.textColor =TextGrayColor;
        [self addSubview:_spslLabel];
        //面积
        _lllLabel =[[UILabel alloc]initWithFrame:CGRectMake(_spslLabel.right, _phoneLabel.bottom,180*Width, 60*Width)];
        _lllLabel.text =@"浏览量:73";
        _lllLabel.font =[UIFont systemFontOfSize:12];
        _lllLabel.textColor =TextGrayColor;
        [self addSubview:_lllLabel];
        //线
        _xianImageV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width,250*Width-1.5*Width, 690*Width, 1.5*Width)];
        _xianImageV.backgroundColor =BGColor;
        [self addSubview:_xianImageV];
        
        
        
    }
    return self;
}
@end
