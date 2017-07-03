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
        bgView.tag =123;
        
        
        //商品名称
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 280*Width, 100*Width)];
        _goodsTitleLab.text = @"商品A-几万块合法";
        _goodsTitleLab.textColor=BlackColor;
        _goodsTitleLab.numberOfLines =0;
        _goodsTitleLab.font =[UIFont systemFontOfSize:14];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //数量（箱盒）
        _numTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(320*Width, 0, 200*Width,100*Width)];
        _numTitleLab.text = @"4531盒";
        _numTitleLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _numTitleLab.font =[UIFont systemFontOfSize:14];
        _numTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_numTitleLab];
        
        
        UIButton *numBtn =[[UIButton alloc]initWithFrame:CGRectMake(538*Width, 30*Width, 118*Width, 48*Width)];
        [bgView addSubview:numBtn];
        numBtn.tag =10;
        [numBtn.layer setBorderWidth:1.0*Width];
        numBtn.layer.borderColor =BGColor.CGColor;
        [numBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //购买商品的数量
        _numCountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0*Width, 118*Width, 48*Width)];
        _numCountLab.text =@"10";
        _numTitleLab.font =[UIFont systemFontOfSize:14];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        [numBtn addSubview:_numCountLab];
        
        
        
        //减按钮
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(490*Width, 30*Width, 48*Width, 48*Width);
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
        xian.tag =1011;
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
        goOrderBtn.tag = 131;
        [bgView addSubview:goOrderBtn];
        
        
        [self addSubview:bgView];

        
        
        
        
        
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    NSString *titleContent =[_dic objectForKey:@"name"];
    CGSize titleSize;//通过文本得到高度
    
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(270*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    _goodsTitleLab.height =  titleSize.height;
    _goodsTitleLab.frame =CGRectMake(40*Width, 20*Width, 280*Width, titleSize.height);

    _goodsTitleLab.text =[NSString   stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    _numTitleLab.text   = [NSString stringWithFormat:@"库存%@盒",[_dic objectForKey:@"stockNum"]];
    _numCountLab.text =[NSString stringWithFormat:@"%d",[[_dic objectForKey:@"num"] intValue]];
    UIImageView *xian =[self viewWithTag:1011];
    UIButton *goOrderBtn =[self viewWithTag:131];
    UIView *bgview =[self viewWithTag:123];
    bgview.frame =CGRectMake(0, 20*Width, CXCWidth, _goodsTitleLab.height+130*Width);

    xian.frame =CGRectMake(0,  bgview.bottom-100*Width, CXCWidth, 2*Width);
    goOrderBtn.frame = CGRectMake(601*Width,xian.bottom+ 14*Width, 90*Width, 50*Width);
    
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
