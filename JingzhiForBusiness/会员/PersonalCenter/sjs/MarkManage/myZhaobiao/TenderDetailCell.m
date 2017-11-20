//
//  TenderDetailCell.m
//  家装
//
//  Created by Admin on 2017/9/28.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "TenderDetailCell.h"

@implementation TenderDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        NSArray*leftArr =@[@"半小时前",@"标题",@"会员",@"装修时间",@"售价/金币",@"最大投标数",@"已投标数",@"地址",@"电话",@"小区名称",@"房屋面积",@"招标类型",@"喜欢风格",@"预算范围",@"服务需求",@"空间户型",@"装修方式",@"备注",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"招标中",@"XXXX信息",@"张三",@"2011-09-01",@"29",@"3",@"4",@"北京怀柔区须报告",@"183777777777",@"恒大名都",@"200㎡",@"家装",@"日韩",@"5-8万",@"免费量房",@"一室一厅",@"半包",@"欢迎上门现成量房",@"",@"",@"",@"",];
        for (int i=0; i<18; i++){
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, i*80*Width, CXCWidth, 80*Width);
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
            xian.frame =CGRectMake(0,78.5*Width, CXCWidth, 1.5*Width);
            if(i<7)
            {
                bgview.frame =CGRectMake(0, i*80*Width, CXCWidth, 80*Width);
                
            }else if (i<13&&i>6)
            {
                bgview.frame =CGRectMake(0, i*80*Width+20*Width, CXCWidth, 80*Width);
                
            }else
            {
                bgview.frame =CGRectMake(0, i*80*Width+40*Width, CXCWidth, 80*Width);
                
            }
            
            if(i==0)
            {
                bgview.backgroundColor =BGColor;
                labe.tag =199;
                rightLabel.textColor =NavColor;
                labe.numberOfLines =0;
                self.timeLabel  =labe;
                self.biaoStatusLabel =rightLabel;
                
            }else if (i==1)
            {
                self.titleLabel   =rightLabel;
                
            }else if (i==2)
            {
                self.hyLabel      =rightLabel;
                
            }else if (i==3)
            {
                self.zxTimeLabel  =rightLabel;
                
            }else if (i==4)
            {
                self.countLabel   =rightLabel;
                
            }else if (i==5)
            {
                self.largeNumberLabel  =rightLabel;
                
            }else if (i==6)
            {
                self.yiNumberLabel=rightLabel;
                
            }else if (i==7)
            {
                self.addressLabel=rightLabel;
                
            }else if (i==8)
            {
                self.phoneLabel  =rightLabel;
                
            }else if (i==9)
            {
                self.communityLabel =rightLabel;
                
            }else if (i==10)
            {
                self.areaLabel   =rightLabel;
                
            }else if (i==11)
            {
                self.typeLabel   =rightLabel;
                
            }else if (i==12)
            {
                self.styleLabel   =rightLabel;
                
            }else if (i==13)
            {
                self.yusuanLabel  =rightLabel;
                
            }else if (i==14)
            {
                self.xuqiuLabel   =rightLabel;
                
            }else if (i==15)
            {
                self.huxingLabel  =rightLabel;
                
            }else if (i==16)
            {
                self.zxfsLabel    =rightLabel;
                
            }else if (i==17)
            {
                self.beizhuLabel  =rightLabel;
                
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
