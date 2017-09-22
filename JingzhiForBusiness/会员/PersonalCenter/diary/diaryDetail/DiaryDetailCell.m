//
//  DiaryDetailCell.m
//  家装
//
//  Created by Admin on 2017/9/18.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DiaryDetailCell.h"

@implementation DiaryDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        //横线
        //        UIImageView*xian =[[UIImageView alloc]init];
        //        xian.backgroundColor =BGColor;
        //        [self addSubview:xian];
        //        xian.frame =CGRectMake(0,0*Width, CXCWidth, 1.5*Width);
        
        NSArray*leftArr =@[@"半小时前",@"标题",@"阶段",@"状态",@"",@"",];
        
        NSArray*rightArr =@[@"",@"装修新房，改水电",@"泥瓦工阶段",@"",@"",];
        for (int i=0; i<4; i++){
            
            
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, i*82*Width, CXCWidth, 82*Width);
            
            if (i<3) {
                
                
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
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [bgview addSubview:xian];
                xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
                if(i==0)
                {
                    bgview.backgroundColor =BGColor;
                    
                    labe.tag =199;
                    rightLabel.textColor =NavColor;
                    
                }
                
            }else if(i==3)
            {
                //修改
                _changeBtn = [[UIButton alloc]init];
                [_changeBtn setBackgroundColor:[UIColor whiteColor]];
                [_changeBtn.layer setCornerRadius:2];
                [_changeBtn.layer setBorderWidth:1];
                [_changeBtn.layer setMasksToBounds:YES];
                [_changeBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [_changeBtn setTitle:@"修改" forState:UIControlStateNormal];
                _changeBtn.tag=130;
                [_changeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _changeBtn.layer.borderColor =TextGrayColor.CGColor;
                [bgview addSubview:_changeBtn];
                //            _seeBtn.hidden=YES;
                //删除
                _deleteBtn = [[UIButton alloc]init];
                [_deleteBtn setBackgroundColor:[UIColor whiteColor]];
                [_deleteBtn.layer setCornerRadius:2];
                [_deleteBtn.layer setBorderWidth:1];
                [_deleteBtn.layer setMasksToBounds:YES];
                [_deleteBtn setTitleColor:NavColor forState:UIControlStateNormal];
                [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
                _deleteBtn.tag=131;
                
                [_deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_deleteBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                _deleteBtn.layer.borderColor =NavColor.CGColor;
                [bgview addSubview:_deleteBtn];
                
                [_deleteBtn setFrame:CGRectMake(650*Width,13.5*Width , 90*Width, 55*Width)];
                [_changeBtn setFrame:CGRectMake(540*Width,13.5*Width , 90*Width, 55*Width)];
                _deleteBtn.hidden =NO;
                _changeBtn.hidden =NO;
                
                
                
            }
            
        }
        
        
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    UILabel *oderNumLabel = [self viewWithTag:333];
    UILabel *statusLabel = [self viewWithTag:334];
    oderNumLabel.text =[NSString stringWithFormat:@"    订单号：%@",[_dic objectForKey:@"sn"]];
    if ([[_dic objectForKey:@"status"]isEqualToString:@"1"]) {
        statusLabel.text =@"待支付";
        
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"2"])
    {
        statusLabel.text =@"待发货";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"3"])
    {
        statusLabel.text =@"待收货";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"4"])
    {
        statusLabel.text =@"已完成";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"5"])
    {
        statusLabel.text =@"已取消";
    }else if([[_dic objectForKey:@"status"]isEqualToString:@"6"])
    {
        statusLabel.text =@"已驳回";
    }
    //    _tureBtn.hidden = YES;
    //    _seeLogBtn.hidden = YES;
    //    _rejectBtn.hidden =YES ;
    //    _deliverBtn.hidden =YES ;
    //
    //    if ([[_dic objectForKey:@"status"]isEqualToString:@"1"]) {
    //        [_deliverBtn setFrame:CGRectMake(610*Width,13.5*Width , 120*Width, 55*Width)];
    //        [_rejectBtn setFrame:CGRectMake(440*Width,13.5*Width , 150*Width, 55*Width)];
    //        [_seeBtn setFrame:CGRectMake(330*Width,13.5*Width , 90*Width, 55*Width)];
    //        _tureBtn.hidden = YES;
    //        _seeLogBtn.hidden = YES;
    //        _rejectBtn.hidden =NO;
    //        _deliverBtn.hidden =NO;
    //
    //    }else if([[_dic objectForKey:@"status"]isEqualToString:@"3"])
    //    {
    //        [_tureBtn setFrame:CGRectMake(590*Width,13.5*Width , 150*Width, 55*Width)];
    //        [_seeLogBtn setFrame:CGRectMake(410*Width,13.5*Width , 150*Width, 55*Width)];
    //        [_seeBtn setFrame:CGRectMake(300*Width,13.5*Width , 90*Width, 55*Width)];
    //        _rejectBtn.hidden =YES;
    //        _deliverBtn.hidden =YES;
    //        _tureBtn.hidden = NO;
    //        _seeLogBtn.hidden = NO;
    //    }else if([[_dic objectForKey:@"status"]isEqualToString:@"4"])
    //    {
    //        //        [_tureBtn setFrame:CGRectMake(590*Width,13.5*Width , 150*Width, 55*Width)];
    //        [_seeLogBtn setFrame:CGRectMake(590*Width,13.5*Width , 150*Width, 55*Width)];
    //        [_seeBtn setFrame:CGRectMake(480*Width,13.5*Width , 90*Width, 55*Width)];
    //        _rejectBtn.hidden =YES;
    //        _deliverBtn.hidden =YES;
    //        _tureBtn.hidden = YES;
    //        _seeLogBtn.hidden = NO;
    //    }else
    //    {
    //        [_seeBtn setFrame:CGRectMake(650*Width,13.5*Width , 90*Width, 55*Width)];
    //    }
    //
    //    NSArray *goods =[_dic objectForKey:@"goods"];
    //    _promptLabel.text =[NSString stringWithFormat:@"共计%ld种商品",goods.count];
    //    NSString*str =[NSString stringWithFormat:@"总金额：¥%@",[_dic objectForKey:@"total"] ];
    //    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    //    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    //    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    //    [_allPricesLabel setAttributedText:textColor];
    //
    //    _goodsImgView.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[goods[0] objectForKey:@"img"]]];
    //    _goodsTitleLab.text =[NSString stringWithFormat:@"%@", [PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[goods[0] objectForKey:@"name"]]]];
    //    _priceLab.text =[NSString stringWithFormat:@"%@", [PublicMethod stringNilString:[NSString stringWithFormat:@"%@",[goods[0] objectForKey:@"price"]]]];
    
    
    
}
- (void)btnAction:(UIButton *)btn
{
    [self.delegate btnClick:self andBtnActionTag:btn.tag];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
