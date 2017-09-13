//
//  StudyDecorateCell.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "StudyDecorateCell.h"

@implementation StudyDecorateCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*Width,10,220*Width,63*Width)];
        self.promtpmcLabel.textColor = TextColor;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.promtpmcLabel.backgroundColor = BGColor;
        self.promtpmcLabel.text =@"恒大路线";
        _promtpmcLabel.textAlignment =NSTextAlignmentCenter;
        self.promtpmcLabel.layer.cornerRadius =3;
        _promtpmcLabel.numberOfLines =0;
        _promtpmcLabel.layer.masksToBounds = true;

        [self.contentView addSubview:self.promtpmcLabel];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    
    
    
}

@end
