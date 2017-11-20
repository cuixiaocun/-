//
//  ShopStoreOneMainCell.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopStoreOneMainCell.h"

@implementation ShopStoreOneMainCell
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
                
                NSString *titleContent =@"商家名称：山东桥通天下网络科技有限公司.";
                CGSize titleSize;//通过文本得到高度
                titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                proLabel.text = titleContent;
                proLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
                _titleLabel =proLabel;
                
                
            }else if (i==1)
            {
                proLabel.text = @"联系人:张勇";
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
                proLabel.text = @"主营行业：基础建筑";
                proLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
                _qqLabel =proLabel;
                
            }
            else if (i==4)
            {
                NSString *ideaContent =@"所在地点：山东省潍坊市寒亭区胜利街与新华路西南角战天下潍坊国际2203号";
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
    
    NSString *titleContent =[NSString stringWithFormat:@"商家名称：%@",[_dic  objectForKey:@"title"]];
    CGSize titleSize;//通过文本得到高度
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _titleLabel.text = titleContent;
    _titleLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
    _companyLabel.text = [NSString stringWithFormat:@"联系人:%@",@""];
//    _companyLabel.text = [NSString stringWithFormat:@"联系人:%@",[_dic  objectForKey:@""]];
    _companyLabel.frame =CGRectMake(24*Width ,_titleLabel.bottom, 690*Width,70*Width);
    _phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",[_dic  objectForKey:@"phone"]];
    _phoneLabel.frame =CGRectMake(24*Width ,_companyLabel.bottom, 690*Width,70*Width);
    _qqLabel.text =[NSString stringWithFormat:@"主营行业：%@",[_dic  objectForKey:@"cat_title"]];
    _qqLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
    NSString *ideaContent =[NSString stringWithFormat:@"所在地点：%@",[_dic  objectForKey:@"addr"]];
    CGSize ideaSize;//通过文本得到高度
    ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _ideaLabel .numberOfLines =0;
    _ideaLabel.text = ideaContent ;
    _ideaLabel.frame =CGRectMake(24*Width ,_qqLabel.bottom, 690*Width,ideaSize.height);
    
    
    
}




@end
