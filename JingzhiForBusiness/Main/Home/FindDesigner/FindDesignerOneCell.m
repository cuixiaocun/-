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
                
                
                _titleLabel =proLabel;
  
            }else if (i==1)
            {
               
                _companyLabel =proLabel;

            }else if (i==2)
            {
                _phoneLabel =proLabel;
                
            }
            else if (i==3)
            {
                
                _qqLabel =proLabel;
                
            }
            else if (i==4)
            {
                
                _ideaLabel =proLabel;
                
            }
            
            
        }
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    NSString *titleContent =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"about"]];
    CGSize titleSize;//通过文本得到高度
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _titleLabel.text = titleContent;
    _titleLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
    _companyLabel.text =[NSString stringWithFormat:@"公司名称:%@",[_dic objectForKey:@"company_name"]];
    _companyLabel.frame =CGRectMake(24*Width ,_titleLabel.bottom, 690*Width,70*Width);
    _phoneLabel.text =[NSString stringWithFormat:@"联系方式:%@",[_dic objectForKey:@"mobile"]] ;
    _phoneLabel.frame =CGRectMake(24*Width ,_companyLabel.bottom, 690*Width,70*Width);
    _qqLabel.text =[NSString stringWithFormat:@"联系QQ:%@",[_dic objectForKey:@"qq"]] ;
    _qqLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
    NSString *ideaContent =[NSString stringWithFormat:@"设计理念:%@",[_dic objectForKey:@"slogan"]];
    CGSize ideaSize;//通过文本得到高度
    ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _ideaLabel .numberOfLines =0;
    _ideaLabel.text = ideaContent ;
    _ideaLabel.frame =CGRectMake(24*Width ,_qqLabel.bottom, 690*Width,ideaSize.height);
    
   
}


@end
