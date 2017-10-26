//
//  DecorateFourCell.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateFourCell.h"

@implementation DecorateFourCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //shang边文字
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*Width,0*Width,600*Width,90*Width)];
        _titleLabel.font =[UIFont systemFontOfSize:14];
        _titleLabel.text =@"住宅风水事项有哪些？";
        _titleLabel.textColor =BlackColor;
        [self addSubview:_titleLabel];
        
        UIImageView *addressImgV =[[UIImageView alloc]initWithFrame:CGRectMake(34*Width, _titleLabel.bottom+30*Width,40*Width, 20*Width)];
        addressImgV.image =[UIImage imageNamed:@"lt_icon_liulan_line"];
        [self addSubview:addressImgV];
        
        
        _seeLabel=[[UILabel alloc]initWithFrame:CGRectMake(addressImgV.right+24*Width, _titleLabel.bottom,100*Width, 80*Width)];
        _seeLabel.numberOfLines =0;
        _seeLabel.text =@"10";
        _seeLabel.font =[UIFont systemFontOfSize:12];
        _seeLabel.textColor =TextColor;
        [self addSubview:_seeLabel];
        
        UIImageView *talkImgV =[[UIImageView alloc]initWithFrame:CGRectMake(_seeLabel.right+20*Width, _titleLabel.bottom+25*Width,30*Width, 30*Width)];
        talkImgV.image =[UIImage imageNamed:@"lt_icon_pinglun_line"];
        [self addSubview:talkImgV];
        
        
        _talkLabel=[[UILabel alloc]initWithFrame:CGRectMake(talkImgV.right+24*Width, _titleLabel.bottom,100*Width, 80*Width)];
        _talkLabel.numberOfLines =0;
        _talkLabel.text =@"10";
        _talkLabel.font =[UIFont systemFontOfSize:12];
        _talkLabel.textColor =TextColor;
        [self addSubview:_talkLabel];
        
        
        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(_talkLabel.right+24*Width, _titleLabel.bottom, 300*Width, 80*Width)];
        _timeLabel.text =@"2017-09-08 11:12:12";
        _timeLabel.font =[UIFont systemFontOfSize:13];
        _timeLabel.textColor =TextGrayColor;
        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:_timeLabel];
        //
        UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(20*Width,183.5*Width,710*Width,1.5*Width)];
        xianV.backgroundColor =BGColor;
        [self addSubview:xianV];
        
        
    }
    return self;
}
- (void)myBtnAciton:(UIButton *)btn
{
    
    
}
-(void)setDic:(NSDictionary *)dic
{
    _dic=dic;
    self.titleLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"title"]];
    self.timeLabel.text =[NSString stringWithFormat:@"%@",[PublicMethod timeWithTimeIntervalString:[NSString  stringWithFormat:@"%d",[[_dic objectForKey:@"dateline"] integerValue ]]]];
    self.seeLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"views"]];
    self.talkLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"answer_num"]];
    
}

@end
