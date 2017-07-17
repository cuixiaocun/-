//
//  FundRecordCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FundRecordCell.h"

@implementation FundRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0*Width, 480*Width, 80*Width)];
        detailLabel.text =@"";
        detailLabel.textColor = TextColor ;
        detailLabel.font =[UIFont systemFontOfSize:15];
        [self addSubview:detailLabel];
        detailLabel.tag =100;

        UILabel *pricesLabel =[[UILabel alloc]initWithFrame:CGRectMake(400*Width, 0,310*Width , 80*Width)];
        pricesLabel.text =@"100";
        pricesLabel.textAlignment =NSTextAlignmentRight;

        pricesLabel.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        pricesLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview:pricesLabel];
        pricesLabel.tag =101;

        
        UILabel *timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, pricesLabel.bottom, 400*Width, 80*Width)];
        timeLabel.text =@"2017-04-03 12:12:12";
        timeLabel.font =[UIFont systemFontOfSize:14];
        timeLabel.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [self addSubview:timeLabel];
        timeLabel.tag =102;
        UILabel *surplusLabel = [[UILabel alloc]initWithFrame:CGRectMake(400*Width, pricesLabel.bottom, 310*Width, 80*Width)];
        surplusLabel.text =@"获得积分";
        surplusLabel.textAlignment =NSTextAlignmentRight;
        surplusLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] ;
        surplusLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview:surplusLabel];
        surplusLabel.tag =103;
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0*Width,158.5*Width, CXCWidth, 1.5*Width);
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
    
    // Configure the view for the selected state
}

@end
