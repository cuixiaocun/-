//
//  ToubiaoDetailGSCell.m
//  家装
//
//  Created by Admin on 2017/10/30.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ToubiaoDetailGSCell.h"

@implementation ToubiaoDetailGSCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        NSArray*leftArr =@[@"半小时前",@"公司",@"留言",@"联系电话",@"",@"",@"",@"",];
        NSArray*rightArr =@[@"招标中",@"龙发装饰",@"希望尽快现场测量",@"",@"",];
        for (int i=0; i<3; i++){
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
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BlackColor;
            [bgview addSubview:rightLabel];
            bgview.tag =300+i;
            
            //分割线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [bgview addSubview:xian];
            xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
            if(i==0)
            {
                bgview.backgroundColor =BGColor;
                labe.tag =199;
                rightLabel.textColor =NavColor;
                labe.numberOfLines =0;
                self.timeLabel  =labe;
                self.statusLabel =rightLabel;
                
            }else if (i==1)
            {
                self.companyLabel  =rightLabel;
            }else if (i==2)
            {
                self.lyLabel  =rightLabel;
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
    
//    _countLabel.text =@"高新区恒大名都新房简装，预算大约4万以内qqq山东点点滴滴";
//    float height =[PublicMethod heightForString:[NSString stringWithFormat:@"%@",_countLabel.text ] fontSize:14 andWidth:700*Width];
//    _countLabel.numberOfLines =0;
//    _countLabel.frame =CGRectMake(32*Width, 0*Width, 700*Width,height);
    
//    UIView *view =[self viewWithTag:301];
//    view.frame =CGRectMake(0,80*Width , CXCWidth,height);
//    for (int i=2; i<4; i++) {
//        UIView *bgView =[self viewWithTag:300+i];
//        bgView.frame =CGRectMake(0,view.bottom+80*(i-2)*Width , CXCWidth, 80*Width);
//
//    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
