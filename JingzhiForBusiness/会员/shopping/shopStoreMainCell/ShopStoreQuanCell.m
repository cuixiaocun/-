//
//  ShopStoreQuanCell.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopStoreQuanCell.h"

@implementation ShopStoreQuanCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        self.backgroundColor =[UIColor whiteColor];
        
        _bgImgView =[[UIImageView alloc]initWithFrame:CGRectMake(25*Width,0*Width, 750*Width, 360*Width)];
        _bgImgView.image =[UIImage imageNamed:@"mall_icon_quan"];
        [self addSubview:_bgImgView];
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, 20*Width, 560*Width, 250*Width)];
              _priceLab.text =@"¥159";
        _priceLab.textAlignment =NSTextAlignmentCenter  ;
        _priceLab.textColor = [UIColor whiteColor] ;
        _priceLab.font =[UIFont systemFontOfSize:40];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:_priceLab.text];
        // 需要改变的区间
        NSRange range = NSMakeRange(0, 1);
        // 改变字体大小及类型
        _priceLab.font =[UIFont fontWithName:@"Helvetica-Bold" size:100];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:40] range:range];
        // 为label添加Attributed
        [_priceLab setAttributedText:noteStr];

        [_bgImgView addSubview:_priceLab];
        
        _proImgView =[[UIImageView alloc]init];
        _proImgView.frame =CGRectMake(40*Width,_priceLab.bottom , 260*Width, 83*Width);
        [_bgImgView addSubview:_proImgView];

        _proImgView.image =[UIImage imageNamed:@"mall_icon_block"];
        
        _limitLab = [[UILabel alloc]initWithFrame:CGRectMake(40*Width,_priceLab.bottom , 260*Width, 83*Width)];
        _limitLab.text =@"满1200可用";
        _limitLab.textAlignment =NSTextAlignmentCenter  ;
        _limitLab.textColor = [UIColor whiteColor] ;
        _limitLab.font =[UIFont systemFontOfSize:14];
        [_bgImgView addSubview:_limitLab];
        
        
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
