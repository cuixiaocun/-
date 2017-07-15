//
//  MyCustomCell.m
//  ShoppingList_Demo
//
//  Created by 李金华 on 15/4/20.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "MyCustomCell.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation MyCustomCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.backgroundColor =BGColor;
        
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 200*Width)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        UIButton *selectBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width, 0, 75*Width, 200*Width)];
        [bgView addSubview:selectBtn];
        
        [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(82.5*Width, 20*Width,82.5*Width, 20*Width)];
        selectBtn.tag = 9;
        [selectBtn setImage:[UIImage imageNamed:@"adress_btn_radio"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"adress_btn_radio_sel"] forState:UIControlStateSelected];

        [selectBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //图片
        _goodsImgView =[[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
        _goodsImgView.backgroundColor =BGColor;
        _goodsImgView.frame=CGRectMake(80*Width, 20*Width, 160*Width, 160*Width);
        [bgView addSubview:_goodsImgView];
        
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(80*Width, 20*Width, 350*Width, 160*Width)];
        [bgView addSubview:btn];
        btn.tag =8;
        [btn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        
    
        
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+30*Width,10*Width, 360*Width, 100*Width)];
        _goodsTitleLab.text = @"商品A-几万块合法";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.numberOfLines =0;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //价格
        UILabel* priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(_goodsImgView.right+30*Width, 140*Width, 360*Width, 60*Width)];
        priceLabel.text =@"¥400.00";
        priceLabel.font =[UIFont systemFontOfSize:16];
        priceLabel.textColor =NavColor;
        [bgView addSubview:priceLabel];
        _priceLab =priceLabel;
        

        
        
        UIButton *numBtn =[[UIButton alloc]initWithFrame:CGRectMake(578*Width, 120*Width, 78*Width, 68*Width)];
        //        numBtn.backgroundColor =[UIColor redColor];
        [bgView addSubview:numBtn];
        numBtn.tag =10;
        [numBtn.layer setBorderWidth:1.0*Width];
        numBtn.layer.borderColor =BGColor.CGColor;
        
        [numBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //购买商品的数量
        _numCountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0*Width, 78*Width, 68*Width)];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        [numBtn addSubview:_numCountLab];
        
        //减按钮
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(510*Width, 120*Width, 68*Width, 68*Width);
        [_deleteBtn setImage:[UIImage imageNamed:@"register_btn_reduce_modify_black"] forState:UIControlStateNormal];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(13*Width, 13*Width,13*Width, 13*Width);
        [_deleteBtn.layer setBorderWidth:1.0*Width];
        _deleteBtn.layer.borderColor =BGColor.CGColor;
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        [bgView addSubview:_deleteBtn];
        
        
        //加按钮
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(656*Width, 120*Width, 68*Width, 68*Width);
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(13*Width, 13*Width,13*Width, 13*Width);
        
        [_addBtn.layer setBorderWidth:1.0*Width];
        _addBtn.layer.borderColor =BGColor.CGColor;
        [_addBtn setImage:[UIImage imageNamed:@"register_btn_add_modify_black"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        [bgView addSubview:_addBtn];
        
    }
    return self;
}

/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(NSDictionary *)goodsModel
{
    _goodsImgView.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[goodsModel objectForKey:@"img"]]];
    _goodsTitleLab.text = [goodsModel objectForKey:@"goodsTitle" ];//名字
    _priceLab.text = [NSString stringWithFormat:@"¥%@",[goodsModel objectForKey:@"goodsPrice" ]];//单价
    _numCountLab.text = [NSString stringWithFormat:@"%@",[goodsModel objectForKey:@"goodsNum" ]];//数量
    NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",[goodsModel objectForKey:@"goodsTotalPrice" ]];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    UIButton *brtn =[self viewWithTag:9];
    brtn.selected =[[goodsModel objectForKey:@"selectState" ] boolValue];
    
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
- (void)nextPage:(UIButton*)sender
{
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];

}
@end
