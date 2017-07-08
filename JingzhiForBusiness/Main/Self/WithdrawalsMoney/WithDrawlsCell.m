//
//  WithDrawlsCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "WithDrawlsCell.h"

@implementation WithDrawlsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray*leftArr =@[@" ",@"姓名",@"账号",@"提现金额",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"",@"",@"",@"",@"",@"",@"",@"",];
        for (int i=0; i<4; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,350*Width , 82*Width)];
            if (i==0) {
                bgview.backgroundColor =BGColor;

                labe.tag =199;
                labe.text = leftArr[i] ;
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = TextGrayColor;
            }else if(i>0&&i<4)
            {
                bgview.backgroundColor =[UIColor whiteColor];

                labe.text = leftArr[i];
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            }else
            {
                bgview.backgroundColor =[UIColor whiteColor];
                
                
            }
            [bgview addSubview:labe];
            //右边显示
            if (i<4) {
                
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
                if (i==0) {
                    rightLabel.textColor = NavColor;
                    
                }else
                {
                    rightLabel.textColor = BlackColor;
                    
                }
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                [bgview addSubview:rightLabel];
                
            }
            
            
            if(i<3&&i>0)
            {
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                [bgview addSubview:xian];
                xian.frame =CGRectMake(24*Width,80.5*Width, CXCWidth, 1.5*Width);
                
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
    _dic=Dict;
    UILabel *timeLabel =[self viewWithTag:199];
    UILabel *statuLabel =[self viewWithTag:200];
    UILabel *nameLabel =[self viewWithTag:201];
    UILabel *accountLabel =[self viewWithTag:202];
    UILabel *moneyLabel =[self viewWithTag:203];
    
    timeLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"updatetime"]];
    statuLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"stname"]];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    accountLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"account"]];
    moneyLabel.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"amount"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
