//
//  MyAppointmentTwoVC.m
//  家装
//
//  Created by Admin on 2017/9/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MyAppointmentTwoCell.h"

@implementation MyAppointmentTwoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        //横线
        //        UIImageView*xian =[[UIImageView alloc]init];
        //        xian.backgroundColor =BGColor;
        //        [self addSubview:xian];
        //        xian.frame =CGRectMake(0,0*Width, CXCWidth, 1.5*Width);
        
        NSArray*leftArr =@[@"2017-11-11",@"ID",@"设计师",@"联系人",@"联系电话",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"",@"1984949220130",@"李品",@"李品",@"1836321572",@"3",@"",@"",];
        for (int i=0; i<5; i++){
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 82*Width);
            
            
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,300*Width , 82*Width)];
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
            if(i==0)
            {
                bgview.backgroundColor =BGColor;
                
                labe.tag =199;
                rightLabel.textColor =NavColor;
                
            }
            
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
    UILabel *timeLabel =[self viewWithTag:199];
    UILabel *IDLabel =[self viewWithTag:201];
    UILabel *cityLabel =[self viewWithTag:202];
    
    UILabel *nameLabel =[self viewWithTag:203];
    UILabel *phoneLabel =[self viewWithTag:204];
    UILabel *numberLabel =[self viewWithTag:205];
    //    timeLabel =[NSString stringWithFormat:@"%@/%@",[_dic objectForKey:@"sourcename"],[_dic objectForKey:@"source"]];
    //    statuLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"before"]];
    //    IDLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"beforename"]];
    //    cityLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"info"]];
    //    nameLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"after"]];
    //    phoneLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"createtime"]];
    //    numberLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"aftername"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
