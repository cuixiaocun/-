//
//  TracingCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "TracingCell.h"

@implementation TracingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray*leftArr =@[@"2017-06-02 08:23:24",@"流转码",@"流转信息",@"",@"",@"",];
        
        NSArray*rightArr =@[@"",@"1111",@"商品A",@"51",@"",@"",@"",];
        for (int i=0; i<2; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, 80*i*Width, CXCWidth, 80*Width);
            if (i==0) {
                bgview.backgroundColor =BGColor;
                
                //时间
                UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,500*Width , 80*Width)];
                labe.text = leftArr[i];
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                labe.tag=199;
                [bgview addSubview:labe];
            }
            if (i==1) {
                //左边提示
                UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 80*Width)];
                labe.text = leftArr[i];
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                [bgview addSubview:labe];
                //右边内容
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.frame =CGRectMake(150*Width ,0, 575*Width,80*Width );
                rightLabel.textColor = NavColor;
                rightLabel.textColor = BlackColor;
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:12];
                [bgview addSubview:rightLabel];
                //细线
                UIImageView*xianOfGoods =[[UIImageView alloc]init];
                xianOfGoods.backgroundColor =BGColor;
                [bgview addSubview:xianOfGoods];
                xianOfGoods.frame =CGRectMake(24*Width,78.5*Width,CXCWidth,1.5*Width);
                
                
            }
            
            
            
        }
        
        
    }
    return self;
    
}
-(void)examinePass:(UIButton*)btn
{
    
    
}
-(void)calculateTheGoods
{
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic =Dict;
    UILabel *timeLabel =[self viewWithTag:199];
    timeLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"updatetime"]];
    
    UILabel *cirLabel =[self viewWithTag:201];
    cirLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"sn"]];

   }

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
