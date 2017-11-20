//
//  PostHeaderCell.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PostHeaderCell.h"

@implementation PostHeaderCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
        
        self.contentLabel = [[MLLinkLabel alloc] init];
        self.contentLabel.textColor = TextGrayColor;
        _contentLabel.numberOfLines =0;
        _contentLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_nameLabel.bottom,600*Width,0);
        self.contentLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLabel];
        
        self.detailLabel = [[MLLinkLabel alloc] init];
        self.detailLabel.textColor = [UIColor grayColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.frame =CGRectMake(_contentLabel.left+20*Width,_contentLabel.bottom+20*Width,550*Width,0);
        _detailLabel.backgroundColor =BGColor;
        self.detailLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [self.contentView addSubview:self.detailLabel];
        
        _xian=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 550*Width,1.5*Width)];
        [_detailLabel addSubview:_xian];
        _xian.backgroundColor =BGColor;
        
        _webImage =[[WebImgViewTwo alloc]initWithFrame:CGRectMake(_detailLabel.left, _detailLabel.bottom+20*Width, 600*Width,170*Width )];
        _webImage.userInteractionEnabled = YES;
        _webImage.hidden = NO;
        _webImage.left = 15;
        _webImage.top = _detailLabel.bottom+20*Width;
        _webImage.height = [WebImgViewTwo heightForCount:0];//因为开始的时候是以坐标做得这里应该是照片的数量
        NSLog(@"%f-------",_webImage.height);
        _webImage.width = 600*Width;
        [_webImage setDataList:@[]];
        [_webImage setTag:777];
        [self addSubview:_webImage];
        
       

        
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,_webImage.bottom, CXCWidth,  80*Width)];
        [self addSubview:_bottomView];
        UIImageView *tagImgV =[[UIImageView alloc]initWithFrame:CGRectMake(130*Width, 25*Width,30*Width, 30*Width)];
        tagImgV.image =[UIImage imageNamed:@"lt_icon_tag_line"];
        [_bottomView addSubview:tagImgV];
        
        
        _tagLabel=[[UILabel alloc]initWithFrame:CGRectMake(tagImgV.right+24*Width, 0,120*Width, 80*Width)];
        _tagLabel.numberOfLines =0;
        _tagLabel.text =@"装修家居";
        _tagLabel.font =[UIFont systemFontOfSize:12];
        _tagLabel.textColor =TextColor;
        [_bottomView addSubview:_tagLabel];
        
        UIImageView *addressImgV =[[UIImageView alloc]initWithFrame:CGRectMake(_tagLabel.right+ 30*Width, 30*Width,40*Width, 20*Width)];
        addressImgV.image =[UIImage imageNamed:@"lt_icon_liulan_line"];
        [_bottomView addSubview:addressImgV];
        
        
        _seeLabel=[[UILabel alloc]initWithFrame:CGRectMake(addressImgV.right+24*Width, 0,100*Width, 80*Width)];
        _seeLabel.numberOfLines =0;
        _seeLabel.text =@"10";
        _seeLabel.font =[UIFont systemFontOfSize:12];
        _seeLabel.textColor =TextColor;
        [_bottomView addSubview:_seeLabel];
        
        UIImageView *talkImgV =[[UIImageView alloc]initWithFrame:CGRectMake(_seeLabel.right+24*Width, 30*Width,30*Width, 30*Width)];
        talkImgV.image =[UIImage imageNamed:@"lt_icon_pinglun_line"];
        [_bottomView addSubview:talkImgV];
        
        
        _talkLabel=[[UILabel alloc]initWithFrame:CGRectMake(talkImgV.right+24*Width, 0,100*Width, 80*Width)];
        _talkLabel.numberOfLines =0;
        _talkLabel.text =@"1000";
        _talkLabel.font =[UIFont systemFontOfSize:12];
        _talkLabel.textColor =TextColor;
        [_bottomView addSubview:_talkLabel];
 
        
        
        
        
        
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [self.topMCImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"face"]]]];  ;
    _nameLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"uname"])?@"":[dic objectForKey:@"uname"]];
    self.contentLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"title"])?@"":[dic objectForKey:@"title"]];
    _timeLabel.text =[PublicMethod timeWithTimeIntervalString:[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"dateline"])?@"":[dic objectForKey:@"dateline"]]];
    _detailLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"intro"])?@"":[dic objectForKey:@"intro"]];
    _webImage.dataList =@[[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]];
   
    _tagLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"detail_type"])?@"":[dic objectForKey:@"detail_type"]];
    _seeLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"views"])?@"":[dic objectForKey:@"views"]];
    _talkLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"answer_num"])?@"":[dic objectForKey:@"answer_num"]];
    NSString *ideaContent =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"title"])?@"":[dic objectForKey:@"title"]];
    CGSize ideaSize;//通过文本得到高度
    ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(600*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_nameLabel.bottom,600*Width,ideaSize.height+40*Width);
    
    NSString *detailContent =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"intro"])?@"":[dic objectForKey:@"intro"]];
    CGSize detailSize;//通过文本得到高度
    detailSize = [detailContent boundingRectWithSize:CGSizeMake(550*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _detailLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_contentLabel.bottom+1*Width,550*Width,detailSize.height+40*Width);
    int count = [[NSString stringWithFormat:@"%@",[_dic objectForKey:@"thumb"]]isEqualToString:@"<null>"]?0:1;

    if (count>0) {
        _webImage.frame =CGRectMake(_detailLabel.left, _detailLabel.bottom+20*Width, 600*Width,[WebImgViewTwo heightForCount:1] ) ;//因为开始的时候是以坐标做得这里应该是照片的数量
        _webImage.hidden =NO;

    }else
    {
        _webImage.frame =CGRectMake(_detailLabel.left, _detailLabel.bottom+20*Width, 600*Width,0 ) ;//因为开始的时候是以坐标做得这里应该是照片的数量
        _webImage.hidden =YES;
    }
    _bottomView.frame =CGRectMake(0,_webImage.bottom, CXCWidth,  80*Width);

}
@end
