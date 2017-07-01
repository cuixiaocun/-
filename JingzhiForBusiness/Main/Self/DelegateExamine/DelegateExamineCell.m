//
//  DelegateExamineCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DelegateExamineCell.h"

@implementation DelegateExamineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 18*Width);
        
        NSArray*leftArr =@[@"",@"代理级别",@"账号",@"上级代理号",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"等待审核",@"一级",@"18363671722",@"18366609451",@"",@"",@"",@"",];
        for (int i=0; i<5; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =BGColor;
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            if (i==0) {
                bgview.backgroundColor =[UIColor whiteColor];
                labe.tag =199;
                labe.text = @"类型：升级";
                labe.font = [UIFont systemFontOfSize:16];
                labe.textColor = BlackColor;
            }else if(i>0&&i<4)
            {
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
 
            }else
            {
                //系统计算按钮
                UILabel * seeBtn = [[UILabel alloc]init];
                [seeBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
                [seeBtn setBackgroundColor:[UIColor whiteColor]];
                [seeBtn.layer setCornerRadius:2*Width];
                [seeBtn.layer setBorderWidth:1.5*Width];
                [seeBtn.layer setMasksToBounds:YES];
                seeBtn.textColor =NavColor;
                seeBtn.text =@"查看";
                seeBtn.textAlignment =NSTextAlignmentCenter;
                seeBtn.font =[UIFont systemFontOfSize:14];
                seeBtn.layer.borderColor =NavColor.CGColor;
//                [seeBtn setTitleColor:NavColor forState:UIControlStateNormal];
//                [seeBtn setTitle:@"查看" forState:UIControlStateNormal];
//                [seeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//                [seeBtn addTarget:self action:@selector(calculateTheGoods) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:seeBtn];
                

            
            
            }
            
            if(i<4&&i>0)
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
    UILabel *typeLabel =[self viewWithTag:199];
    UILabel *statuLabel =[self viewWithTag:200];
    UILabel *levelLabel =[self viewWithTag:201];
    UILabel *accountLabel =[self viewWithTag:202];
    UILabel *lastAccountLabel =[self viewWithTag:203];
    typeLabel.text =[NSString stringWithFormat:@"类型：%@",[_dic objectForKey:@"typename"]];
    statuLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"stuname"]];
    levelLabel.text =[NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"lname"]]]];
    accountLabel.text =[NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"account"]]]];
    lastAccountLabel.text =[NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"upagenaccount"]]]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
