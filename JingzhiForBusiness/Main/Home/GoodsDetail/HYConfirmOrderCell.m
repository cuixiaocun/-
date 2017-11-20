//
//  HYConfirmOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYConfirmOrderCell.h"

@implementation HYConfirmOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0,20*Width, CXCWidth, 220*Width)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        _goodsImgView =[[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"timg-8.jpeg"]];
        _goodsImgView.backgroundColor =BGColor  ;
        _goodsImgView.frame=CGRectMake(50*Width, 30*Width, 160*Width, 160*Width);
        [bgView addSubview:_goodsImgView];
        
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+60*Width,10*Width, 310*Width, 100*Width)];
        _goodsTitleLab.text = @"商品A-几万块合法商品A-几万块合法商品A-几万块合法商品A-几万块合法商品A-几万块合法";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.numberOfLines =0;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //描述
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitleLab.left,_goodsTitleLab.bottom,500*Width,40*Width)];
        [bgView addSubview:_promptLabel];
        _promptLabel.textColor  =[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
        _promptLabel.font =[UIFont systemFontOfSize:12];
        _promptLabel.text = @"1件";
        //价格
        UILabel* priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+60*Width,_promptLabel.bottom, 360*Width, 60*Width)];
        priceLabel.text =@"¥400.00";
        priceLabel.font =[UIFont systemFontOfSize:16];
        priceLabel.textColor =NavColor;
        [bgView addSubview:priceLabel];
        _priceLab =priceLabel;
        
        
        
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic =Dict;
    _goodsImgView.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"img"]]];
    _goodsTitleLab.text =[NSString  stringWithFormat:@"%@", [_dic objectForKey:@"name"]];
//    NSInteger box =[[NSString  stringWithFormat:@"%@", [_dic objectForKey:@"num"]] integerValue]/[[NSString  stringWithFormat:@"%@", [_dic objectForKey:@"boxnum"]] integerValue];
//    NSInteger num =[[NSString  stringWithFormat:@"%@", [_dic objectForKey:@"num"]] integerValue]%[[NSString  stringWithFormat:@"%@", [_dic objectForKey:@"boxnum"]] integerValue];
//    if (box==0) {
//        _promptLabel.text   = [NSString stringWithFormat:@"%ld盒",num];
//
//    }else if(box>0&&num>0)
//    {
//        _promptLabel.text  = [NSString stringWithFormat:@"%ld箱%ld盒",box,num];
//
//    }else if(box>0&&num==0)
//    {
    _promptLabel.text  = [NSString stringWithFormat:@"%ld件",(long)[[NSString  stringWithFormat:@"%@", [_dic objectForKey:@"goodsNum"]] integerValue]];
        
//    }
    _priceLab.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"price"]];

        
}
-(void)setDicForGoods:(NSDictionary *)dicForGoods
{
    _dicForGoods =dicForGoods;
    _goodsImgView.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dicForGoods objectForKey:@"img"]]];
    _goodsTitleLab.text =[NSString  stringWithFormat:@"%@", [_dicForGoods objectForKey:@"goodsTitle"]];
//    NSInteger box =[[NSString  stringWithFormat:@"%@", [_dicForGoods objectForKey:@"goodsNum"]] integerValue]/[[NSString  stringWithFormat:@"%@", [_dicForGoods objectForKey:@"boxnum"]] integerValue];
//    NSInteger num =[[NSString  stringWithFormat:@"%@", [_dicForGoods objectForKey:@"goodsNum"]] integerValue]%[[NSString  stringWithFormat:@"%@", [_dicForGoods objectForKey:@"boxnum"]] integerValue];
//    if (box==0) {
    _promptLabel.text =[NSString stringWithFormat:@"%ld件",(long)[[NSString  stringWithFormat:@"%@", [_dicForGoods objectForKey:@"goodsNum"]] integerValue]] ;
//
//    }else
//    {
//        _promptLabel.text = [NSString stringWithFormat:@"%ld箱%ld盒",box,num];
//
//    }
    _priceLab.text =[NSString stringWithFormat:@"¥%@",[_dicForGoods objectForKey:@"goodsPrice"]];
    
    
}


@end
