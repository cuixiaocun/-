//
//  RabatForInCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/10.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "RabatForInCell.h"

@implementation RabatForInCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)statu;//1代表未转账2代表已转账3代表以完成
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray*leftArr =@[@"2017-05-03 12:12",@"产出代理",@"出款代理",@"金额",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"未确认",@"18363671722",@"18363671722",@"1722",@"",@"",@"",@"",];
        for (int i=0; i<5; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            [self addSubview:bgview];
            bgview.backgroundColor =[UIColor whiteColor];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 70*Width);
            //左边提示
            if (i==0) {
                //左边
                UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,350*Width , 68.5*Width)];
                labe.tag =199;
                labe.text = leftArr[i] ;
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = TextGrayColor;
                [bgview addSubview:labe];
                //右边
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,68.5*Width );
                rightLabel.textColor = NavColor;
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                [bgview addSubview:rightLabel];
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                [bgview addSubview:xian];
                xian.frame =CGRectMake(0*Width,68.5*Width, CXCWidth, 1.5*Width);
                
                
            }
            if (i>0) {
                bgview.frame =CGRectMake((i-1)*250*Width,70*Width, 250*Width, 130*Width);
                //上边
                UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 15*Width,250*Width , 50*Width)];
                labe.tag =199;
                labe.text = rightArr[i] ;
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = TextGrayColor;
                labe.textAlignment=NSTextAlignmentCenter;
                [bgview addSubview:labe];
                //下边
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = leftArr[i];
                rightLabel.frame =CGRectMake(0*Width,labe.bottom,250*Width , 50*Width);
                rightLabel.textColor = BlackColor;
                rightLabel.textAlignment=NSTextAlignmentCenter;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:12];
                [bgview addSubview:rightLabel];
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                [bgview addSubview:xian];
                xian.frame =CGRectMake(249*Width,30*Width, 1*Width, 70*Width);
                
            }
            
            //分割线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [self addSubview:xian];
            xian.frame =CGRectMake(0*Width,199*Width, CXCWidth, 1.5*Width);
            
            //系统计算按钮
            UIButton* _seeBtn = [[UIButton alloc]initWithFrame:CGRectMake(630*Width,200*Width+13.5*Width , 90*Width, 55*Width)];
            [_seeBtn setBackgroundColor:[UIColor whiteColor]];
            [_seeBtn.layer setCornerRadius:2*Width];
            [_seeBtn.layer setBorderWidth:1.5*Width];
            [_seeBtn.layer setMasksToBounds:YES];
            [_seeBtn setTitleColor:NavColor forState:UIControlStateNormal];
            [_seeBtn setTitle:@"确认" forState:UIControlStateNormal];
            [_seeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_seeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _seeBtn.layer.borderColor =NavColor.CGColor;
            [self addSubview:_seeBtn];
            _seeBtn.tag=130;
            bgview.backgroundColor =[UIColor whiteColor];
            
            //分割线
            UIImageView*xianXia =[[UIImageView alloc]init];
            xianXia.backgroundColor =BGColor;
            [self addSubview:xianXia];
            xianXia.frame =CGRectMake(0*Width,280*Width, CXCWidth, 20*Width);
            
            
        }
    }
    
    
    return self;
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType2:(NSString *)statu;//1代表未转账2代表已转账3代表以完成
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray*leftArr =@[@"2017-05-03 12:12",@"产出代理",@"出款代理",@"金额",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"未确认",@"18363671722",@"18363671722",@"1722",@"",@"",@"",@"",];
        for (int i=0; i<5; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            [self addSubview:bgview];
            bgview.backgroundColor =[UIColor whiteColor];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 70*Width);
            //左边提示
            if (i==0) {
                //左边
                UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,350*Width , 68.5*Width)];
                labe.tag =199;
                labe.text = leftArr[i] ;
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = TextGrayColor;
                [bgview addSubview:labe];
                //右边
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,68.5*Width );
                rightLabel.textColor = NavColor;
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                [bgview addSubview:rightLabel];
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                [bgview addSubview:xian];
                xian.frame =CGRectMake(24*Width,68.5*Width, CXCWidth, 1.5*Width);
                
                
            }
            if (i>0) {
                bgview.frame =CGRectMake((i-1)*250*Width,70*Width, 250*Width, 130*Width);
                //上边
                UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 15*Width,250*Width , 50*Width)];
                labe.tag =199;
                labe.text = rightArr[i] ;
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = TextGrayColor;
                labe.textAlignment=NSTextAlignmentCenter;
                [bgview addSubview:labe];
                //下边
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = leftArr[i];
                rightLabel.frame =CGRectMake(0*Width,labe.bottom,250*Width , 50*Width);
                rightLabel.textColor = BlackColor;
                rightLabel.textAlignment=NSTextAlignmentCenter;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:12];
                [bgview addSubview:rightLabel];
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [bgview addSubview:xian];
                xian.frame =CGRectMake(249*Width,30*Width, 1*Width, 70*Width);
                
            }
            
            //分割线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [self addSubview:xian];
            xian.frame =CGRectMake(24*Width,200*Width, CXCWidth, 20*Width);
            
        }
    }
    
    
    return self;
    
}
- (void)btnAction:(UIButton*)btn
{
    
    
}
-(void)setDicForIn:(NSDictionary *)Dict
{
    //待审核，已完成，已驳回
    _dicForIn=Dict;
    UILabel *timeLabel =[self viewWithTag:199];
    UILabel *statuLabel =[self viewWithTag:200];
    UILabel *nameLabel =[self viewWithTag:201];
    UILabel *accountLabel =[self viewWithTag:202];
    UILabel *moneyLabel =[self viewWithTag:203];
    // 到时候hidden就好啦两个按钮
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end