//
//  DecorateThreeCell.m
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateThreeCell.h"

@implementation DecorateThreeCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0,0,336*Width,255*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.backgroundColor =[UIColor redColor];
        [self addSubview:btn];
        //上边图片
        _topMCImage=[[EGOImageView alloc]initWithFrame:CGRectMake(0,0,336*Width,255*Width)];
        _topMCImage.image =[UIImage imageNamed:@"timg-8.jpeg"];
        [btn addSubview:_topMCImage];
        
        UIView *tmView =[[UIView alloc]initWithFrame:CGRectMake(0,0,336*Width,255*Width)];
        tmView.alpha =0.3;
        tmView.backgroundColor =[UIColor blackColor];
        [btn addSubview:tmView];
        //橘黄色的
        _orangeLabel   =[[UILabel alloc]initWithFrame:CGRectMake(176*Width,15*Width,160*Width,40*Width)];
        _orangeLabel.textAlignment=NSTextAlignmentCenter;
        _orangeLabel.text =@"木工阶段";
        _orangeLabel.backgroundColor=orangeColor;
        _orangeLabel.textColor =[UIColor whiteColor];
        _orangeLabel.font =[UIFont systemFontOfSize:12];
        [btn addSubview:_orangeLabel];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.orangeLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(20*Width, 20*Width)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _orangeLabel.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        self.orangeLabel.layer.mask = maskLayer;
        
        
        
        //shang边文字
        _styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20*Width,_orangeLabel.bottom+15*Width,296*Width,50*Width)];
        _styleLabel.textAlignment=NSTextAlignmentCenter;
        _styleLabel.font =[UIFont systemFontOfSize:13];
        _styleLabel.text =@"焕然一新~打美式";
        _styleLabel.textColor =[UIColor whiteColor];
        [btn addSubview:_styleLabel];
        
        //中间文字
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(20*Width,_styleLabel.bottom,296*Width,50*Width)];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font =[UIFont systemFontOfSize:12];
        _nameLabel.text =@"东方世纪城";
        _nameLabel.textColor =[UIColor whiteColor];
        [btn addSubview:_nameLabel];
        //下边文字
        _contentLabel   =[[UILabel alloc]initWithFrame:CGRectMake(20*Width,_nameLabel.bottom,296*Width,50*Width)];
        _contentLabel.textAlignment=NSTextAlignmentCenter;
        _contentLabel.text =@"两室一厅一卫";
        _contentLabel.textColor =[UIColor whiteColor];
        _contentLabel.font =[UIFont systemFontOfSize:12];
        _contentLabel.textColor =[UIColor whiteColor];
        [btn addSubview:_contentLabel];

        self.backgroundColor =[UIColor redColor];
        self.decorateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,_topMCImage.bottom,150*Width,70*Width)];
        self.decorateLabel.textColor = TextColor;
        self.decorateLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.decorateLabel.backgroundColor = [UIColor clearColor];
        self.decorateLabel.text =@"装修:全包";
        [self.contentView addSubview:self.decorateLabel];

        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(150*Width,_topMCImage.bottom,184*Width,70*Width)];
        self.priceLabel.textColor = TextColor;
        _priceLabel.textAlignment =NSTextAlignmentRight;
        self.priceLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.text =@"均价:19304元";
        [self.contentView addSubview:self.priceLabel];

        
    }
    return self;
}
- (void)myBtnAciton:(UIButton *)btn
{


}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [_topMCImage sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]]];
    self.styleLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"title"]];
    self.nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"home_name"]];
    self.contentLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"type_title"]];
    self.orangeLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"status_title"]];
    self.decorateLabel.text =[NSString stringWithFormat:@"装修：%@",[_dic objectForKey:@"way_title"]];
    self.priceLabel.text =[NSString stringWithFormat:@"总价:%@元",[_dic objectForKey:@"total_price"]];
}



@end
