//
//  FindDesignerOneCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FindDesignerOneCell.h"

@implementation FindDesignerOneCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor whiteColor];
        for (int i=0; i<5; i++) {
            UILabel* proLabel = [[UILabel alloc]init];
            proLabel.numberOfLines =0;
            proLabel.textColor = TextColor;
            proLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:proLabel];
            if (i==0) {
                
                NSString *titleContent =@"个人简介：看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美.";
                CGSize titleSize;//通过文本得到高度
                titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                proLabel.text = titleContent;
                proLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
                _titleLabel =proLabel;
                
  
            }else if (i==1)
            {
                proLabel.text = @"所在地区：潍坊";
                proLabel.frame =CGRectMake(24*Width ,_titleLabel.bottom, 690*Width,70*Width);
                _companyLabel =proLabel;

            }else if (i==2)
            {
                proLabel.text = @"联系方式：18363671733";
                proLabel.frame =CGRectMake(24*Width ,_companyLabel.bottom, 690*Width,70*Width);
                _phoneLabel =proLabel;
                
            }
            else if (i==3)
            {
                proLabel.text = @"联系QQ：199020332";
                proLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
                _qqLabel =proLabel;
                
            }
            else if (i==4)
            {
                NSString *ideaContent =@"设计理念：看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美。";
                CGSize ideaSize;//通过文本得到高度
                ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                proLabel .numberOfLines =0;
                proLabel.text = ideaContent ;
                proLabel.frame =CGRectMake(24*Width ,_qqLabel.bottom, 690*Width,ideaSize.height);
                _ideaLabel =proLabel;
                
            }
            
            
        }
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    
    
}


@end
