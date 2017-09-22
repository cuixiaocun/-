//
//  ActivityCell.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        
        //图片
        _photoImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
        _photoImageV.backgroundColor =BGColor;
        _photoImageV.frame=CGRectMake(24*Width, 30*Width, 194*Width, 194*Width);
        [self addSubview:_photoImageV];
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_photoImageV.right+24*Width,_photoImageV.top, 460*Width, 90*Width)];
        _nameLabel.text = @"2017爱意思锐国民第一家散发睡眠采购节！！！！";
        _nameLabel.textColor=[UIColor blackColor];
        _nameLabel.numberOfLines =0;
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        
        //地址
        UIImageView *riliImgV =[[UIImageView alloc]initWithFrame:CGRectMake(_photoImageV.right+24*Width, _nameLabel.bottom+10*Width,30*Width, 30*Width)];
        riliImgV.image =[UIImage imageNamed:@"hd_icon_time"];
        [self addSubview:riliImgV];
        
        
        
        
        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(riliImgV.right+24*Width, _nameLabel.bottom,460*Width, 50*Width)];
        _timeLabel.numberOfLines =0;
        _timeLabel.text =@"2017年09月09日-2017年09月19日";
        _timeLabel.font =[UIFont systemFontOfSize:13];
        _timeLabel.textColor =TextColor;
        [self addSubview:_timeLabel];
        
       UIImageView *addressImgV =[[UIImageView alloc]initWithFrame:CGRectMake(_photoImageV.right+24*Width, _timeLabel.bottom+10*Width,30*Width, 30*Width)];
        addressImgV.image =[UIImage imageNamed:@"hd_icon_location"];
        [self addSubview:addressImgV];
        

        _addressLabel =[[UILabel alloc]initWithFrame:CGRectMake(addressImgV.right+24*Width, _timeLabel.bottom,460*Width, 50*Width)];
        _addressLabel.numberOfLines =0;
        _addressLabel.text =@"高新区古德广场b1乐活城";
        _addressLabel.font =[UIFont systemFontOfSize:13];
        _addressLabel.textColor =TextColor;
        [self addSubview:_addressLabel];
             //毕业院校
        _phoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(_photoImageV.right+24*Width,_addressLabel.bottom, 460*Width, 50*Width)];
        _phoneLabel.text =@"客服电话：0849-0093442";
        _phoneLabel.font =[UIFont systemFontOfSize:13];
        _phoneLabel.textColor =TextColor;
        [self addSubview:_phoneLabel];
        //面积
        _numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(_photoImageV.right+24*Width, _phoneLabel.bottom, 460*Width, 50*Width)];
        _numberLabel.text =@"报名人数：200人";
        _numberLabel.font =[UIFont systemFontOfSize:13];
        _numberLabel.textColor =TextGrayColor;
        [self addSubview:_numberLabel];
        //线
        _xianImageV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width,340*Width-1.5*Width, 690*Width, 1.5*Width)];
        _xianImageV.backgroundColor =BGColor;
        [self addSubview:_xianImageV];
        
        _xian=[[UIImageView alloc]initWithFrame:CGRectMake(_photoImageV.right+24*Width,_addressLabel.bottom, 630*Width,3*Width)];
        [self addSubview:_xian];
        _xian.image =[UIImage imageNamed:@"sjs_icon_dotte"];
        //下一步按钮
        UIButton*nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setFrame:CGRectMake(0*Width,_xianImageV.bottom , CXCWidth, 90*Width)];
        [nextBtn setBackgroundColor:NavColorWhite];
        [nextBtn.layer setCornerRadius:4];
        [nextBtn.layer setMasksToBounds:YES];
        [nextBtn setTitle:@"立即报名" forState:UIControlStateNormal];
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
    
    
}
@end
