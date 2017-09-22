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
        NSString *ideaContent =@"他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！";
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(580*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _contentLabel.frame =CGRectMake(self.topMCImage.right+20*Width,_nameLabel.bottom,600*Width,ideaSize.height);
        _contentLabel.text =ideaContent;
        self.contentLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLabel];
        
        self.detailLabel = [[MLLinkLabel alloc] init];
        self.detailLabel.textColor = TextGrayColor;
        _detailLabel.numberOfLines =0;
        NSString *detailContent =@"他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！";
        CGSize detailSize;//通过文本得到高度
        detailSize = [detailContent boundingRectWithSize:CGSizeMake(550*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _detailLabel.frame =CGRectMake(_contentLabel.left+20*Width,_contentLabel.bottom+20*Width,550*Width,detailSize.height);
        _detailLabel.text =detailContent;
        _detailLabel.backgroundColor =BGColor;
        self.detailLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [self.contentView addSubview:self.detailLabel];
        

        _webImage =[[WebImgViewTwo alloc]initWithFrame:CGRectMake(_detailLabel.left, _detailLabel.bottom+20*Width, 600*Width,170*Width )];
        _webImage.userInteractionEnabled = YES;
        _webImage.hidden = NO;
        _webImage.left = 15;
        
        _webImage.top = _detailLabel.bottom+20*Width;
        _webImage.height = [WebImgViewTwo heightForCount:8];//因为开始的时候是以坐标做得这里应该是照片的数量
        NSLog(@"%f-------",_webImage.height);
        _webImage.width = 600*Width;
        [_webImage setDataList:@[@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505392560832&di=206e9c2d41f3c5cb99fdc82cb14e1d67&imgtype=0&src=http%3A%2F%2Fpic73.nipic.com%2Ffile%2F20150724%2F9448607_174837076000_2.jpg",@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505392560832&di=98a69409cf8e6abb4fdee414b7dab0e4&imgtype=0&src=http%3A%2F%2Fpic18.nipic.com%2F20111208%2F8282523_212410561181_2.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505393035479&di=8cda738d292a7406465f9bd80b19228c&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fc0%253Dbaike150%252C5%252C5%252C150%252C50%2Fsign%3D05056ad1a5efce1bfe26c098ce3898bb%2F838ba61ea8d3fd1fd4de8b1d324e251f94ca5fc5.jpg",@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505392560829&di=7ecdb0cfd44a0120d1c365aa7c9a9056&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F13%2F70%2F05%2F91b1OOOPIC59.jpg"]];
        [_webImage setTag:777];
        [self addSubview:_webImage];

        
        _xian=[[UIImageView alloc]initWithFrame:CGRectMake(0,_contentLabel.bottom+15, CXCWidth,1.5*Width)];
        [_contentLabel addSubview:_xian];
        _xian.backgroundColor =BGColor;

        
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
    
    
}
@end
