//
//  FindDesignerCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FindDesignerCell.h"

@implementation FindDesignerCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        
        //图片
        _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
        _phoneImageV.backgroundColor =BGColor;
        _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 194*Width, 194*Width);
        [self addSubview:_phoneImageV];
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_phoneImageV.top, 460*Width, 50*Width)];
        _nameLabel.text = @"王涛";
        _nameLabel.textColor=[UIColor blackColor];
        _nameLabel.numberOfLines =0;
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        
        //案例
        _caseLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width, _nameLabel.bottom,500*Width, 50*Width)];
        _caseLabel.numberOfLines =0;
        _caseLabel.text =@"案例：30套";
        _caseLabel.font =[UIFont systemFontOfSize:14];
        _caseLabel.textColor =TextColor;
        [self addSubview:_caseLabel];
    
        //毕业院校
        _collegesLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_caseLabel.bottom, 500*Width, 50*Width)];
        _collegesLabel.text =@"毕业院校";
        _collegesLabel.font =[UIFont systemFontOfSize:14];
        _collegesLabel.textColor =TextColor;
        [self addSubview:_collegesLabel];
        //设计理念
        _ideaLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width, _collegesLabel.bottom, 500*Width, 50*Width)];
        _ideaLabel.text =@"设计理念：房屋装修以简约现代为主，金属粉还低中国风 ";
        _ideaLabel.font =[UIFont systemFontOfSize:13];
        _ideaLabel.textColor =TextGrayColor;
        [self addSubview:_ideaLabel];
        //线
        _xianImageV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width,250*Width-1.5*Width, 690*Width, 1.5*Width)];
        _xianImageV.backgroundColor =BGColor;
        [self addSubview:_xianImageV];
        
        //下一步按钮
        UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setFrame:CGRectMake(0*Width,_xianImageV.bottom , CXCWidth, 90*Width)];
        [nextBtn setBackgroundColor:NavColorWhite];
        [nextBtn.layer setCornerRadius:4];
        [nextBtn.layer setMasksToBounds:YES];
        [nextBtn setTitle:@"免费预约" forState:UIControlStateNormal];
        [nextBtn setTitleColor:orangeColor forState:UIControlStateNormal];
        _appointmentBtn =nextBtn;
        [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [nextBtn addTarget:self action:@selector(appointmentBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        
        //线
        UIImageView*  imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width,_appointmentBtn.bottom,CXCWidth, 20*Width)];
        imageV.backgroundColor =BGColor;
        [self addSubview:imageV];
        
        
    }
    return self;
    
}
- (void)appointmentBtnAction
{
    [self.delegate btnClick:self andBtnActionTag:0];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [_phoneImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"face"]]]];
    _nameLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"uname"])?@"":[dic objectForKey:@"uname"]];
    
    _caseLabel.text =[NSString stringWithFormat:@"案例:%@套", IsNilString([dic  objectForKey:@"case_num"])?@"":[dic objectForKey:@"case_num"]];
    _collegesLabel.text =[NSString stringWithFormat:@"毕业院校:%@", IsNilString([dic  objectForKey:@"school"])?@"":[dic objectForKey:@"school"]];
    _ideaLabel.text =[NSString stringWithFormat:@"设计理念:%@", IsNilString([dic  objectForKey:@"slogan"])?@"":[dic objectForKey:@"slogan"]];

}

@end
