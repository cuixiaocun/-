//
//  GoodsAndNumCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/9.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoodsAndNumCell.h"

@implementation GoodsAndNumCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView  *bgview =[[UIView alloc]initWithFrame:CGRectMake(0*Width, 0,CXCWidth , 80*Width)];
        [self addSubview:bgview];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        //商品名称
        UILabel* leftTopLabe = [[UILabel alloc]init];
        leftTopLabe.font = [UIFont systemFontOfSize:14];
        leftTopLabe.text = @"商品q";
        leftTopLabe.frame= CGRectMake(24*Width, 0,300*Width , 80*Width);
        leftTopLabe.tag =230;
        //        leftTopLabe.backgroundColor =BGColor;
        leftTopLabe.textColor = TextGrayColor;
        [bgview addSubview:leftTopLabe];
        //数量
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text =@"100盒";
        rightLabel.frame =CGRectMake(250*Width ,0,475*Width,80*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =240;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = TextGrayGrayColor;
        [bgview addSubview:rightLabel];
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(24*Width,78.5*Width, CXCWidth, 1.5*Width);
        

         }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic
{
    _dic=dic;
    UILabel*nameLabel =[self viewWithTag:230];
    UILabel*numberLabel =[self viewWithTag:240];
    int box =[[_dic objectForKey:@"num"] intValue]/[[_dic objectForKey:@"boxnum"] intValue];
    int he =[[_dic objectForKey:@"num"] intValue]%[[_dic objectForKey:@"boxnum"] intValue];
    
    if (box==0) {
        numberLabel.text  = [NSString stringWithFormat:@"%d盒",he];
        
    }else if(box>0&&he>0)
    {
        numberLabel.text  = [NSString stringWithFormat:@"%d箱%d盒",box,he];
        
    }else if(box>0&&he==0)
    {
        numberLabel.text  = [NSString stringWithFormat:@"%d箱",box];
        
    }

    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];

    
    
    
}
@end
