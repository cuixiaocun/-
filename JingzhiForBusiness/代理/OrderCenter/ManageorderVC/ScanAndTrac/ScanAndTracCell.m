//
//  ScanAndTracCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ScanAndTracCell.h"

@implementation ScanAndTracCell

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
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text = @"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人";
        rightLabel.textColor = NavColor;
        rightLabel.numberOfLines =0;
        rightLabel.textColor = BlackColor;
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =200;
        rightLabel.font = [UIFont systemFontOfSize:14];
        [bgview addSubview:rightLabel];
        //细线
        UIImageView*xianOfGoods =[[UIImageView alloc]init];
        xianOfGoods.backgroundColor =BGColor;
        [bgview addSubview:xianOfGoods];
        xianOfGoods.frame =CGRectMake(80*Width,self.bottom-1.5*Width,CXCWidth,1.5*Width);
        xianOfGoods.tag =99;

        
        //上竖线
        UIImageView*xianTop =[[UIImageView alloc]init];
        xianTop.backgroundColor =[UIColor colorWithRed:239/255.0 green:155/255.0 blue:159/255.0 alpha:1];
        [bgview addSubview:xianTop];
        xianTop.frame =CGRectMake(48*Width,0*Width,2*Width,17*Width);
        xianTop.tag =101;
       

        //圈圈
        UIImageView*xianMiddle =[[UIImageView alloc]init];
        xianMiddle.backgroundColor =[UIColor colorWithRed:237/255.0 green:71/255.0 blue:58/255.0 alpha:1];
        [bgview addSubview:xianMiddle];
        [xianMiddle.layer setCornerRadius:13*Width];
        [xianMiddle.layer setBorderWidth:5*Width];
        xianMiddle.layer.borderColor =[UIColor colorWithRed:242/255.0 green:154/255.0 blue:156/255.0 alpha:1].CGColor;
        xianMiddle.tag =102;
        [xianMiddle.layer setMasksToBounds:YES];
        xianMiddle.frame =CGRectMake(36*Width,26*Width,26*Width,26*Width);
        

        //下竖线
        UIImageView*xianBottom =[[UIImageView alloc]init];
        xianBottom.backgroundColor =[UIColor colorWithRed:239/255.0 green:155/255.0 blue:159/255.0 alpha:1];
        [bgview addSubview:xianBottom];
        xianBottom.frame =CGRectMake(48*Width,self.bottom+10*Width,2*Width,18*Width);
        xianBottom.tag =103;
        

        
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)Dict
{
    
   _dic =Dict;
    NSString *titleContent =[_dic objectForKey:@"key"];
    NSLog( @"%@",titleContent);
    CGSize titleSize;//通过文本得到高度
    
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(500*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UIView *view =[self viewWithTag:10];
    view .frame =CGRectMake(0, 0*Width, CXCWidth, titleSize.height+40*Width);
    UILabel *cirLabel =[self viewWithTag:200];
    cirLabel.numberOfLines =0;
    cirLabel.text =titleContent;
    if(titleSize.width<500)
    {
       cirLabel.frame =CGRectMake(200*Width ,20*Width, 525*Width,titleSize.height);
    }else
    {
        cirLabel.frame =CGRectMake(200*Width ,20*Width, 525*Width,titleSize.height);
        [cirLabel sizeToFit];
    
    }
    
    
   
    NSLog(@"%f",cirLabel.frame.size.height);
    UIImageView *imgv=[self viewWithTag:101];
    UIImageView *imgv2=[self viewWithTag:103];
    UIImageView *imgvx=[self viewWithTag:99];
    UIImageView *imgvy=[self viewWithTag:102];
    
    
    imgvx.bottom =titleSize.height-1.5*Width+40*Width;
    imgvy.frame =CGRectMake(36*Width,titleSize.height/2-13*Width+20*Width,  26*Width, 26*Width);
    imgv.frame =CGRectMake(49*Width,0 , 2*Width,titleSize.height/2-13*Width-10*Width+20*Width );
    imgv2.frame =CGRectMake(49*Width,titleSize.height/2+10*Width+13*Width+20*Width, 2*Width,titleSize.height/2-13*Width-10*Width+20*Width );

    
    
    

    imgv2.hidden =NO;
    imgv.hidden =NO;

    if ([[_dic objectForKey:@"index"]isEqualToString:@"0"]) {
        imgv.hidden =YES;
        imgv2.hidden =NO;

    }
    if ([[_dic objectForKey:@"index"]isEqualToString:@"2"]) {
        imgv2.hidden =YES;
        imgv.hidden =NO;

    }

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
