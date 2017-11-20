//
//  DiaryCell.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DiaryCell.h"

@implementation DiaryCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        self.topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,CXCWidth,420*Width)];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        _topMCImage.image =[UIImage imageNamed:@"timg-8.jpeg"];
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, _topMCImage.bottom, CXCWidth, 120*Width)];
        bgView.backgroundColor =[UIColor whiteColor];
        [self.contentView   addSubview:bgView];
        
        
        
        //shang边文字
        _styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20*Width,20*Width,480*Width,40*Width)];
        _styleLabel.font =[UIFont systemFontOfSize:13];
        _styleLabel.text =@"焕然一新~打美式";
        _styleLabel.textColor =TextColor;
        [bgView addSubview:_styleLabel];
        
        //中间文字
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(20*Width,_styleLabel.bottom,250*Width,60*Width)];
        _nameLabel.font =[UIFont systemFontOfSize:12];
        _nameLabel.text =@"东方世纪城";
        _nameLabel.textColor =TextGrayColor;
        [bgView addSubview:_nameLabel];
        //下边文字
        _contentLabel   =[[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.right+15*Width,_nameLabel.top,250*Width,60*Width)];
        _contentLabel.text =@"两室一厅一卫";
        _contentLabel.font =[UIFont systemFontOfSize:12];
        _contentLabel.textColor =TextGrayColor;
        [bgView addSubview:_contentLabel];
        
        self.decorateLabel = [[UILabel alloc] initWithFrame:CGRectMake(500*Width,_styleLabel.top,230*Width,40*Width)];
        self.decorateLabel.textColor = TextGrayColor;
        self.decorateLabel.textAlignment =NSTextAlignmentRight;
        self.decorateLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.decorateLabel.backgroundColor = [UIColor clearColor];
        self.decorateLabel.text =@"装修:全包";
        [bgView addSubview:self.decorateLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(500*Width,_nameLabel.top,230*Width,60*Width)];
        self.priceLabel.textColor = TextGrayColor;
        _priceLabel.textAlignment =NSTextAlignmentRight;
        self.priceLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.text =@"均价:19304元";
        [bgView addSubview:self.priceLabel];
        
        //橘黄色的
        _orangeLabel   =[[UILabel alloc]initWithFrame:CGRectMake(580*Width,400*Width,170*Width,40*Width)];
        _orangeLabel.textAlignment=NSTextAlignmentCenter;
        _orangeLabel.text =@"木工阶段";
        _orangeLabel.backgroundColor=orangeColor;
        _orangeLabel.textColor =[UIColor whiteColor];
        _orangeLabel.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_orangeLabel];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.orangeLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(20*Width, 20*Width)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _orangeLabel.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        self.orangeLabel.layer.mask = maskLayer;
        

        
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [self.topMCImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]]]  ;
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    _styleLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"title"])?@"":[dic objectForKey:@"title"] ];
    _nameLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"home_name"])?@"":[dic objectForKey:@"home_name"] ];
    _decorateLabel.text =[NSString stringWithFormat:@"装修:%@", IsNilString([dic  objectForKey:@"way_title"])?@"":[dic objectForKey:@"way_title"] ];
    _priceLabel.text =[NSString stringWithFormat:@"价格:%@", IsNilString([dic  objectForKey:@"total_price"])?@"":[dic objectForKey:@"total_price"] ];
    _contentLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"type_title"])?@"":[dic objectForKey:@"type_title"] ];
    _orangeLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"status_title"])?@"":[dic objectForKey:@"status_title"] ];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
