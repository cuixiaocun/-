//
//  YHQCell.m
//  家装
//
//  Created by Admin on 2017/11/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "YHQCell.h"

@implementation YHQCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    _priceLab.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"money"]];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:_priceLab.text];
    // 需要改变的区间
    NSRange range = NSMakeRange(0, 1);
    // 改变字体大小及类型
    _priceLab.font =[UIFont fontWithName:@"Helvetica-Bold" size:100];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:40] range:range];
    // 为label添加Attributed
    [_priceLab setAttributedText:noteStr];
    _limitLab.text =[NSString stringWithFormat:@"满%@可用",[_dic objectForKey:@"min_amount"]];
}


@end
