//
//  PostTalkCell.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PostTalkCell.h"

@implementation PostTalkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor =[UIColor whiteColor];
        self.topMCImage = [[UIImageView alloc] initWithFrame:CGRectMake(20*Width,30*Width,85*Width,85*Width)];
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
        NSString *ideaContent =@"";
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(560*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _contentLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_nameLabel.bottom,570*Width,ideaSize.height);
        _contentLabel.text =ideaContent;
        self.contentLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLabel];
        
//        _xian=[[UIImageView alloc]initWithFrame:CGRectMake(0,_contentLabel.bottom+20*Width*Width, CXCWidth,1.5*Width)];
//        [self.contentView addSubview:_xian];
//        _xian.backgroundColor =BGColor;
    
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [self.topMCImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"face_32"]]]];  ;
    _nameLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"uname"])?@"":[dic objectForKey:@"uname"]];
    self.contentLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"title"])?@"":[dic objectForKey:@"title"]];
    _timeLabel.text =[PublicMethod timeWithTimeIntervalString:[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"dateline"])?@"":[dic objectForKey:@"dateline"]]];
//    _webImage.dataList =@[[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]];
//
//    _tagLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"detail_type"])?@"":[dic objectForKey:@"detail_type"]];
//    _seeLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"views"])?@"":[dic objectForKey:@"views"]];
//    _talkLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"answer_num"])?@"":[dic objectForKey:@"answer_num"]];
    NSString *ideaContent =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"contents"])?@"":[dic objectForKey:@"contents"]];
    CGSize ideaSize;//通过文本得到高度
    ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(600*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_nameLabel.bottom,600*Width,ideaSize.height+40*Width);
    _contentLabel.text=ideaContent;
//    _xian.frame=CGRectMake(0,_contentLabel.bottom+20*Width*Width, CXCWidth,1.5*Width);

}

@end
