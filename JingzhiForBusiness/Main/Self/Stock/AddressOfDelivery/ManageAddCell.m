//
//  ManageAddCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ManageAddCell.h"

@implementation ManageAddCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 20*Width);
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =BGColor;
        [self addSubview:bgview];
        bgview.frame =CGRectMake(0, xian.bottom, CXCWidth, 270*Width);
        //姓名
        nameLabe = [[UILabel alloc]initWithFrame:CGRectMake(24*Width, 20*Width ,160*Width , 50*Width)];
        nameLabe.text = @"孙类";
        nameLabe.font = [UIFont systemFontOfSize:16];
        nameLabe.textColor = BlackColor;
        bgview.backgroundColor =[UIColor whiteColor];
        [bgview addSubview:nameLabe];
        //电话
        telphoneLabel = [[UILabel alloc]init];
        telphoneLabel.text = @"18363671722";
        telphoneLabel.frame =CGRectMake(180*Width ,20*Width, 475*Width,50*Width );
        telphoneLabel.textColor = BlackColor;
        telphoneLabel.font = [UIFont systemFontOfSize:14];
        [bgview addSubview:telphoneLabel];
        //地址
        addressLabel = [[UILabel alloc]init];
        addressLabel.text = @"山东省潍坊市奎文区新话路与健康街交叉路口西宝鼎花园2208号";
        addressLabel.frame =CGRectMake(24*Width ,telphoneLabel.bottom, 670*Width,100*Width );
        addressLabel.textColor = TextGrayColor;
        addressLabel.numberOfLines =0;
        addressLabel.font = [UIFont systemFontOfSize:12];
        [bgview addSubview:addressLabel];
        //分割线
        UIImageView*fgXian =[[UIImageView alloc]init];
        fgXian.backgroundColor = BGColor;
        [bgview addSubview:fgXian];
        
        fgXian.frame =CGRectMake(24*Width,addressLabel.bottom+20*Width, CXCWidth, 1*Width);
        
        for (int i=0; i<3; i++) {
            UIButton *btn =[[UIButton alloc]init];
            btn.tag =110+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgview addSubview:btn];
            
            UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width,20*Width ,40*Width, 40*Width)];
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(imgV.right+20*Width, 0, 120*Width, 80*Width)];
            label.textColor =TextColor;
            label.font =[UIFont systemFontOfSize:13];
            if(i==0)
            {
              
                btn.frame =CGRectMake(24*Width, fgXian.bottom+10*Width, 270*Width, 80*Width);
                label.frame =CGRectMake(imgV.right+20*Width, 0, 250*Width, 80*Width);
                imgV.image=[UIImage imageNamed:@"adress_btn_radio"];
                _isSelectImg =imgV;
                label.text =@"设置成默认地址";
            }else if (i==1)
            {
                imgV.image=[UIImage imageNamed:@"adress_icon_edit"];
                btn.frame =CGRectMake(460*Width, fgXian.bottom+10*Width, 130*Width, 80*Width);
                label.text =@"编辑";
            }else
            {
                imgV.image=[UIImage imageNamed:@"adress_icon_del"];
                btn.frame =CGRectMake(610*Width, fgXian.bottom+10*Width, 130*Width, 80*Width);
                label.text =@"删除";

            }
            [btn addSubview:label];
            [btn addSubview:imgV];
            

        }
        
        
        
        
    }
    
    return self;
    
}
-(void)calculateTheGoods
{
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
//    c
    
    nameLabe.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    telphoneLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone"]];
    addressLabel.text =[NSString stringWithFormat:@"%@%@",[_dic objectForKey:@"name_path"],[_dic objectForKey:@"address"]];
    
    

    if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"isdefault"]] isEqualToString:@"1"]) {
        _isSelectImg.image =[UIImage imageNamed:@"adress_btn_radio_sel"];
        
    }else if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"isdefault"]] isEqualToString:@"2"])
    {
        _isSelectImg.image =[UIImage imageNamed:@"adress_btn_radio"];
    }
    
    
    
}
-(void)btnClick:(UIButton *)btn
{
    [self.delegate btnClick:self andTag:(int)btn.tag];


}
@end
