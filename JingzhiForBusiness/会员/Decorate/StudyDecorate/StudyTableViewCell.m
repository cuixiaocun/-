//
//  StudyTableViewCell.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "StudyTableViewCell.h"

@implementation StudyTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        self.topMCImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0*Width,0*Width,CXCWidth,420*Width)];
        self.topMCImage.backgroundColor = BGColor;
        self.topMCImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topMCImage];
        _topMCImage.image =[UIImage imageNamed:@"timg-8.jpeg"];
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, _topMCImage.bottom, CXCWidth, 82*Width)];
        bgView.backgroundColor =[UIColor whiteColor];
        [self.contentView   addSubview:bgView];
        
        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(23*Width,_topMCImage.bottom,700*Width,82*Width)];
        self.promtpmcLabel.textColor = TextColor;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"室内装修风格有哪些？21种装修风格大普及";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
        
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [self.topMCImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]]];
    
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"title"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
