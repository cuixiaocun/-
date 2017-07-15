//
//  MemberOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MemberOrderCell.h"

@implementation MemberOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 20*Width);
        
        NSArray*leftArr =@[@"订单号：",@"会员昵称",@"下单时间",@"收货地址",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"",@"",@"",@"",@"",@"",@"",@"",@"",];
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
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = BlackColor;
                labe.frame =CGRectMake(32*Width, 0,500*Width , 82*Width);

            }else if(i>0&&i<4)
            {
                if(i==3)
                {
                    labe.frame =CGRectMake(32*Width, 0,200*Width , 122*Width);
                    labe.numberOfLines=0;
                    bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 122*Width);

                }
                labe.text = leftArr[i];
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            }else if(i==4)
            {
                bgview.frame =CGRectMake(0, xian.bottom+i*82*Width+40*Width, CXCWidth, 82*Width);
                bgview.backgroundColor =[UIColor whiteColor];
                
                
            }
            [bgview addSubview:labe];
            //右边显示
            if (i<4) {
                
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                [bgview addSubview:rightLabel];
                rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
                if (i==0) {
                    rightLabel.textColor = NavColor;
                    rightLabel.frame =CGRectMake(400*Width ,0, 325*Width,82*Width );

                    
                }else
                {
                    rightLabel.textColor = BlackColor;
                    
                }
                
                if(i==3)
                {
                    rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,122*Width );
                    rightLabel.numberOfLines=0;

                }
               
                
            }else
            {
                //系统计算按钮
                _seeBtn = [[UIButton alloc]init];
                [_seeBtn setBackgroundColor:[UIColor whiteColor]];
                [_seeBtn.layer setCornerRadius:2*Width];
                [_seeBtn.layer setBorderWidth:1.5*Width];
                [_seeBtn.layer setMasksToBounds:YES];
                [_seeBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [_seeBtn setTitle:@"详情" forState:UIControlStateNormal];
                [_seeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_seeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _seeBtn.layer.borderColor =TextGrayColor.CGColor;
                [bgview addSubview:_seeBtn];
                _seeBtn.tag=130;
                _seeBtn.hidden=YES;

                //发货
                _deliverBtn = [[UIButton alloc]init];
                [_deliverBtn setBackgroundColor:[UIColor whiteColor]];
                [_deliverBtn.layer setCornerRadius:2*Width];
                [_deliverBtn.layer setBorderWidth:1.5*Width];
                [_deliverBtn.layer setMasksToBounds:YES];
                [_deliverBtn setTitleColor:NavColor forState:UIControlStateNormal];
                [_deliverBtn setTitle:@"发货" forState:UIControlStateNormal];
                _deliverBtn.tag=131;
                [_deliverBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_deliverBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _deliverBtn.layer.borderColor =NavColor.CGColor;
                [bgview addSubview:_deliverBtn];
                //驳回
                 _rejectBtn = [[UIButton alloc]init];
                [_rejectBtn setBackgroundColor:[UIColor whiteColor]];
                [_rejectBtn.layer setCornerRadius:2*Width];
                [_rejectBtn.layer setBorderWidth:1.5*Width];
                [_rejectBtn.layer setMasksToBounds:YES];
                [_rejectBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [_rejectBtn setTitle:@"驳回" forState:UIControlStateNormal];
                _rejectBtn.tag=132;

                [_rejectBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_rejectBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _rejectBtn.layer.borderColor =TextGrayColor.CGColor;
                [bgview addSubview:_rejectBtn];
                //驳回
                _loginDetailBtn = [[UIButton alloc]init];
                [_loginDetailBtn setBackgroundColor:[UIColor whiteColor]];
                [_loginDetailBtn.layer setCornerRadius:2*Width];
                [_loginDetailBtn.layer setBorderWidth:1.5*Width];
                [_loginDetailBtn.layer setMasksToBounds:YES];
                [_loginDetailBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [_loginDetailBtn setTitle:@"物流" forState:UIControlStateNormal];
                _loginDetailBtn.tag=133;
                [_loginDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_loginDetailBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _loginDetailBtn.layer.borderColor =TextGrayColor.CGColor;
                [bgview addSubview:_loginDetailBtn];

                
            }
            
            if(i<4&&i>0)
            {
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                [bgview addSubview:xian];
                if (i==3) {
                    xian.frame =CGRectMake(24*Width,120.5*Width, CXCWidth, 1.5*Width);
                }else
                {
                    xian.frame =CGRectMake(24*Width,80.5*Width, CXCWidth, 1.5*Width);
                    

                }
              }else if (i==4)
            {
                xian.frame =CGRectMake(24*Width,80.5*Width+40*Width, CXCWidth, 1.5*Width);

                xian.backgroundColor =[UIColor redColor];

            }
        }
        [_deliverBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        [_rejectBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
        [_seeBtn setFrame:CGRectMake(410*Width,13.5*Width , 90*Width, 55*Width)];
        

    }
    
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)btnAction:(UIButton *)btn
{
    //调用代理
    [self.delegate btnClick:self andTag:(int)btn.tag];

    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel *orderIdLabel =[self viewWithTag:199];

    UILabel *typeLabel =[self viewWithTag:200];
    UILabel *accountLabel =[self viewWithTag:201];
    UILabel *timeLabel =[self viewWithTag:202];
    UILabel *addressLabel =[self viewWithTag:203];
    orderIdLabel.text =[NSString stringWithFormat:@"订单号：%@",[_dic objectForKey:@"id"]];
    accountLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    timeLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"createtime"]];
    addressLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"address"]];
    if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"5"]) {
        [_seeBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        _seeBtn.hidden =NO;
        _loginDetailBtn.hidden =NO;
        _rejectBtn.hidden=YES;
        _deliverBtn.hidden =YES;

        typeLabel.text =@"已取消";
    }else if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"6"])
    {
        [_seeBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        _seeBtn.hidden =NO;
        _loginDetailBtn.hidden =YES;
        _rejectBtn.hidden=YES;
        _deliverBtn.hidden =YES;

        typeLabel.text =@"已驳回";
    
    }else if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"4"])
    {
        typeLabel.text =@"已完成";
        [_loginDetailBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        
        [_seeBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
        _deliverBtn.hidden =YES;
        _seeBtn.hidden =NO;
        _loginDetailBtn.hidden =NO;
        _rejectBtn.hidden=YES;
        
        
    }
    else if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"3"])
    {
        typeLabel.text =@"已发货";
        [_loginDetailBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        [_seeBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
        _seeBtn.hidden =NO;
        _loginDetailBtn.hidden =NO;
        _rejectBtn.hidden=YES;
        _deliverBtn.hidden =YES;

    }
    else if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"2"])
    {

        typeLabel.text =@"待发货";
        [_seeBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
        [_deliverBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        _seeBtn.hidden =NO;
        _loginDetailBtn.hidden =YES;
        _rejectBtn.hidden=YES;
        _deliverBtn.hidden =NO;
        
    }
    else if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status"]] isEqualToString:@"1"])
    {
        typeLabel.text =@"待支付";
        
        [_seeBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
        [_rejectBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        _seeBtn.hidden =NO;
        _loginDetailBtn.hidden =YES;
        _rejectBtn.hidden=NO;
        _deliverBtn.hidden =YES;
    }
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
