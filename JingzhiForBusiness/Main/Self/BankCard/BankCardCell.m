//
//  BankCardCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/8.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
            //银行卡背景
            UIImageView *cardBgView = [[UIImageView alloc]initWithFrame:CGRectMake(25*Width, 0, 700*Width, 270*Width)];
            cardBgView.userInteractionEnabled = YES;
            cardBgView.tag =900;
            [cardBgView setImage:[UIImage imageNamed:@"bcard_icon_bg_default"]];
            [self addSubview:cardBgView];
            
            //银行卡头像背景
            UIImageView *cardPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(36*Width, 36*Width, 70*Width, 70*Width)];
            cardPhoto.userInteractionEnabled = YES;
            cardPhoto.tag =100;
            cardPhoto.image =[UIImage imageNamed:@"bcard_icon_bank_white"];
            [cardBgView addSubview:cardPhoto];
            
            //name
            UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, cardPhoto.top-10*Width, 350*Width, 35*Width)];
            
            nameLabel.textColor =[UIColor whiteColor];
            nameLabel.text =@"曲小川";
            nameLabel.tag =200;
            
            nameLabel.font =[UIFont systemFontOfSize:16];
            [cardBgView addSubview:nameLabel];
            
            //银行
            UILabel *bankLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, nameLabel.bottom+10*Width, 350*Width, 35*Width)];
            bankLabel.textColor =[UIColor whiteColor];
            bankLabel.text =@"中国银行";
            bankLabel.tag =300;
            
            bankLabel.font =[UIFont systemFontOfSize:14];
            [cardBgView addSubview:bankLabel];
            
            //银行卡号
            UILabel *bankCardLabel =[[UILabel alloc]initWithFrame:CGRectMake(cardPhoto.right+20*Width, bankLabel.bottom+10*Width, 550*Width, 80*Width)];
            bankCardLabel.textColor =[UIColor whiteColor];
            bankCardLabel.text =@"6223910301160170";
            bankCardLabel.font =[UIFont systemFontOfSize:18];
            [cardBgView addSubview:bankCardLabel];
            bankCardLabel.tag =400;
            
            //默认label
            UILabel *defaultLabel =[[UILabel alloc]initWithFrame:CGRectMake(620*Width, nameLabel.top, 80*Width, 35*Width)];
            defaultLabel.textColor =[UIColor whiteColor];
            defaultLabel.text =@"默认";
            defaultLabel.tag=500;
            defaultLabel.font =[UIFont systemFontOfSize:14];
            [cardBgView addSubview:defaultLabel];
            //uibutton
            //系统计算按钮
            UIButton * setDefaultBtn = [[UIButton alloc]initWithFrame:CGRectMake(550*Width, 200*Width, 145*Width, 45*Width)];
            [setDefaultBtn.layer setCornerRadius:2*Width];
            [setDefaultBtn.layer setBorderWidth:1.5*Width];
            [setDefaultBtn.layer setMasksToBounds:YES];
            [setDefaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [setDefaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
            [setDefaultBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [setDefaultBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            setDefaultBtn.layer.borderColor =[UIColor whiteColor].CGColor;
            [cardBgView addSubview:setDefaultBtn];
            setDefaultBtn.tag=600;
//            if(i==0)
//            {
//                setDefaultBtn.hidden=YES;
//                defaultLabel.hidden=NO;
//            }else
//            {
//                setDefaultBtn.hidden=NO;
//                defaultLabel.hidden=YES;
//                
//            }
        

    
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
    [self.delegate  btnClick:self andTag:(int)btn.tag];
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel *typeLabel =[self viewWithTag:199];
    UILabel *statuLabel =[self viewWithTag:200];
    UILabel *levelLabel =[self viewWithTag:201];
    UILabel *accountLabel =[self viewWithTag:202];
    UILabel *lastAccountLabel =[self viewWithTag:203];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
