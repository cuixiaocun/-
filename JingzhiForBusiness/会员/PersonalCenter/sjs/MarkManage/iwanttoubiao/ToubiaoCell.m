
//  ToubiaoCell.m
//  家装
//
//  Created by Admin on 2017/10/30.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ToubiaoCell.h"
@implementation ToubiaoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        NSArray*leftArr =@[@"半小时前",@"高新区恒大名都新房简装，预算大约4万以内qqq山东点点滴滴",@"看标需要消耗金币：50",@"允许看标的企业数：30",@"",@"",@"",];
        for (int i=0; i<4; i++){
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(25*Width, 0,700*Width , 80*Width)];
            labe.text = leftArr[i];
            labe.numberOfLines =0;
            labe.textAlignment=NSTextAlignmentLeft;
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            bgview.tag =300+i;

            if(i==0)
            {
                bgview.backgroundColor =BGColor;
                labe.tag =199;
                labe.numberOfLines =0;
                self.timeLabel  =labe;
            }else if (i==1)
            {
                self.countLabel  =labe;

            }else if (i==2)
            {
                self.payLabel  =labe;
                
            }else if (i==3)
            {
                self.numberLabel  =labe;
                
            }
            
        }
        
        
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)btnAction:(UIButton *)btn
{
    
    
    
}
-(void)calculateTheGoods
{
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    //待审核，已完成，已驳回
    _dic=Dict;
//    NSString *str = [NSString stringWithFormat:@"%@",@"高新区恒大名都新房简装，预算大约4万以内"];
//    _countLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"content"]];
    
    _countLabel.text =@"高新区恒大名都新房简装，预算大约4万以内qqq山东点点滴滴";
    float height =[PublicMethod heightForString:[NSString stringWithFormat:@"%@",_countLabel.text ] fontSize:14 andWidth:700*Width];
    _countLabel.numberOfLines =0;
    _countLabel.frame =CGRectMake(32*Width, 0*Width, 700*Width,height);
    
    UIView *view =[self viewWithTag:301];
    view.frame =CGRectMake(0,80*Width , CXCWidth,height);
    for (int i=2; i<4; i++) {
        UIView *bgView =[self viewWithTag:300+i];
        bgView.frame =CGRectMake(0,view.bottom+80*(i-2)*Width , CXCWidth, 80*Width);
        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
