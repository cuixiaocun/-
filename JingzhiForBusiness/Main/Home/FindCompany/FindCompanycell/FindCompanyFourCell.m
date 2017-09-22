//
//  FindCompanyFourCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FindCompanyFourCell.h"

@implementation FindCompanyFourCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[UIColor whiteColor];
        self.topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(20*Width,30*Width,85*Width,85*Width)];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        self.topMCImage.layer.cornerRadius=42.5*Width;
        _topMCImage.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.topMCImage];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.topMCImage.right+20*Width,_topMCImage.top,300*Width,45*Width)];
        self.nameLabel.textColor = TextColor;
        self.nameLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.text =@"孙磊";
        [self.contentView addSubview:self.nameLabel];
        
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.right,_nameLabel.top,300*Width,45*Width)];
        self.timeLabel.textColor = TextGrayColor;
        self.timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.text =@"2012-01-22";
        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = TextGrayColor;
        _contentLabel.numberOfLines =0;
        NSString *ideaContent =@"他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！";
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(560*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _contentLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_nameLabel.bottom,570*Width,ideaSize.height);
        _contentLabel.text =ideaContent;
        self.contentLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLabel];
        
        _bottomV =[[UIView alloc]initWithFrame:CGRectMake(0,_contentLabel.bottom, CXCWidth, 200*Width)];
        [self.contentView addSubview:_bottomV];
        
        _xian=[[UIImageView alloc]initWithFrame:CGRectMake(120*Width,0, 630*Width,3*Width)];
        [_bottomV addSubview:_xian];
        _xian.image =[UIImage imageNamed:@"sjs_icon_dotte"];
        NSArray*leftArr =@[@"设计",@"服务",@"价格",@"施工",@"售后",@"",];
        for (int i=0; i<5; i++) {
            UILabel*proLabel = [[UILabel alloc] initWithFrame:CGRectMake(120*Width+i%2*300*Width,60*Width*(i/2)+20*Width,60*Width,50*Width)];
            proLabel.textColor = TextColor;
            proLabel.font = [UIFont fontWithName:@"Arial" size:12];
            proLabel.backgroundColor = [UIColor clearColor];
            proLabel.text =[NSString stringWithFormat:@"%@",leftArr[i]];
            proLabel.textAlignment =NSTextAlignmentCenter;
            [_bottomV addSubview:proLabel];
            if (i==0) {
                //星星
                _sjImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 150*Width, 30*Width)];
                _sjImgView.rating = [[NSString stringWithFormat:@"%@",@"5"] floatValue];
                [_bottomV addSubview:_sjImgView];
                
            }else if (i==1) {
                //星星
                _fwImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 180*Width, 30*Width)];
                _fwImgView.rating = [[NSString stringWithFormat:@"%@",@"4"] floatValue];
                [_bottomV addSubview:_fwImgView];
                
            }else if (i==2) {
                //星星
                _jgImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 180*Width, 30*Width)];
                _jgImgView.rating = [[NSString stringWithFormat:@"%@",@"2.5"] floatValue];
                [_bottomV addSubview:_jgImgView];
                
                
            }else if (i==3) {
                //星星
                _sgImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 180*Width, 30*Width)];
                _sgImgView.rating = [[NSString stringWithFormat:@"%@",@"2.5"] floatValue];
                [_bottomV addSubview:_sgImgView];
                
                
            }else if (i==4) {
                //星星
                _shImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 180*Width, 30*Width)];
                _shImgView.rating = [[NSString stringWithFormat:@"%@",@"2.5"] floatValue];
                [_bottomV addSubview:_shImgView];
                
                
            }
        }
            
        
        
        UIImageView *xian=[[UIImageView alloc]initWithFrame:CGRectMake(0,_bottomV.height-1.5*Width, CXCWidth,1.5*Width)];
        [_bottomV addSubview:xian];
        xian.backgroundColor =BGColor;
        
        
        
        
        
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    
    
}


@end
