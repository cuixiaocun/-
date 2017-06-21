//
//  AntiFakeCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/17.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AntiFakeCell.h"

@implementation AntiFakeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.backgroundColor =BGColor;
        
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 220*Width)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        
        
        _goodsImgView =[[EGOImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _goodsImgView.backgroundColor =[UIColor grayColor];
        _goodsImgView.frame=CGRectMake(50*Width, 30*Width, 160*Width, 160*Width);
        [bgView addSubview:_goodsImgView];
        
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+60*Width,10*Width, 310*Width, 100*Width)];
        _goodsTitleLab.text = @"商品A-几万块合法";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.numberOfLines =0;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //价格
        UILabel* priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+60*Width, 100*Width, 360*Width, 60*Width)];
        priceLabel.text =@"¥400.00";
        priceLabel.font =[UIFont systemFontOfSize:16];
        priceLabel.textColor =NavColor;
        [bgView addSubview:priceLabel];
        _priceLab =priceLabel;
        
        //描述
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel.left,priceLabel.bottom,500*Width,40*Width)];
        [bgView addSubview:_promptLabel];
        _promptLabel.textColor  =[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
        _promptLabel.font =[UIFont systemFontOfSize:12];
        _promptLabel.text = @"此产品为本公司产品，请放心使用";
        _watermarkImgV =[[UIImageView alloc]initWithFrame:CGRectMake(530*Width, 0, 155*Width, 120*Width)];
        _watermarkImgV.image =[UIImage imageNamed:@"fangwei_icon_zhang"];
        _watermarkImgV.alpha =0.5;
        [bgView addSubview:_watermarkImgV];
        
        
        
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    _priceLab.text = [NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"prices"]];//单价
    _goodsTitleLab.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    if ([[_dic objectForKey:@"isAuthentication"]isEqualToString:@"YES"]) {
        _watermarkImgV.hidden=NO;
    }else
    {
        _watermarkImgV.hidden=NO;

    }
    
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
