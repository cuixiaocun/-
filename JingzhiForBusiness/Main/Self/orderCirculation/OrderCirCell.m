//
//  OrderCirCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/7/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "OrderCirCell.h"

@implementation OrderCirCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 20*Width);
        
        NSArray*leftArr =@[@"申请代理",@"发起代理",@"流转代理",@"流转时间",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"",@"",@"",@"",@"",];
        for (int i=0; i<4; i++){
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            labe.text = leftArr[i];
            //            labe.textAlignment=NSTextAlignmentLeft;
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BlackColor;
            [bgview addSubview:rightLabel];
            //分割线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [bgview addSubview:xian];
            xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
            
        }
        
        
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)calculateTheGoods
{
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    //待审核，已完成，已驳回
    _dic=Dict;
    UILabel *numberLabel =[self viewWithTag:200];
    UILabel *upLabel =[self viewWithTag:201];
    UILabel *downLabel =[self viewWithTag:202];
    UILabel *timeLabel =[self viewWithTag:203];
    numberLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"source"]];
    upLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"before"]];
    downLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"after"]];
    timeLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"createtime"]];
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
