//
//  DiaryDetailTableViewCell.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DiaryDetailTableViewCell.h"
#import "WBImageView.h"
@implementation DiaryDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //细线
        UIImageView*xianOfGoods =[[UIImageView alloc]init];
        xianOfGoods.backgroundColor =BGColor;
        [self addSubview:xianOfGoods];
        xianOfGoods.frame =CGRectMake(0*Width,0*Width,CXCWidth,20*Width);
        self.backgroundColor =[UIColor whiteColor];
        
        UILabel* bottomLabel = [[UILabel alloc]init];
        bottomLabel.text = @"开工大吉";
        bottomLabel.numberOfLines =0;
        bottomLabel.textColor = TextColor;
        bottomLabel.tag =201;
        _titleLabel =bottomLabel;
        bottomLabel.frame =CGRectMake(24*Width ,20*Width, 600*Width,70*Width);
        bottomLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:bottomLabel];
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0*Width,bottomLabel.bottom-1.5*Width,CXCWidth,1.5*Width);

        //右边内容
        _contentLabel = [[MLLinkLabel alloc]init];
        self.contentLabel.numberOfLines =0;
        self.contentLabel.textColor = TextColor;
        self.contentLabel.tag =200;
        //self.rightLabel.backgroundColor =BGColor;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.allowLineBreakInsideLinks = YES;
        [self addSubview:self.contentLabel];
        _contentLabel.text =@"看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美。也开始想象自己有这样的家。我最开始感觉就是在看软装，这个沙发，那个吊灯...totally wrong direction.现在开始落地起来，开始找装修公司设计师，SD、MF、NH，开始看预算，开始和小伙伴聊中央空调，\n西门子开关，比较优劣，开始看各位16楼的日记，哈，工作之余的事情就是装修！现在是午休时间，给自己开了篇。";
        CGSize titleSize;//通过文本得到高度
        titleSize = [_contentLabel.text boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _contentLabel.frame =CGRectMake(24*Width ,_titleLabel.bottom, 700*Width,titleSize.height);
        _contentLabel.numberOfLines =0;
        _webImage =[[WBImageView alloc]initWithFrame:CGRectMake(25*Width, _contentLabel.bottom, 700*Width,170*Width )];
        _webImage.userInteractionEnabled = YES;
        _webImage.hidden = NO;
        _webImage.left = 15;
        
        _webImage.top = _contentLabel.bottom;
        _webImage.height = [WBImageView heightForCount:9];//因为开始的时候是以坐标做得这里应该是照片的数量
        NSLog(@"%f-------",_webImage.height);
        _webImage.width = 320;
        [_webImage setDataList:@[@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505392560832&di=206e9c2d41f3c5cb99fdc82cb14e1d67&imgtype=0&src=http%3A%2F%2Fpic73.nipic.com%2Ffile%2F20150724%2F9448607_174837076000_2.jpg",@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505392560832&di=98a69409cf8e6abb4fdee414b7dab0e4&imgtype=0&src=http%3A%2F%2Fpic18.nipic.com%2F20111208%2F8282523_212410561181_2.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505393035479&di=8cda738d292a7406465f9bd80b19228c&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fc0%253Dbaike150%252C5%252C5%252C150%252C50%2Fsign%3D05056ad1a5efce1bfe26c098ce3898bb%2F838ba61ea8d3fd1fd4de8b1d324e251f94ca5fc5.jpg",@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"http://oo849p911.bkt.clouddn.com/ddsc2017-08-04_5983c4a128242.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505392560829&di=7ecdb0cfd44a0120d1c365aa7c9a9056&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F13%2F70%2F05%2F91b1OOOPIC59.jpg"]];
        [_webImage setTag:777];
        [self addSubview:_webImage];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2017-01-10 15:12:12";
        _timeLabel.numberOfLines =0;
        _timeLabel.textColor = TextGrayColor;
        _timeLabel.tag =201;
        _titleLabel =bottomLabel;
        _timeLabel.frame =CGRectMake(24*Width ,_webImage.bottom+ 20*Width, 600*Width,50*Width);
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_timeLabel];
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)Dict
{
    
    _dic =Dict;
    NSString *titleContent =[_dic objectForKey:@"title"];
    NSLog( @"%@",titleContent);
    CGSize titleSize;//通过文本得到高度
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    MLLinkLabel *cirLabel =[self viewWithTag:200];
    cirLabel.numberOfLines =0;
    cirLabel.text =titleContent;
    cirLabel.textInsets = UIEdgeInsetsMake(10*Width, 10*Width, 10*Width, 10*Width);
    if (titleSize.width>660*Width) {
        cirLabel.frame =CGRectMake(24*Width ,80*Width, 700*Width,titleSize.height);
        
        [cirLabel sizeToFit];
    }else
    {
        cirLabel.frame =CGRectMake(24*Width ,80*Width, 700*Width,titleSize.height+20*Width);
    }
    
    UILabel *timeLabel =[self viewWithTag:201];
    timeLabel.text =[_dic objectForKey:@"createtime"];
    NSLog(@"%f",cirLabel.frame.size.height);
    UIImageView *jiantou =[self viewWithTag:909];
    //    jiantou.backgroundColor =[UIColor redColor ];
    jiantou.frame = CGRectMake(672*Width,(cirLabel.height+130*Width-40*Width )/2, 40*Width, 40*Width);
    
    

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
