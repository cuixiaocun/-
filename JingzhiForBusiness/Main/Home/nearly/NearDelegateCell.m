//
//  NearDelegateCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/24.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "NearDelegateCell.h"

@implementation NearDelegateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 18*Width);
        NSArray*leftArr =@[@"官方授权合伙人",@"代理地区",@"距离",@"注册时间",@"",@"",@"",@"",@"",] ;
        NSArray*rightArr =@[@"",@"",@"",@"",@"",] ;
        
        for (int i=0; i<4; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,300*Width , 82*Width)];
            labe.text = leftArr[i];
            //            labe.textAlignment=NSTextAlignmentLeft;
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BlackColor;
            [bgview addSubview:rightLabel];
            //分割线
            if (i<5) {
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [bgview addSubview:xian];
                xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
            }
           
            
        }
        
        
        
        
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel *nameLabel =[self viewWithTag:200];
    UILabel *addressLabel =[self viewWithTag:201];
    UILabel *distanceLabel =[self viewWithTag:202];
//    UILabel *addressLabel =[self viewWithTag:204];
//    UILabel *distanceLabel =[self viewWithTag:205];
    UILabel *timeLabel =[self viewWithTag:203];
    timeLabel.text = [PublicMethod stringNilString:[_dic objectForKey:@"createtime"]];
    nameLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]]];
//    telLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone"]] ];
//    wxLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"webchat"]]];
    addressLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name_path"]]];
    if([[_dic objectForKey:@"juli"] floatValue]>100)
    {
        distanceLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%.2fkm",[[_dic objectForKey:@"juli"] floatValue]/1000.00]];
        
        
    }else
    {
        distanceLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%.2fm",[[_dic objectForKey:@"juli"] floatValue]]];
        
        
    }
    
}
-(NSString*)stringNilString:(NSString *)string
{
    
   NSString* selfString =[NSString stringWithFormat:@"%@", IsNilString(string)?@"":string];
    return selfString;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
