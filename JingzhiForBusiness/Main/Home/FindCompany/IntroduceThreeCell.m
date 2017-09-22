//
//  IntroduceThreeCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "IntroduceThreeCell.h"

@implementation IntroduceThreeCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor whiteColor];
        for (int i=0; i<4; i++) {
            UILabel* proLabel = [[UILabel alloc]init];
            proLabel.numberOfLines =0;
            proLabel.textColor = TextColor;
            proLabel.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:proLabel];
            if (i==0)
            {
                proLabel.text = @"公司：潍坊";
                proLabel.frame =CGRectMake(24*Width ,_titleLabel.bottom, 690*Width,70*Width);
                _companyLabel =proLabel;
                
            }else if (i==1)
            {
                proLabel.text = @"地址：山东省潍坊市奎文区胜利街新华路中天下2222";
                proLabel.frame =CGRectMake(24*Width ,_companyLabel.bottom, 690*Width,100*Width);
                proLabel.numberOfLines =0;
                _addressLabel =proLabel;
                
            }
            else if (i==2)
            {
                proLabel.text = @"电话：18719902033";
                proLabel.frame =CGRectMake(24*Width ,_addressLabel.bottom, 690*Width,70*Width);
                _phoneLabel =proLabel;
                
            }
            else if (i==3)
            {
                proLabel.text = @"qq：187199033";
                proLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
                _qqLabel =proLabel;
                
                
            }
            
            
        }
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    
    
}

@end
