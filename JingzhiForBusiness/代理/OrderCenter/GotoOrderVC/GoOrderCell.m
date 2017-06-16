//
//  GoOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoOrderCell.h"

@implementation GoOrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor =BGColor;
        
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 180*Width)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 380*Width, 100*Width)];
        _goodsTitleLab.text = @"商品A-几万块合法";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //数量（箱盒）
        _numTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(360*Width, 0, 200*Width,100*Width)];
        _numTitleLab.text = @"4531盒";
        _numTitleLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _numTitleLab.font =[UIFont systemFontOfSize:14];
        _numTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_numTitleLab];
        
        
        UIButton *numBtn =[[UIButton alloc]initWithFrame:CGRectMake(578*Width, 30*Width, 78*Width, 48*Width)];
        [bgView addSubview:numBtn];
        numBtn.tag =10;
        [numBtn.layer setBorderWidth:1.0*Width];
        numBtn.layer.borderColor =BGColor.CGColor;
        [numBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //购买商品的数量
        _numCountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0*Width, 78*Width, 48*Width)];
        _numCountLab.text =@"10";
        _numTitleLab.font =[UIFont systemFontOfSize:14];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        [numBtn addSubview:_numCountLab];
        
        
        
        //减按钮
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(530*Width, 30*Width, 48*Width, 48*Width);
        [_deleteBtn setImage:[UIImage imageNamed:@"register_btn_reduce_modify_black"] forState:UIControlStateNormal];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(8*Width, 8*Width,8*Width, 8*Width);
        [_deleteBtn.layer setBorderWidth:1.0*Width];
        _deleteBtn.layer.borderColor =BGColor.CGColor;
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        [bgView addSubview:_deleteBtn];
        
        
        //加按钮
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(656*Width, 30*Width, 48*Width, 48*Width);
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(8*Width, 8*Width,8*Width, 8*Width);
        
        [_addBtn.layer setBorderWidth:1.0*Width];
        _addBtn.layer.borderColor =BGColor.CGColor;
        [_addBtn setImage:[UIImage imageNamed:@"register_btn_add_modify_black"] forState:UIControlStateNormal];
        
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        [bgView addSubview:_addBtn];
        
        UIImageView *xian =[[UIImageView alloc]init];
        xian.frame =CGRectMake(0, 100*Width, CXCWidth, 2*Width);
        xian.backgroundColor =BGColor;
        [bgView addSubview:xian];
        
        
        //下单
        UIButton* goOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        goOrderBtn.frame = CGRectMake(601*Width,xian.bottom+ 14*Width, 90*Width, 50*Width);
        
        [goOrderBtn.layer setBorderWidth:1.0*Width];
        goOrderBtn.layer.borderColor =NavColor.CGColor;
        [goOrderBtn.layer setCornerRadius:4*Width];
        [goOrderBtn.layer setMasksToBounds:YES];
        
        [goOrderBtn setTitleColor:NavColor forState:UIControlStateNormal];
        [goOrderBtn setTitle:@"下单" forState:UIControlStateNormal];
        [goOrderBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];

        [goOrderBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
        goOrderBtn.tag = 13;
        [bgView addSubview:goOrderBtn];
        
        
        [self addSubview:bgView];

        
        
        
        
        
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
//    _goodsTitleLab.text = goodsModel.goodsTitle;//名字
//    _priceLab.text = [NSString stringWithFormat:@"¥%@",goodsModel.goodsPrice];//单价
//    _numCountLab.text = [NSString stringWithFormat:@"%d",goodsModel.goodsNum];//数量
//    NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",goodsModel.goodsTotalPrice];//总和
//    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
//    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
//    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
//    [  _priceTotalLab setAttributedText:textColor];
//    
    //    NSInteger i=totalString.length;
    //
    //    NSRange rangel2 = [[textColor string] rangeOfString:[totalString substringFromIndex:i-2]];
    //
    //    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel2];
    
    
//    //假设是6盒为一箱
//    if ([[NSString stringWithFormat:@"%d",goodsModel.goodsNum] intValue]<6) {
//        //不满一箱
//        _numTitleLab.text =  [NSString stringWithFormat:@"%ld盒",[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]%6];
//    }else
//    {
//        //满一箱
//        if ([[NSString stringWithFormat:@"%d",goodsModel.goodsNum] intValue]%6>0) {
//            //不是整箱
//            _numTitleLab.text =[NSString stringWithFormat:@"%ld箱%ld盒",[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]/6,[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]%6];
//            
//        }else
//        {
//            //是整箱
//            _numTitleLab.text =[NSString stringWithFormat:@"%ld箱",[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]/6];
//        }
//        
//    }
    
}

/**
 *  点击减按钮实现数量的减少
 *
 *  @param sender 减按钮
 */
-(void)deleteBtnAction:(UIButton *)sender
{
    //调用代理
    [self.delegate goOrderBtnClick:self andActionTag:sender.tag];
    
}
/**
 *  点击加按钮实现数量的增加
 *
 *  @param sender 加按钮
 */
-(void)addBtnAction:(UIButton *)sender
{
    
    //调用代理
    [self.delegate goOrderBtnClick:self andActionTag:sender.tag];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)numBtnAction:(UIButton *)btn
{
    [self.delegate goOrderBtnClick:self andActionTag:btn.tag];

}
-(void)detail:(UIButton *)btn
{
    [self.delegate goOrderBtnClick:self andActionTag:btn.tag];

}
@end
