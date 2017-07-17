//
//  MydeclarNewCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MydeclarNewCell.h"

@implementation MydeclarNewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //时间
        UILabel* timeLabel  = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.text = @"    2017-09-01 12：23：24";
        [self addSubview:timeLabel];
        timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
        timeLabel.backgroundColor =BGColor;
        timeLabel.textColor = TextGrayColor;
        timeLabel.tag=100;
        //总额
        UILabel* pricesLabel  = [[UILabel alloc]init];
        pricesLabel.font = [UIFont systemFontOfSize:13];
        pricesLabel.textColor = TextGrayColor;
        [self addSubview:pricesLabel];
        pricesLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
        pricesLabel.backgroundColor =BGColor;
        pricesLabel.textAlignment = NSTextAlignmentRight;
        pricesLabel.tag=101;

        //订单号
        UILabel* orderNumberLabel  = [[UILabel alloc]init];
        orderNumberLabel.font = [UIFont systemFontOfSize:14];
        orderNumberLabel.text = @"    订单号：1953056874376";
        [self addSubview:orderNumberLabel];
        orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
        orderNumberLabel.textColor = TextGrayColor;
        orderNumberLabel.tag=102;

        //状态
        UILabel* orderStatuerLabel  = [[UILabel alloc]init];
        orderStatuerLabel.font = [UIFont systemFontOfSize:14];
        orderStatuerLabel.text = @"待审核";
        orderStatuerLabel.tag=103;

        orderStatuerLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:orderStatuerLabel];
        orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
        orderStatuerLabel.textColor = NavColor;
        
        NSArray*leftArr =@[@"代理名称",@"账号",@"等级",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"",@"",@"",@"",@"",@"",@"",@"",];
        for (int i=0; i<4; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =BGColor;
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, orderNumberLabel.bottom+82*i*Width, CXCWidth, 82*Width);
            if (i<3) {
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            labe.text = leftArr[i];
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            //右边内容
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textColor = NavColor;
            rightLabel.textColor = BlackColor;
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            [bgview addSubview:rightLabel];
                //细线
            UIImageView*xianOfGoods =[[UIImageView alloc]init];
            xianOfGoods.backgroundColor =[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
            [bgview addSubview:xianOfGoods];
            xianOfGoods.frame =CGRectMake(0*Width,80.5*Width,CXCWidth,1.5*Width);
                
             
            }
            if (i==3) {
                bgview.backgroundColor =[UIColor whiteColor];

                //系统计算按钮
                UILabel * seeBtn = [[UILabel alloc]init];
                [seeBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
                [seeBtn setBackgroundColor:[UIColor whiteColor]];
                [seeBtn.layer setCornerRadius:2*Width];
                [seeBtn.layer setBorderWidth:1.5*Width];
                [seeBtn.layer setMasksToBounds:YES];
                seeBtn.textColor =TextColor;
                seeBtn.text =@"详情";
                seeBtn.textAlignment =NSTextAlignmentCenter;
                seeBtn.font =[UIFont systemFontOfSize:14];
                seeBtn.layer.borderColor =TextColor.CGColor;
                [bgview addSubview:seeBtn];
                
                

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
    UILabel*timeLabel =[self viewWithTag:100];
    timeLabel.text =[NSString stringWithFormat:@"     %@",[_dic objectForKey:@"createtime"]];
    UILabel*pricesLabel =[self viewWithTag:101];
    NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",[_dic objectForKey:@"total"]];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [pricesLabel setAttributedText:textColor];


    UILabel*orderNumLabel =[self viewWithTag:102];
    orderNumLabel.text =[NSString stringWithFormat:@"    订单号：%@",[_dic objectForKey:@"id"]];
    
    UILabel*statuLabel =[self viewWithTag:103];
//    0全部  1 待审核  2 已驳回  3 已审核   4 已完成 5 已取消
    if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"1"])
    {
    statuLabel.text =@"待审核";
    
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"3"])
    {
        statuLabel.text =@"已审核";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"2"])
    {
        statuLabel.text =@"已驳回";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"4"])
    {
        statuLabel.text =@"已完成";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"5"])
    {
        statuLabel.text =@"已取消";
    }

    UILabel *nameLabel =[self viewWithTag:200];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"upagenname"]];

    UILabel *accountLabel =[self viewWithTag:201];
    accountLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"upagenaccount"]];

    UILabel *levelLabel =[self viewWithTag:202];
    levelLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"upagenlevelname"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
