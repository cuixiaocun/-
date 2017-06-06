//
//  StockCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "StockCell.h"

@implementation StockCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        xian.frame =CGRectMake(0,0*Width, CXCWidth, 20*Width);
        NSArray*leftArr =@[@"商品",@"数量",@"",@"",@"",];
        NSArray*rightArr =@[@"商品A",@"20"];
        for (int i=0; i<2; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =BGColor;
            [self addSubview:bgview];
            bgview.frame =CGRectMake(0, xian.bottom+i*105*Width, CXCWidth, 105*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(64*Width, 0,200*Width , 105*Width)];
            labe.text = leftArr[i];
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            bgview.backgroundColor =[UIColor whiteColor];
            [bgview addSubview:labe];
            //右边显示
                UILabel* rightLabel = [[UILabel alloc]init];
                rightLabel.text = rightArr[i];
                rightLabel.frame =CGRectMake(280*Width ,0, 475*Width,105*Width );
                rightLabel.textColor = BlackColor;
//                rightLabel.textAlignment=NSTextAlignmentRight;
                rightLabel.tag =200+i;
                rightLabel.font = [UIFont systemFontOfSize:14];
                [bgview addSubview:rightLabel];
            if (i==0) {
                //分割线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [bgview addSubview:xian];
                xian.frame =CGRectMake(24*Width,104*Width, CXCWidth, 1*Width);
            }
            
                
            }
        }
        
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)calculateTheGoods
{
    
    
}
-(void)setDic:(NSDictionary *)Dict
{
    _dic=Dict;
    UILabel *nameLabel =[self viewWithTag:200];
    UILabel *numLabel =[self viewWithTag:201];
  
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
