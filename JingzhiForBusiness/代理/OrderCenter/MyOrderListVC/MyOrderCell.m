//
//  MyOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withYESBtn:(NSString *)string
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

        //状态
        UILabel* orderStatuerLabel  = [[UILabel alloc]init];
        orderStatuerLabel.font = [UIFont systemFontOfSize:14];
        orderStatuerLabel.text = @"待审核";
        orderStatuerLabel.tag=103;

        orderStatuerLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:orderStatuerLabel];
        orderStatuerLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
        orderStatuerLabel.textColor = NavColor;
        
        NSArray*leftArr =@[@"代理名称",@"电话",@"商品",@"数量",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"等待审核",@"一级",@"商品A",@"51",@"",@"",@"",@"",];
        for (int i=0; i<5; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, orderStatuerLabel.bottom+82*i*Width, CXCWidth, 82*Width);
            if (i<4) {
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
            if (i==4) {
                bgview.backgroundColor =[UIColor whiteColor];
                
                UIButton *examineBtn =[[UIButton alloc]initWithFrame:CGRectMake(420*Width, 15*Width, 145*Width,50*Width)];
                [bgview addSubview:examineBtn];
                
                [examineBtn setBackgroundColor:[UIColor whiteColor]];
                [examineBtn.layer setCornerRadius:4*Width];
                [examineBtn.layer setBorderWidth:1.0*Width];
                [examineBtn.layer setMasksToBounds:YES];
                [examineBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                examineBtn.layer.borderColor =TextGrayColor.CGColor;
                examineBtn.tag =2000;
                [examineBtn setTitle:@"查看物流" forState:UIControlStateNormal];
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
                [detailBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                [detailBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [detailBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [detailBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:detailBtn];
                
            }
            
        }
        
        
    }
    return self;
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withNOBtn:(NSString *)string
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
        
        //状态
        UILabel* orderStatuerLabel  = [[UILabel alloc]init];
        orderStatuerLabel.font = [UIFont systemFontOfSize:14];
        orderStatuerLabel.text = @"待审核";
        orderStatuerLabel.tag=103;
        
        orderStatuerLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:orderStatuerLabel];
        orderStatuerLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
        orderStatuerLabel.textColor = NavColor;
        
        NSArray*leftArr =@[@"代理名称",@"电话",@"商品",@"数量",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"等待审核",@"一级",@"商品A",@"51",@"",@"",@"",@"",];
        for (int i=0; i<4; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, orderStatuerLabel.bottom+82*i*Width, CXCWidth, 82*Width);
            if (i<4) {
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
            
        }
        
        
    }
    return self;
    
}
-(void)examinePass:(UIButton*)btn
{
    
    [self.delegate btnClick:self andActionTag:btn.tag];
    
}
-(void)calculateTheGoods
{
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel*timeLabel =[self viewWithTag:100];
    timeLabel.text =[NSString stringWithFormat:@"     %@",[_dic objectForKey:@"updatetime"]];
    UILabel*statuLabel =[self viewWithTag:103];
    UIButton *passBtn =[self viewWithTag:2000];
    UIButton *detailBtn =[self viewWithTag:2001];
    //按钮改frame与隐藏

    if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"2"])
    {
        passBtn.hidden =YES;
        detailBtn.hidden =YES;
        statuLabel.text =@"未发货";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"3"])
    {
       
        
        passBtn.hidden =NO;
        detailBtn.hidden =NO;
        passBtn.frame =CGRectMake(420*Width, 15*Width, 145*Width,50*Width);
        detailBtn.frame =CGRectMake(580*Width, 15*Width, 145*Width,50*Width);
        statuLabel.text =@"已发货";
       
        
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"4"])
    {
        statuLabel.text =@"已完成";
        passBtn.hidden =NO;
        detailBtn.hidden =YES;
        passBtn.frame =CGRectMake(580*Width, 15*Width, 145*Width,50*Width);
    }
    UILabel *nameLabel =[self viewWithTag:200];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"account"]];
    UILabel *accountLabel =[self viewWithTag:201];
    accountLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone"]]];
    
    UILabel *goodLabel =[self viewWithTag:202];
    goodLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    UILabel *numberLabel =[self viewWithTag:203];
    numberLabel.text=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"num"]];
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
