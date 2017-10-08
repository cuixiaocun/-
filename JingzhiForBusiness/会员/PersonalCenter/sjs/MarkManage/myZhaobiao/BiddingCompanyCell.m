//
//  BiddingCompanyCell.m
//  家装
//
//  Created by Admin on 2017/9/28.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "BiddingCompanyCell.h"

@implementation BiddingCompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        NSArray*leftArr =@[@"半小时前",@"公司",@"留言",@"电话",@"已投标",@"流转时间",@"",@"",@"",@"",@"",];
        NSArray*rightArr =@[@"招标中",@"潍坊龙发装饰",@"看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。",@"18363267772",@"3",@"",@"",];
        for (int i=0; i<3; i++){
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 82*Width);
            
            
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,300*Width , 82*Width)];
            labe.text = leftArr[i];
            //            labe.textAlignment=NSTextAlignmentLeft;
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            
            //分割线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [bgview addSubview:xian];
            xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
            
            if(i<2){
                //右边显示
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                rightLabel.textColor = BlackColor;
                [bgview addSubview:rightLabel];
                if(i==0)
                {
                    bgview.backgroundColor =BGColor;
                    labe.tag =199;
                    rightLabel.textColor =NavColor;
                    
                }
            }
           
            if(i==2) {
                //右边内容
                _contentLabel = [[MLLinkLabel alloc]init];
                self.contentLabel.numberOfLines =0;
                self.contentLabel.textColor = TextColor;
                self.contentLabel.tag =200;
                //self.rightLabel.backgroundColor =BGColor;
                self.contentLabel.font = [UIFont systemFontOfSize:14];
                self.contentLabel.allowLineBreakInsideLinks = YES;
                [self addSubview:self.contentLabel];
                _contentLabel.text =@"看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。";
                CGSize titleSize;//通过文本得到高度
                titleSize = [_contentLabel.text boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                _contentLabel.frame =CGRectMake(24*Width ,20*Width, 700*Width,titleSize.height+40*Width);
                _contentLabel.numberOfLines =0;
                bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 82*Width*2);
                //查看物流
                _seeLogBtn = [[UIButton alloc]init];
                [_seeLogBtn setBackgroundColor:[UIColor whiteColor]];
                [_seeLogBtn.layer setCornerRadius:2];
                [_seeLogBtn.layer setBorderWidth:1];
                [_seeLogBtn.layer setMasksToBounds:YES];
                [_seeLogBtn setTitleColor:NavColor forState:UIControlStateNormal];
                [_seeLogBtn setTitle:@"设为中标" forState:UIControlStateNormal];
                _seeLogBtn.tag=133;
                [_seeLogBtn setFrame:CGRectMake(580*Width,13.5*Width+_contentLabel.bottom , 150*Width, 55*Width)];
                [_seeLogBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_seeLogBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _seeLogBtn.layer.borderColor =NavColor.CGColor;
                [bgview addSubview:_seeLogBtn];
                
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
    UILabel *timeLabel =[self viewWithTag:199];
    
    UILabel *statuLabel =[self viewWithTag:200];
    UILabel *IDLabel =[self viewWithTag:201];
    UILabel *cityLabel =[self viewWithTag:202];
    
    UILabel *nameLabel =[self viewWithTag:203];
    UILabel *phoneLabel =[self viewWithTag:204];
    UILabel *numberLabel =[self viewWithTag:205];
    //    timeLabel =[NSString stringWithFormat:@"%@/%@",[_dic objectForKey:@"sourcename"],[_dic objectForKey:@"source"]];
    //    statuLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"before"]];
    //    IDLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"beforename"]];
    //    cityLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"info"]];
    //    nameLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"after"]];
    //    phoneLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"createtime"]];
    //    numberLabel =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"aftername"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
