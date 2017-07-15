//
//  SearchCellTableViewCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/15.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "SearchCellTableViewCell.h"

@implementation SearchCellTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 18*Width);
        NSArray*leftArr =@[@"代理帐号",@"代理名称",@"电话",@"微信",@"代理地区",@"距离",@"",@"",@"",@"",@"",@"",] ;
        NSArray*rightArr =@[@"18363671722",@"山东桥通天下网络科技有限公司",@"18363672711",@"100000jof",@"山东省潍坊市奎文区",@"20Km",@"",@"",@"",@"",@"",] ;
        
        for (int i=0; i<6; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
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
    UILabel *numLabel =[self viewWithTag:200];
    UILabel *nameLabel =[self viewWithTag:201];
    UILabel *telLabel =[self viewWithTag:202];
    UILabel *wxLabel =[self viewWithTag:203];
    UILabel *addressLabel =[self viewWithTag:204];
    UILabel *distanceLabel =[self viewWithTag:205];
    
    numLabel.text = [PublicMethod stringNilString:[_dic objectForKey:@"account"]];
    nameLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]]];
    telLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone"]] ];
    wxLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"webchat"]]];
    addressLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name_path"]]];
    distanceLabel.text =[PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"juli"]]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
