//
//  NoticeCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "NoticeCell.h"
#import "MLLabel.h"

@implementation NoticeCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //细线
        UIImageView*xianOfGoods =[[UIImageView alloc]init];
        xianOfGoods.backgroundColor =BGColor;
        [self addSubview:xianOfGoods];
        xianOfGoods.frame =CGRectMake(0*Width,0*Width,CXCWidth,20*Width);
        xianOfGoods.tag =99;
        self.backgroundColor =[UIColor whiteColor];
//        UILabel *titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 0, CXCWidth, 80*Width)];
//        titleLabel.text =@"心体荟商城开业大酬宾";
//        titleLabel.textColor =BlackColor;
//        titleLabel.font =[UIFont systemFontOfSize:15];
//        [self addSubview:titleLabel];
        UILabel* bottomLabel = [[UILabel alloc]init];
        bottomLabel.text = @"2017-05-20";
        bottomLabel.numberOfLines =0;
        bottomLabel.textColor = TextGrayColor;
        bottomLabel.tag =201;
        bottomLabel.frame =CGRectMake(24*Width ,30*Width, 600*Width,60*Width);
        bottomLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:bottomLabel];

             //右边内容
        self.rightLabel = [[MLLinkLabel alloc]init];
        self.rightLabel.numberOfLines =0;
        self.rightLabel.textColor = TextColor;
        self.rightLabel.tag =200;
//        self.rightLabel.backgroundColor =BGColor;
        self.rightLabel.font = [UIFont systemFontOfSize:14];
        self.rightLabel.allowLineBreakInsideLinks = YES;

        [self addSubview:self.rightLabel];
        
        //右箭头图片
        UIImageView*jiantou =[[UIImageView alloc]init];
        [self addSubview:jiantou];
        [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
        jiantou.tag =909;
        
        
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
