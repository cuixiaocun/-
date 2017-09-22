//
//  IntroduceOneCell.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "IntroduceOneCell.h"

@implementation IntroduceOneCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {      self.backgroundColor = [UIColor whiteColor];
        NSString *titleContent =@"个人简介：看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美.";
        CGSize titleSize;//通过文本得到高度
        titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel* proLabel = [[UILabel alloc]init];
        proLabel.numberOfLines =0;
        proLabel.textColor = TextColor;
        proLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:proLabel];
        proLabel.text = titleContent;
        proLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
        _ideaLabel =proLabel;
        [self.contentView addSubview:proLabel];
        
            }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    
    
}

@end
