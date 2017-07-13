//
//  ManageDeclarCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ManageDeclarCell.h"

@implementation ManageDeclarCell

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
        NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",@"900000"];//总和
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
        NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
        [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
        
        pricesLabel.tag =101;
        [pricesLabel setAttributedText:textColor];
        [self addSubview:pricesLabel];
        pricesLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
        pricesLabel.backgroundColor =BGColor;
        pricesLabel.textAlignment = NSTextAlignmentRight;
        //订单号
        UILabel* orderNumberLabel  = [[UILabel alloc]init];
        orderNumberLabel.font = [UIFont systemFontOfSize:14];
        orderNumberLabel.text = @"    订单号：1953056874376";
        [self addSubview:orderNumberLabel];
        orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
        orderNumberLabel.tag =102;

        orderNumberLabel.textColor = TextGrayColor;
        //状态
        UILabel* orderStatuerLabel  = [[UILabel alloc]init];
        orderStatuerLabel.font = [UIFont systemFontOfSize:14];
        orderStatuerLabel.text = @"待审核";
        orderStatuerLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:orderStatuerLabel];
        orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
        orderStatuerLabel.tag=103;

        orderStatuerLabel.textColor = NavColor;
        
        NSArray*leftArr =@[@"代理名称",@"账号",@"等级",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"等待审核",@"一级",@"18363671722",@"18366609451",@"",@"",@"",@"",];
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
                
                UIButton *examineBtn =[[UIButton alloc]initWithFrame:CGRectMake(475*Width, 15*Width, 90*Width,50*Width)];
                
                [examineBtn setBackgroundColor:[UIColor whiteColor]];
                [examineBtn.layer setCornerRadius:4*Width];
                [examineBtn.layer setBorderWidth:1.0*Width];
                [examineBtn.layer setMasksToBounds:YES];
                [examineBtn setTitleColor:NavColor forState:UIControlStateNormal];
                examineBtn.layer.borderColor =NavColor.CGColor;
                examineBtn.tag =2000;
                [examineBtn setTitle:@"详情" forState:UIControlStateNormal];
                [examineBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [examineBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [examineBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:examineBtn];

                UIButton *detailBtn =[[UIButton alloc]initWithFrame:CGRectMake(580*Width, 15*Width, 145*Width,50*Width)];
                [bgview addSubview:examineBtn];
                
                [detailBtn setBackgroundColor:[UIColor whiteColor]];
                [detailBtn.layer setCornerRadius:4*Width];
                [detailBtn.layer setBorderWidth:1.0*Width];
                [detailBtn.layer setMasksToBounds:YES];
                [detailBtn setTitleColor:NavColor forState:UIControlStateNormal];
                detailBtn.layer.borderColor =NavColor.CGColor;
                detailBtn.tag =2001;
                [detailBtn setTitle:@"审核通过" forState:UIControlStateNormal];
                [detailBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [detailBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [detailBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:detailBtn];
                

                UIButton *bhBtn =[[UIButton alloc]initWithFrame:CGRectMake(630*Width, 15*Width, 90*Width,50*Width)];
                [bgview addSubview:bhBtn];
                
                [bhBtn setBackgroundColor:[UIColor whiteColor]];
                [bhBtn.layer setCornerRadius:4*Width];
                [bhBtn.layer setBorderWidth:1.0*Width];
                [bhBtn.layer setMasksToBounds:YES];
                [bhBtn setTitleColor:NavColor forState:UIControlStateNormal];
                bhBtn.layer.borderColor =NavColor.CGColor;
                bhBtn.tag =2003;
                [bhBtn setTitle:@"驳回" forState:UIControlStateNormal];
                [bhBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [bhBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [bhBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:bhBtn];
                

                
            }
            
            
            
            
        }
        
        
    }
    return self;
    
}
-(void)examinePass:(UIButton*)btn
{

    [self.delegate btnClick:self andFlag:(int)btn.tag];

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
    UIButton*seeBtn =[self viewWithTag:2000];
    UIButton*shBtn =[self viewWithTag:2001];
    UIButton *bhBtn =[self viewWithTag:2003];

    //    0全部  1 待审核  2 已驳回  3 已审核   4 已完成 5 已取消
    if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"1"])
    {
        bhBtn.hidden=NO;
        bhBtn.frame =CGRectMake(365*Width, 15*Width, 90*Width,50*Width);
        statuLabel.text =@"待审核";
        seeBtn.hidden =NO;
        shBtn.hidden =NO;
        seeBtn.frame =CGRectMake(475*Width, 15*Width, 90*Width,50*Width);
        shBtn.frame =CGRectMake(580*Width, 15*Width, 145*Width,50*Width);

    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"3"])
    {
        seeBtn.hidden =NO;
        shBtn.hidden =YES;
        bhBtn.hidden=YES;

        seeBtn.frame =CGRectMake(630*Width, 15*Width, 90*Width,50*Width);

        statuLabel.text =@"已审核";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"2"])
    {
        statuLabel.text =@"已驳回";
        seeBtn.hidden =NO;
        shBtn.hidden =YES;
        bhBtn.hidden=YES;

        seeBtn.frame =CGRectMake(630*Width, 15*Width, 90*Width,50*Width);


    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"4"])
    {
        seeBtn.hidden =NO;
        shBtn.hidden =YES;
        seeBtn.frame =CGRectMake(630*Width, 15*Width, 90*Width,50*Width);
        bhBtn.hidden=YES;


        statuLabel.text =@"已完成";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"5"])
    {
        seeBtn.hidden =NO;
        shBtn.hidden =YES;
        seeBtn.frame =CGRectMake(630*Width, 15*Width, 90*Width,50*Width);
        bhBtn.hidden=YES;

        statuLabel.text =@"已取消";
    }
    
    UILabel *nameLabel =[self viewWithTag:200];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"agenname"]];
    
    UILabel *accountLabel =[self viewWithTag:201];
    accountLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"account"]];
    
    UILabel *levelLabel =[self viewWithTag:202];
    levelLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"levelname"]];
    
    
    
    
    
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
