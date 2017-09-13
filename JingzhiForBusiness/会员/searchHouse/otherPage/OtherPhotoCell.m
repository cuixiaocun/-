//
//  OtherPhotoCell.m
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "OtherPhotoCell.h"

@implementation OtherPhotoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.backgroundColor =BGColor;
        
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0*Width, CXCWidth, 560*Width)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        _imgView =[[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"timg-8.jpeg"]];
        _imgView.backgroundColor =[UIColor grayColor];
        _imgView.frame=CGRectMake(50*Width, 10*Width, 650*Width, 530*Width);
        [bgView addSubview:_imgView];
            }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
