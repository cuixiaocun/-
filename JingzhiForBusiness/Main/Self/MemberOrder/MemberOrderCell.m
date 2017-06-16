//
//  MemberOrderCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MemberOrderCell.h"

@implementation MemberOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 20*Width);
        
        NSArray*leftArr =@[@"",@"会员账号",@"下单时间",@"收货地址",@"",@"",@"",@"",@"",];
        
        NSArray*rightArr =@[@"待发货",@"一级",@"18363671722",@"山东省潍坊市奎文区新华路与胜利街路口中天下1607",@"",@"",@"",];
        for (int i=0; i<5; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =BGColor;
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            if (i==0) {
                bgview.backgroundColor =[UIColor whiteColor];
                labe.tag =199;
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = BlackColor;
            }else if(i>0&&i<4)
            {
                if(i==3)
                {
                    labe.frame =CGRectMake(32*Width, 0,200*Width , 122*Width);
                    labe.numberOfLines=0;
                    bgview.frame =CGRectMake(0, xian.bottom+i*82*Width, CXCWidth, 122*Width);

                }
                labe.text = leftArr[i];
                labe.font = [UIFont systemFontOfSize:14];
                labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            }else if(i==4)
            {
                bgview.frame =CGRectMake(0, xian.bottom+i*82*Width+40*Width, CXCWidth, 82*Width);
                bgview.backgroundColor =[UIColor whiteColor];
                
                
            }
            [bgview addSubview:labe];
            //右边显示
            if (i<4) {
                
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                [bgview addSubview:rightLabel];
                rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
                if (i==0) {
                    rightLabel.textColor = NavColor;
                    
                }else
                {
                    rightLabel.textColor = BlackColor;
                    
                }
                
                if(i==3)
                {
                    rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,122*Width );
                    rightLabel.numberOfLines=0;

                }
               
                
            }else
            {
                //系统计算按钮
                _seeBtn = [[UIButton alloc]init];
                [_seeBtn setBackgroundColor:[UIColor whiteColor]];
                [_seeBtn.layer setCornerRadius:2*Width];
                [_seeBtn.layer setBorderWidth:1.5*Width];
                [_seeBtn.layer setMasksToBounds:YES];
                [_seeBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [_seeBtn setTitle:@"查看" forState:UIControlStateNormal];
                [_seeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_seeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _seeBtn.layer.borderColor =TextGrayColor.CGColor;
                [bgview addSubview:_seeBtn];
                _seeBtn.tag=130;
                _seeBtn.hidden=YES;

                //发货
                _deliverBtn = [[UIButton alloc]init];
                [_deliverBtn setBackgroundColor:[UIColor whiteColor]];
                [_deliverBtn.layer setCornerRadius:2*Width];
                [_deliverBtn.layer setBorderWidth:1.5*Width];
                [_deliverBtn.layer setMasksToBounds:YES];
                [_deliverBtn setTitleColor:NavColor forState:UIControlStateNormal];
                [_deliverBtn setTitle:@"发货" forState:UIControlStateNormal];
                _deliverBtn.tag=131;
                [_deliverBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_deliverBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _deliverBtn.layer.borderColor =NavColor.CGColor;
                [bgview addSubview:_deliverBtn];
                //驳回
                 _rejectBtn = [[UIButton alloc]init];
                [_rejectBtn setBackgroundColor:[UIColor whiteColor]];
                [_rejectBtn.layer setCornerRadius:2*Width];
                [_rejectBtn.layer setBorderWidth:1.5*Width];
                [_rejectBtn.layer setMasksToBounds:YES];
                [_rejectBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [_rejectBtn setTitle:@"驳回" forState:UIControlStateNormal];
                _rejectBtn.tag=132;

                [_rejectBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_rejectBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _rejectBtn.layer.borderColor =TextGrayColor.CGColor;
                [bgview addSubview:_rejectBtn];
                
                
            }
            
            if(i<4&&i>0)
            {
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                [bgview addSubview:xian];
                if (i==3) {
                    xian.frame =CGRectMake(24*Width,120.5*Width, CXCWidth, 1.5*Width);
                }else
                {
                    xian.frame =CGRectMake(24*Width,80.5*Width, CXCWidth, 1.5*Width);
                    

                }
              }else if (i==4)
            {
                xian.frame =CGRectMake(24*Width,80.5*Width+40*Width, CXCWidth, 1.5*Width);

                xian.backgroundColor =[UIColor redColor];

            }
        }
        [_deliverBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
        [_rejectBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
        [_seeBtn setFrame:CGRectMake(410*Width,13.5*Width , 90*Width, 55*Width)];
        

    }
    
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)btnAction:(UIButton *)btn
{
    //调用代理
    [self.delegate btnClick:self andTag:(int)btn.tag];

    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel *typeLabel =[self viewWithTag:199];
    UILabel *statuLabel =[self viewWithTag:200];
    UILabel *levelLabel =[self viewWithTag:201];
    UILabel *accountLabel =[self viewWithTag:202];
    UILabel *lastAccountLabel =[self viewWithTag:203];
    
    [_deliverBtn setFrame:CGRectMake(630*Width,13.5*Width , 90*Width, 55*Width)];
    [_rejectBtn setFrame:CGRectMake(520*Width,13.5*Width , 90*Width, 55*Width)];
    [_seeBtn setFrame:CGRectMake(410*Width,13.5*Width , 90*Width, 55*Width)];


    
}
-(void)setStatus:(NSString *)status
{
    _status =status;
    if ([_status isEqualToString:@""]) {
        
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
