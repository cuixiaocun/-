//
//  ChooseCompanyCell.m
//  家装
//
//  Created by Admin on 2017/9/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ChooseCompanyCell.h"

@implementation ChooseCompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 140*Width)];
        bgView.backgroundColor =[UIColor whiteColor];
        [self addSubview:bgView];
        
        _selectBtn =[[UIButton alloc]initWithFrame:CGRectMake(20*Width, 30*Width, 80*Width, 80*Width)];
        //        [_selectBtn setImageEdgeInsets:UIEdgeInsetsMake(24*Width, 24*Width, 24*Width, 24*Width)];
        [_selectBtn setImage:[UIImage imageNamed:@"me_radio_nor"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"me_radio_sel"] forState:UIControlStateSelected];
        [bgView addSubview:_selectBtn];
        UIImageView *img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_icon_line"]];
        [bgView addSubview:img];
        img.frame =CGRectMake(115*Width, 20*Width, 6*Width, 100*Width);
        
        
        NSArray*topArr =@[@"北京绿缘居装饰",@"北京",@"海淀区"];
        NSArray*bottomArr =@[@"小区",@"城市",@"地区"];
        
        for (int i=0; i<3; i++) {
            UILabel* _promptLabel= [[UILabel alloc]initWithFrame:CGRectMake(160*Width, 20*Width, 250*Width, 50*Width)];
            _promptLabel.text =@"北京绿缘居装饰";
            _promptLabel.textAlignment =NSTextAlignmentCenter  ;
            _promptLabel.text =[NSString stringWithFormat:@"%@",topArr[i]];
            _promptLabel.textColor = TextColor ;
            _promptLabel.font =[UIFont systemFontOfSize:14];
            [bgView addSubview:_promptLabel];
            
            UILabel* _limitLab = [[UILabel alloc]initWithFrame:CGRectMake(40*Width,_promptLabel.bottom , 200*Width, 60*Width)];
            _limitLab.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
            _limitLab.textAlignment =NSTextAlignmentCenter  ;
            _limitLab.textColor =TextGrayColor ;
            _limitLab.font =[UIFont systemFontOfSize:11];
            [bgView addSubview:_limitLab];
            
            if (i==0) {
                _communityLabel=_promptLabel;
                _communityLabel.frame =CGRectMake(160*Width, 20*Width, 250*Width, 50*Width);
                _limitLab.frame =CGRectMake(160*Width, _communityLabel.bottom, 250*Width, 50*Width);
                
            }else if (i==1)
            {
                _cityLabel=_promptLabel;
                _cityLabel.frame =CGRectMake(_communityLabel.right+20*Width, 20*Width, 170*Width, 50*Width);
                _limitLab.frame =CGRectMake(_communityLabel.right+20*Width, _cityLabel.bottom, 170*Width, 50*Width);
            }else if (i==2)
            {
                _countyLabel=_promptLabel;
                _countyLabel.frame =CGRectMake(_cityLabel.right, 20*Width, 170*Width, 50*Width);
                _limitLab.frame =CGRectMake(_cityLabel.right, _countyLabel.bottom, 170*Width, 50*Width);
            }
            
            
        }
        
        
        
        
        
        
        
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
