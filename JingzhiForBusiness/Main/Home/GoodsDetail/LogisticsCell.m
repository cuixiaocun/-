//
//  LogisticsCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/14.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "LogisticsCell.h"
#import "MLLabel.h"

@implementation LogisticsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [self addSubview:bgview];
        bgview.tag =10;
        bgview.frame =CGRectMake(0, 0*Width, CXCWidth, 80*Width);
        //右边内容
        self.rightLabel = [[MLLinkLabel alloc]init];
        self.rightLabel.numberOfLines =0;
        self.rightLabel.textColor = TextGrayColor;
        self.rightLabel.tag =200;
        self.rightLabel.font = [UIFont systemFontOfSize:14];
        self.rightLabel.allowLineBreakInsideLinks = YES;
        [self.rightLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",linkText ]]];
        }];

        [bgview addSubview:self.rightLabel];
        UILabel* bottomLabel = [[UILabel alloc]init];
        bottomLabel.text = @"2017-05-20";
        bottomLabel.numberOfLines =0;
        bottomLabel.textColor = TextGrayColor;
        bottomLabel.tag =201;
        bottomLabel.font = [UIFont systemFontOfSize:14];
        [bgview addSubview:bottomLabel];
        //细线
        UIImageView*xianOfGoods =[[UIImageView alloc]init];
        xianOfGoods.backgroundColor =BGColor;
        [bgview addSubview:xianOfGoods];
        xianOfGoods.frame =CGRectMake(80*Width,self.bottom-1.5*Width,CXCWidth,1.5*Width);
        xianOfGoods.tag =99;
        
        
        //上竖线
        UIImageView*xianTop =[[UIImageView alloc]init];
        xianTop.backgroundColor =TextGrayGray3Color;
        [bgview addSubview:xianTop];
        xianTop.frame =CGRectMake(49*Width,0*Width,2*Width,17*Width);
        xianTop.tag =101;
        
        
        
        //下竖线
        UIImageView*xianBottom =[[UIImageView alloc]init];
        xianBottom.backgroundColor =TextGrayGray3Color;
        [bgview addSubview:xianBottom];
        xianBottom.frame =CGRectMake(49*Width,self.bottom+10*Width,2*Width,18*Width);
        xianBottom.tag =103;
        //圈圈
        UIImageView*xianMiddle =[[UIImageView alloc]init];
        xianMiddle.backgroundColor =[UIColor colorWithRed:85/255.0 green:175/255.0 blue:96/255.0 alpha:1];
        [bgview addSubview:xianMiddle];
        [xianMiddle.layer setCornerRadius:xianMiddle.height/2];
        [xianMiddle.layer setBorderWidth:5*Width];
        xianMiddle.backgroundColor =[UIColor colorWithRed:85/255.0 green:175/255.0 blue:96/255.0 alpha:1];

        xianMiddle.layer.borderColor =[UIColor colorWithRed:188/255.0 green:230/255.0 blue:206/255.0 alpha:1].CGColor;
        xianMiddle.tag =102;
        [xianMiddle.layer setMasksToBounds:YES];
        xianMiddle.frame =CGRectMake(36*Width,26*Width,26*Width,26*Width);
        

        
        
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)Dict
{
    
    _dic =Dict;
    NSString *titleContent =[_dic objectForKey:@"key"];
    NSLog( @"%@",titleContent);
    CGSize titleSize;//通过文本得到高度
    
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(600*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UIView *view =[self viewWithTag:10];
    view .frame =CGRectMake(0, 0*Width, CXCWidth, titleSize.height+100*Width);
    UILabel *cirLabel =[self viewWithTag:200];
    cirLabel.numberOfLines =0;
    cirLabel.text =titleContent;
    if(titleSize.width<500)
    {
        cirLabel.frame =CGRectMake(120*Width ,20*Width, 600*Width,titleSize.height);
        
    }else
    {
        cirLabel.frame =CGRectMake(120*Width ,20*Width, 600*Width,titleSize.height);
        [cirLabel sizeToFit];
        
    }
    
    UILabel *timeLabel =[self viewWithTag:201];
    timeLabel.frame =CGRectMake(120*Width ,cirLabel.bottom+10*Width, 600*Width,50*Width);
    timeLabel.text =[_dic objectForKey:@"time"];
    
    NSLog(@"%f",cirLabel.frame.size.height);
    UIImageView *imgv=[self viewWithTag:101];
    UIImageView *imgv2=[self viewWithTag:103];
    UIImageView *imgvx=[self viewWithTag:99];
    UIImageView *imgvy=[self viewWithTag:102];
    
    
    imgvx.bottom =titleSize.height-1.5*Width+100*Width;
    imgv.frame =CGRectMake(60*Width,0 , 2*Width,55*Width );
    imgv2.frame =CGRectMake(60*Width,70*Width, 2*Width,titleSize.height+100*Width-70*Width);
    imgv2.hidden =NO;
    imgv.hidden =NO;
    
    if ([[_dic objectForKey:@"index"]isEqualToString:@"0"]) {
        imgv.hidden =YES;
        imgvy.frame =CGRectMake(43*Width,50*Width, 34*Width, 34*Width);
        imgv2.hidden =NO;
        timeLabel.textColor =[UIColor colorWithRed:101/255.0 green:189/255.0 blue:133/255.0 alpha:1];
        cirLabel.textColor =[UIColor colorWithRed:101/255.0 green:189/255.0 blue:133/255.0 alpha:1];
        
    }else if ([[_dic objectForKey:@"index"]isEqualToString:@"2"]) {
        imgv2.hidden =YES;
        imgv.hidden =NO;
        imgvy.frame =CGRectMake(50*Width,53*Width, 20*Width, 20*Width);
        imgvy.backgroundColor =TextGrayGray3Color;
        imgvy.layer.borderColor =TextGrayGray3Color.CGColor;
        

    }else
    {
        imgvy.frame =CGRectMake(50*Width,53*Width, 20*Width, 20*Width);
        imgvy.backgroundColor =TextGrayGray3Color;
        imgvy.layer.borderColor =TextGrayGray3Color.CGColor;

    
    }
    [imgvy.layer setCornerRadius:imgvy.height/2];

    
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
