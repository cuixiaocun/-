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
        self.webView= [[UIWebView alloc] initWithFrame:CGRectMake(0,_titleLabel.bottom, CXCWidth, 10)];
        self.webView.scrollView.scrollEnabled = NO;
        self.webView.scrollView.pagingEnabled = NO;
        self.webView.delegate = self;
        _webView.opaque = NO;
        _webView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.webView];

        
        
//        //右边内容
//        _contentLabel = [[MLLinkLabel alloc]init];
//        self.contentLabel.numberOfLines =0;
//        self.contentLabel.textColor = TextColor;
//        self.contentLabel.tag =200;
//        //self.rightLabel.backgroundColor =BGColor;
//        self.contentLabel.font = [UIFont systemFontOfSize:14];
//        self.contentLabel.allowLineBreakInsideLinks = YES;
//        [self addSubview:self.contentLabel];
//        _contentLabel.text =@"看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美。也开始想象自己有这样的家。我最开始感觉就是在看软装，这个沙发，那个吊灯...totally wrong direction.现在开始落地起来，开始找装修公司设计师，SD、MF、NH，开始看预算，开始和小伙伴聊中央空调，\n西门子开关，比较优劣，开始看各位16楼的日记，哈，工作之余的事情就是装修！现在是午休时间，给自己开了篇。";
//        CGSize titleSize;//通过文本得到高度
//        titleSize = [_contentLabel.text boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//        _contentLabel.frame =CGRectMake(24*Width ,_titleLabel.bottom, 700*Width,titleSize.height);
//        _contentLabel.numberOfLines =0;
//        _webImage =[[WBImageView alloc]initWithFrame:CGRectMake(25*Width, _contentLabel.bottom, 700*Width,170*Width )];
//        _webImage.userInteractionEnabled = YES;
//        _webImage.hidden = NO;
//        _webImage.left = 15;
//
//        _webImage.top = _contentLabel.bottom;
//        _webImage.height = [WBImageView heightForCount:9];//因为开始的时候是以坐标做得这里应该是照片的数量
//        NSLog(@"%f-------",_webImage.height);
//        _webImage.width = 320;
//        [_webImage setDataList:@[]];
//        [_webImage setTag:777];
//        [self addSubview:_webImage];
//
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
    [self.webView loadHTMLString:[NSString stringWithFormat:@"%@",[[_dic objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<img src=\"/./attachs/" withString:[NSString stringWithFormat:@"%@%@",@"<img src=\"",IMAGEURL]]] baseURL:nil];
    self.height =[[_dic objectForKey:@"heighOfWebview"] floatValue];
    _webView.frame =CGRectMake(0,_titleLabel.bottom ,700*Width  ,[[_dic objectForKey:@"heighOfWebview"] floatValue]-180*Width);
    NSLog(@"%@...................",[[_dic objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<img src=\"/./attachs/" withString:[NSString stringWithFormat:@"%@%@",@"<img src=\"",IMAGEURL]]);
    _timeLabel.text =[PublicMethod timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"dateline"]]];
    _timeLabel.frame =CGRectMake(25*Width, _webView.bottom, 700*Width,50*Width );

    
//    _dic =Dict;
//    NSString *titleContent =[_dic objectForKey:@"title"];
//    NSLog( @"%@",titleContent);
//    CGSize titleSize;//通过文本得到高度
//    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//
//    MLLinkLabel *cirLabel =[self viewWithTag:200];
//    cirLabel.numberOfLines =0;
//    cirLabel.text =titleContent;
//    cirLabel.textInsets = UIEdgeInsetsMake(10*Width, 10*Width, 10*Width, 10*Width);
//    if (titleSize.width>660*Width){
//        cirLabel.frame =CGRectMake(24*Width ,80*Width, 700*Width,titleSize.height);
//
//        [cirLabel sizeToFit];
//    }else
//    {
//        cirLabel.frame =CGRectMake(24*Width ,80*Width, 700*Width,titleSize.height+20*Width);
//    }
    
    
    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
    NSString *HTMLSource = [self.webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    
    NSLog(@"HTMLSource=========%@",HTMLSource);

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mrak - UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='auto';"];//让用户可以选中webview里面内
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='auto';"];//可以响应用户的手势
//
//    NSURL *url = [request URL];
//    if (![url host]) {
//          return YES;
//       }
//     return NO;
//}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    CGFloat height = webView.scrollView.contentSize.height;
//    //获取webview内容的高度
//    self.webView.height = height;
//    NSLog(@"height========%.f",height);
//    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    NSLog(@"title========%@",title);
//    _timeLabel.frame =CGRectMake(25*Width, _webView.bottom, 700*Width,50*Width );
    
    CGSize fittingSize = webView.scrollView.contentSize;
    if ([[_dic objectForKey:@"heighOfWebview"]isEqualToString:@"0"]||[[_dic objectForKey:@"heighOfWebview"] floatValue]!=fittingSize.height) {
            self.height = fittingSize.height+180*Width;
            self.webView.frame = CGRectMake(0,_titleLabel.bottom , fittingSize.width, fittingSize.height);
            _timeLabel.frame =CGRectMake(25*Width, _webView.bottom, 700*Width,50*Width );
            NSLog(@"1111111111111111111%f", self.height);
            // 用通知发送加载完成后的高度
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WEBVIEW_HEIGHT" object:self userInfo:nil];
        }
  
}
@end
