//
//  ManageOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ManageOrderCell.h"

@implementation ManageOrderCell


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

        
        //状态
        UILabel* orderStatuerLabel  = [[UILabel alloc]init];
        orderStatuerLabel.font = [UIFont systemFontOfSize:14];
        orderStatuerLabel.text = @"待审核";
        orderStatuerLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:orderStatuerLabel];
        orderStatuerLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
        orderStatuerLabel.textColor = NavColor;
        orderStatuerLabel.tag=101;

        
        NSArray*leftArr =@[@"代理名称",@"账号",@"商品",@"数量",@"",@"",@"",@"",];
        
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
                
                UIButton *seeBtn =[[UIButton alloc]initWithFrame:CGRectMake(350*Width, 15*Width, 145*Width,50*Width)];
                [bgview addSubview:seeBtn];
                
                [seeBtn setBackgroundColor:[UIColor whiteColor]];
                [seeBtn.layer setCornerRadius:4*Width];
                [seeBtn.layer setBorderWidth:1.0*Width];
                [seeBtn.layer setMasksToBounds:YES];
                [seeBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                seeBtn.layer.borderColor =TextGrayColor.CGColor;
                seeBtn.tag =2000;
                [seeBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                [seeBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [seeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [seeBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:seeBtn];
                
                UIButton *circulationBtn =[[UIButton alloc]initWithFrame:CGRectMake(520*Width, 15*Width, 90*Width,50*Width)];
                [bgview addSubview:circulationBtn];
                [circulationBtn setBackgroundColor:[UIColor whiteColor]];
                [circulationBtn.layer setCornerRadius:4*Width];
                [circulationBtn.layer setBorderWidth:1.0*Width];
                [circulationBtn.layer setMasksToBounds:YES];
                [circulationBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                circulationBtn.layer.borderColor =TextGrayColor.CGColor;
                circulationBtn.tag =2001;
                [circulationBtn setTitle:@"流转" forState:UIControlStateNormal];
                [circulationBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [circulationBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [circulationBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:circulationBtn];
                
                UIButton *deliverBtn =[[UIButton alloc]initWithFrame:CGRectMake(630*Width, 15*Width, 90*Width,50*Width)];
                [bgview addSubview:deliverBtn];
                
                [deliverBtn setBackgroundColor:[UIColor whiteColor]];
                [deliverBtn.layer setCornerRadius:4*Width];
                [deliverBtn.layer setBorderWidth:1.0*Width];
                [deliverBtn.layer setMasksToBounds:YES];
                [deliverBtn setTitleColor:NavColor forState:UIControlStateNormal];
                deliverBtn.layer.borderColor =NavColor.CGColor;
                deliverBtn.tag =2002;
                [deliverBtn setTitle:@"发货" forState:UIControlStateNormal];
                [deliverBtn.titleLabel setTextColor:[UIColor whiteColor]];
                [deliverBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [deliverBtn addTarget:self action:@selector(examinePass:) forControlEvents:UIControlEventTouchUpInside];
                [bgview addSubview:deliverBtn];
                

                
                
                
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
    UILabel*timeLabel=[self viewWithTag:100];
    UILabel*statuLabel=[self viewWithTag:101];
    UILabel *nameLabel =[self viewWithTag:200];
    UILabel *accountLabel =[self viewWithTag:201];
    UILabel *goodnameLabel =[self viewWithTag:202];
    UILabel *numberLabel =[self viewWithTag:203];
    UIButton *wuliuBtn =[self viewWithTag:2000];
    UIButton *cirBtn =[self viewWithTag:2001];
    UIButton *fahuoBtn =[self viewWithTag:2002];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"agenname"]];
    accountLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"account"]];
    goodnameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
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
    

    //按钮改frame与隐藏
    timeLabel.text =[NSString stringWithFormat:@"     %@",[_dic objectForKey:@"updatetime"]];
    if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"2"])
    {
        fahuoBtn.hidden =NO;
        cirBtn.hidden =NO;
        wuliuBtn.hidden =YES;
        fahuoBtn.frame =CGRectMake(630*Width, 15*Width, 90*Width,50*Width);
        cirBtn.frame =CGRectMake(520*Width, 15*Width, 90*Width,50*Width);
        statuLabel.text =@"未发货";
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"3"])
    {
        
        wuliuBtn.frame =CGRectMake(575*Width, 15*Width, 145*Width,50*Width);

        fahuoBtn.hidden =YES;
        cirBtn.hidden =YES;
        wuliuBtn.hidden =NO;
       
        statuLabel.text =@"已发货";
        
        
    }else if([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"4"])
    {
        statuLabel.text =@"已完成";
        wuliuBtn.frame =CGRectMake(575*Width, 15*Width, 145*Width,50*Width);
        
        fahuoBtn.hidden =YES;
        cirBtn.hidden =YES;
        wuliuBtn.hidden =NO;
    }
    
    
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
