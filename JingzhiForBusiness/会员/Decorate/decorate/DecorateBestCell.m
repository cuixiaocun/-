//
//  DecorateBestCell.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateBestCell.h"

@implementation DecorateBestCell
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

        self.promtpmcLabel = [[UILabel alloc] initWithFrame:CGRectMake(23*Width,_topMCImage.bottom,400*Width,82*Width)];
        self.promtpmcLabel.textColor = TextColor;
        self.promtpmcLabel.font = [UIFont fontWithName:@"Arial" size:14];
        self.promtpmcLabel.backgroundColor = [UIColor clearColor];
        self.promtpmcLabel.text =@"现代简约中式效果图-恒大";
        _promtpmcLabel.numberOfLines =0;
        [self.contentView addSubview:self.promtpmcLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(400*Width,_promtpmcLabel.top,320*Width,82*Width)];
        self.nameLabel.textColor = TextGrayColor;
        self.nameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.text =@"山东桥通天下";
        _nameLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
    
}
-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    self.topMCImage.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"img"]]];
    self.promtpmcLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    self.nameLabel.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"price"]];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
