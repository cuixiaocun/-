//
//  HYMyRecommendCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYMyRecommendCell.h"
@implementation HYMyRecommendCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 20*Width);
        NSArray*leftArr =@[@"会员号",@"已消费",@"上次消费时间",@"报单量",@"报单金额",@"下单量",@"",@"",@"",@"",@"",@"",] ;
        NSArray*rightArr =@[@"18363671722",@"¥200000",@"2017-06-09 15：12：13",@"100000万",@"3单",@"",@"",@"",@"",@"",@"",] ;
        
        for (int i=0; i<3; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,270*Width , 82*Width)];
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
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [bgview addSubview:xian];
            xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
            
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
    UILabel *accountLabel =[self viewWithTag:200];
    UILabel *yixiaofeiLabel =[self viewWithTag:201];
    UILabel *timeLabel =[self viewWithTag:202];
    
    accountLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"account"]]];
    yixiaofeiLabel.text =[NSString stringWithFormat:@"%@",[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"sumall"]]]];
    timeLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"updatetime"]]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
