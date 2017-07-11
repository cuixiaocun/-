//
//  GoodsCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/2.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 170*Width)];
        bgView.backgroundColor = [UIColor whiteColor];
        
     
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 380*Width, 100*Width)];
        _goodsTitleLab.text = @"";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //数量（箱盒）
        _numTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(380*Width, 0, 150*Width,100*Width)];
        _numTitleLab.text = @"";
        _numTitleLab.font =[UIFont systemFontOfSize:14];

        _numTitleLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];

        _numTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_numTitleLab];
        
        
        UIButton *numBtn =[[UIButton alloc]initWithFrame:CGRectMake(578*Width, 30*Width, 78*Width, 48*Width)];
//        numBtn.backgroundColor =[UIColor redColor];
        [bgView addSubview:numBtn];
        numBtn.tag =10;
        [numBtn.layer setBorderWidth:1.0*Width];
        numBtn.layer.borderColor =BGColor.CGColor;        

        [numBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //购买商品的数量
        _numCountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0*Width, 78*Width, 48*Width)];
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
        
        [self addSubview:bgView];
        //价格
        UILabel* priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 90*Width, 300*Width, 90*Width)];
        priceLabel.text =@"¥400.00";
        priceLabel.font =[UIFont systemFontOfSize:14];
        priceLabel.textColor =NavColor;
        [bgView addSubview:priceLabel];
        _priceLab =priceLabel;
        
        _priceTotalLab   =[[UILabel alloc]initWithFrame:CGRectMake(400*Width, 90*Width, 310*Width, 90*Width)];
        _priceTotalLab.text =@"¥3000.00";
        _priceTotalLab.textAlignment =NSTextAlignmentRight;
        _priceTotalLab.font =[UIFont systemFontOfSize:14];
        _priceTotalLab.textColor =TextColor;
        [bgView addSubview:_priceTotalLab];
        
       
        
        
        
        
        
        
    }
    return self;
}

/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(GoodsModel *)goodsModel
{
    _goodsTitleLab.text = goodsModel.goodsTitle;//名字
    _priceLab.text = [NSString stringWithFormat:@"¥%@",goodsModel.goodsPrice];//单价
    _numCountLab.text = [NSString stringWithFormat:@"%d",goodsModel.goodsNum];//数量
    NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",goodsModel.goodsTotalPrice];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [  _priceTotalLab setAttributedText:textColor];

//    NSInteger i=totalString.length;
//    
//    NSRange rangel2 = [[textColor string] rangeOfString:[totalString substringFromIndex:i-2]];
//
//    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel2];

    
    //假设是6盒为一箱
    if ([[NSString stringWithFormat:@"%d",goodsModel.goodsNum] intValue]<[goodsModel.boxnum integerValue]) {
        //不满一箱
       _numTitleLab.text =  [NSString stringWithFormat:@"%ld盒",[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]%[goodsModel.boxnum integerValue]];
    }else
    {
        //满一箱
        if ([[NSString stringWithFormat:@"%d",goodsModel.goodsNum] intValue]%[goodsModel.boxnum integerValue]>0) {
            //不是整箱
            _numTitleLab.text =[NSString stringWithFormat:@"%ld箱%ld盒",[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]/[goodsModel.boxnum integerValue],[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]%[goodsModel.boxnum integerValue]];
            
        }else
        {
            //是整箱
            _numTitleLab.text =[NSString stringWithFormat:@"%ld箱",[[NSString stringWithFormat:@"%d",goodsModel.goodsNum] integerValue]/[goodsModel.boxnum integerValue]];
        }
       
    }
    
}

/**
 *  点击减按钮实现数量的减少
 *
 *  @param sender 减按钮
 */
-(void)deleteBtnAction:(UIButton *)sender
{
          //调用代理
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    
}
/**
 *  点击加按钮实现数量的增加
 *
 *  @param sender 加按钮
 */
-(void)addBtnAction:(UIButton *)sender
{
   
        //调用代理
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    
}
- (void)numBtnAction:(UIButton *)sender
{
    
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
