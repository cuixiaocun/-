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
        UILabel *pricesLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 20*Width, 300*Width, 40*Width)];
        pricesLabel.text =@"100";
        pricesLabel.textColor =[UIColor colorWithRed:242/255.0 green:55/255.0 blue:59/255.0 alpha:1];
        pricesLabel.font =[UIFont systemFontOfSize:16];
        [self addSubview:pricesLabel];
        pricesLabel.tag =100;
        
        UILabel *surplusLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, pricesLabel.bottom, 400*Width, 80*Width)];
        surplusLabel.text =@"剩余资金:3000";
        surplusLabel.textColor = TextColor ;
        surplusLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview:surplusLabel];
        surplusLabel.tag =101;

        
        UILabel *timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(400*Width, 0,310*Width , 80*Width)];
        timeLabel.text =@"2017-04-03 12:12:12";
        timeLabel.textAlignment =NSTextAlignmentRight;
        timeLabel.font =[UIFont systemFontOfSize:13];
        timeLabel.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [self addSubview:timeLabel];
        timeLabel.tag =102;

        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0*Width,138.5*Width, CXCWidth, 1.5*Width);
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
    UILabel *pricesLabel =[self viewWithTag:100];
    UILabel *surplusLabel =[self viewWithTag:101];
    UILabel *timeLabel =[self viewWithTag:102];
    //如果为负的变为绿色
    pricesLabel.textColor =[UIColor colorWithRed:2/255.0 green:196/255.0 blue:66/255.0 alpha:1];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
