//
//  HYMyOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYMyOrderCell.h"

@implementation HYMyOrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor    =BGColor;
        UIView*topView =[[UIView alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 76*Width)];
        topView.backgroundColor =[UIColor whiteColor];
        [self addSubview:topView];
        
        //订单号
        UILabel* orderNumberLabel  = [[UILabel alloc]init];
        orderNumberLabel.font = [UIFont systemFontOfSize:14];
        orderNumberLabel.text = @"    订单号：1953056874376";
        [self addSubview:orderNumberLabel];
        orderNumberLabel.frame= CGRectMake(0*Width,20*Width,CXCWidth,76*Width);
        orderNumberLabel.tag =333;
        orderNumberLabel.textColor = TextColor;
        //状态
        UILabel* orderStatuerLabel  = [[UILabel alloc]init];
        orderStatuerLabel.font = [UIFont systemFontOfSize:14];
        orderStatuerLabel.text = @"待审核";
        orderStatuerLabel.tag =334;

        orderStatuerLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:orderStatuerLabel];
        orderStatuerLabel.frame= CGRectMake(400*Width,20*Width,325*Width,76*Width);
        orderStatuerLabel.textColor = NavColor;
        
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0,orderStatuerLabel.bottom, CXCWidth, 220*Width)];
        bgView.backgroundColor = BGColor;
        [self addSubview:bgView];
        
        
        
        _goodsImgView =[[EGOImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _goodsImgView.backgroundColor =BGColor;
        _goodsImgView.frame=CGRectMake(50*Width, 30*Width, 160*Width, 160*Width);
        [bgView addSubview:_goodsImgView];
        
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+60*Width,20*Width, 310*Width, 100*Width)];
//        _goodsTitleLab.text = @"商品A-21饮清新养元茶";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.numberOfLines =0;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        
        //价格
        UILabel* priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+60*Width,_goodsTitleLab.bottom+20*Width, 360*Width, 50*Width)];
//        priceLabel.text =@"¥400.00";
        priceLabel.font =[UIFont systemFontOfSize:16];
        priceLabel.textColor =NavColor;
        [bgView addSubview:priceLabel];
        _priceLab =priceLabel;
        
        UIView *middleView =[[UIView alloc]initWithFrame:CGRectMake(0, bgView.bottom, CXCWidth, 82*Width)];
        
        [middleView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:middleView];
        //描述
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,400*Width,82*Width)];
        [middleView addSubview:_promptLabel];
        _promptLabel.textColor  =BlackColor;
        _promptLabel.textAlignment =NSTextAlignmentRight;
        _promptLabel.font =[UIFont systemFontOfSize:13];
        _promptLabel.text = @"共计1箱2盒";
        
        _allPricesLabel = [[UILabel alloc]initWithFrame:CGRectMake(420*Width,0,320*Width,82*Width)];
        [middleView addSubview:_allPricesLabel];
        _allPricesLabel.textColor  =BlackColor;
                _allPricesLabel.font =[UIFont systemFontOfSize:13];
        
        UIImageView *xianImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 80.5*Width, CXCWidth, 1.5*Width)];
        xianImgV.backgroundColor =BGColor;
        [middleView addSubview:xianImgV];
       
        
        //背景378
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =BGColor;
        [self addSubview:bgview];
        bgview.frame =CGRectMake(0, middleView.bottom, CXCWidth, 82*Width);
        
        bgview.backgroundColor =[UIColor whiteColor];
        
        {
            //系统计算按钮
            _seeBtn = [[UIButton alloc]init];
            [_seeBtn setBackgroundColor:[UIColor whiteColor]];
            [_seeBtn.layer setCornerRadius:2];
            [_seeBtn.layer setBorderWidth:1];
            [_seeBtn.layer setMasksToBounds:YES];
            [_seeBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
            [_seeBtn setTitle:@"详情" forState:UIControlStateNormal];
            [_seeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_seeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _seeBtn.layer.borderColor =TextGrayColor.CGColor;
            [bgview addSubview:_seeBtn];
            _seeBtn.tag=130;
//            _seeBtn.hidden=YES;
            //取消订单
            _rejectBtn = [[UIButton alloc]init];
            [_rejectBtn setBackgroundColor:[UIColor whiteColor]];
            [_rejectBtn.layer setCornerRadius:2];
            [_rejectBtn.layer setBorderWidth:1];
            [_rejectBtn.layer setMasksToBounds:YES];
            [_rejectBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
            [_rejectBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            _rejectBtn.tag=131;
            
            [_rejectBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_rejectBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _rejectBtn.layer.borderColor =TextGrayColor.CGColor;
            [bgview addSubview:_rejectBtn];

            //去支付
            _deliverBtn = [[UIButton alloc]init];
            [_deliverBtn setBackgroundColor:[UIColor whiteColor]];
            [_deliverBtn.layer setCornerRadius:2];
            [_deliverBtn.layer setBorderWidth:1];
            [_deliverBtn.layer setMasksToBounds:YES];
            [_deliverBtn setTitleColor:NavColor forState:UIControlStateNormal];
            [_deliverBtn setTitle:@"去支付" forState:UIControlStateNormal];
            _deliverBtn.tag=132;
            [_deliverBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_deliverBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _deliverBtn.layer.borderColor =NavColor.CGColor;
            [bgview addSubview:_deliverBtn];
            
            
            //查看物流
            _seeLogBtn = [[UIButton alloc]init];
            [_seeLogBtn setBackgroundColor:[UIColor whiteColor]];
            [_seeLogBtn.layer setCornerRadius:2];
            [_seeLogBtn.layer setBorderWidth:1];
            [_seeLogBtn.layer setMasksToBounds:YES];
            [_seeLogBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
            [_seeLogBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            _seeLogBtn.tag=133;
            
            [_seeLogBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_seeLogBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _seeLogBtn.layer.borderColor =TextGrayColor.CGColor;
            [bgview addSubview:_seeLogBtn];

            
            
            //确认收货
            _tureBtn = [[UIButton alloc]init];
            [_tureBtn setBackgroundColor:[UIColor whiteColor]];
            [_tureBtn.layer setCornerRadius:2];
            [_tureBtn.layer setBorderWidth:1];
            [_tureBtn.layer setMasksToBounds:YES];
            [_tureBtn setTitleColor:NavColor forState:UIControlStateNormal];
            [_tureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            _tureBtn.tag=134;
            [_tureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_tureBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _tureBtn.layer.borderColor =NavColor.CGColor;
            [bgview addSubview:_tureBtn];
            
           
         

        }
    }
    
    
    
    


    return self;

}
- (void)btnAction:(UIButton *)btn
{
    [self.delegate btnClick:self andBtnActionTag:btn.tag];
    
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
    UILabel *oderNumLabel = [self viewWithTag:333];
    UILabel *statusLabel = [self viewWithTag:334];
    oderNumLabel.text =[NSString stringWithFormat:@"    订单号：%@",[_dic objectForKey:@"sn"]];
    if ([[_dic objectForKey:@"status"]isEqualToString:@"1"]) {
        statusLabel.text =@"待支付";

    }else if([[_dic objectForKey:@"status"]isEqualToString:@"2"])
    {
        statusLabel.text =@"待发货";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"3"])
    {
        statusLabel.text =@"待收货";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"4"])
    {
        statusLabel.text =@"已完成";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"5"])
    {
        statusLabel.text =@"已取消";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"6"])
    {
        statusLabel.text =@"已驳回";
    }
    _tureBtn.hidden = YES;
    _seeLogBtn.hidden = YES;
    _rejectBtn.hidden =YES ;
    _deliverBtn.hidden =YES ;

   if ([[_dic objectForKey:@"status"]isEqualToString:@"1"]) {
        [_deliverBtn setFrame:CGRectMake(610*Width,13.5*Width , 120*Width, 55*Width)];
        [_rejectBtn setFrame:CGRectMake(440*Width,13.5*Width , 150*Width, 55*Width)];
        [_seeBtn setFrame:CGRectMake(330*Width,13.5*Width , 90*Width, 55*Width)];
        _tureBtn.hidden = YES;
        _seeLogBtn.hidden = YES;
        _rejectBtn.hidden =NO;
        _deliverBtn.hidden =NO;
        
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"3"])
    {
        [_tureBtn setFrame:CGRectMake(590*Width,13.5*Width , 150*Width, 55*Width)];
        [_seeLogBtn setFrame:CGRectMake(410*Width,13.5*Width , 150*Width, 55*Width)];
        [_seeBtn setFrame:CGRectMake(300*Width,13.5*Width , 90*Width, 55*Width)];
        _rejectBtn.hidden =YES;
        _deliverBtn.hidden =YES;
        _tureBtn.hidden = NO;
        _seeLogBtn.hidden = NO;
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"4"])
    {
//        [_tureBtn setFrame:CGRectMake(590*Width,13.5*Width , 150*Width, 55*Width)];
        [_seeLogBtn setFrame:CGRectMake(590*Width,13.5*Width , 150*Width, 55*Width)];
        [_seeBtn setFrame:CGRectMake(480*Width,13.5*Width , 90*Width, 55*Width)];
        _rejectBtn.hidden =YES;
        _deliverBtn.hidden =YES;
        _tureBtn.hidden = YES;
        _seeLogBtn.hidden = NO;
    }else
    {
        [_seeBtn setFrame:CGRectMake(650*Width,13.5*Width , 90*Width, 55*Width)];
    }

    NSArray *goods =[_dic objectForKey:@"goods"];
    _promptLabel.text =[NSString stringWithFormat:@"共计%ld种商品",goods.count];
    NSString*str =[NSString stringWithFormat:@"总金额：¥%@",[_dic objectForKey:@"total"] ];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [_allPricesLabel setAttributedText:textColor];
    
    _goodsImgView.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[goods[0] objectForKey:@"img"]]];
    _goodsTitleLab.text =[NSString stringWithFormat:@"%@", [PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[goods[0] objectForKey:@"name"]]]];
    _priceLab.text =[NSString stringWithFormat:@"%@", [PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[goods[0] objectForKey:@"price"]]]];

    
    


    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setStatus:(NSString *)status
{
   
}

@end
