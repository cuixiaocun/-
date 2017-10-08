//
//  CouponCell.m
//  家装
//
//  Created by Admin on 2017/9/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        
        _bgImgView =[[UIImageView alloc]initWithFrame:CGRectMake(25*Width,0*Width, 700*Width, 210*Width)];
        _bgImgView.image =[UIImage imageNamed:@"yhq_bg_ky"];
        [self addSubview:_bgImgView];
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 20*Width, 250*Width, 120*Width)];
        _priceLab.text =@"¥100";
        _priceLab.textAlignment =NSTextAlignmentCenter  ;
        _priceLab.textColor = [UIColor whiteColor] ;
        _priceLab.font =[UIFont systemFontOfSize:40];
        [_bgImgView addSubview:_priceLab];
        
        _limitLab = [[UILabel alloc]initWithFrame:CGRectMake(40*Width,_priceLab.bottom , 200*Width, 60*Width)];
        _limitLab.text =@"满199可用";
        _limitLab.textAlignment =NSTextAlignmentCenter  ;
        _limitLab.textColor = [UIColor whiteColor] ;
        _limitLab.font =[UIFont systemFontOfSize:14];
        [_bgImgView addSubview:_limitLab];
        
        _promptLabel= [[UILabel alloc]initWithFrame:CGRectMake(285*Width, 15*Width, 110*Width, 50*Width)];
        _promptLabel.text =@"新春优惠";
        _promptLabel.textAlignment =NSTextAlignmentCenter  ;
        _promptLabel.backgroundColor =[UIColor colorWithRed:230/255.00 green:76/255.00 blue:42/255.00 alpha:1];
        _promptLabel.layer.cornerRadius=1;
        _promptLabel.layer.masksToBounds = YES;
        _promptLabel.textColor = [UIColor whiteColor] ;
        _promptLabel.font =[UIFont systemFontOfSize:11];
        [_bgImgView addSubview:_promptLabel];

        _titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(405*Width, 0*Width, 300*Width,80*Width)];
        _titleLabel.text =@"限购【佳乐家二楼佳木斯家居总销售】新春优惠券";
        _titleLabel.textColor = [UIColor blackColor] ;
        _titleLabel.numberOfLines =0;
        _titleLabel.font =[UIFont systemFontOfSize:14];
        [_bgImgView addSubview:_titleLabel];
        
        _codeLabel= [[UILabel alloc]initWithFrame:CGRectMake(285*Width, _titleLabel.bottom, 400*Width, 70*Width)];
        _codeLabel.text =@"优惠码：00000001";
        _codeLabel.textColor = TextColor ;
        _codeLabel.font =[UIFont systemFontOfSize:14];
        [_bgImgView addSubview:_codeLabel];

        _timeLabel= [[UILabel alloc]initWithFrame:CGRectMake(285*Width, _codeLabel.bottom, 400*Width, 60*Width)];
        _timeLabel.text =@"20170930-20190909";
        _timeLabel.textColor = TextGrayColor ;
        _timeLabel.font =[UIFont systemFontOfSize:14];
        [_bgImgView addSubview:_timeLabel];
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
