//
//  MyDeclarationCell.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/9.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MyDeclarationCell.h"

@implementation MyDeclarationCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView  *bgview =[[UIView alloc]initWithFrame:CGRectMake(0*Width, 0,CXCWidth , 170*Width)];
        [self addSubview:bgview];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        //商品名称
        UILabel* leftTopLabe = [[UILabel alloc]init];
        leftTopLabe.font = [UIFont systemFontOfSize:14];
        leftTopLabe.text = @"商品q";
        leftTopLabe.frame= CGRectMake(24*Width, 0,300*Width , 80*Width);
        leftTopLabe.tag =230;
        //        leftTopLabe.backgroundColor =BGColor;
        leftTopLabe.textColor = TextGrayColor;
        [bgview addSubview:leftTopLabe];
        //数量
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text =@"1箱9盒";
        rightLabel.frame =CGRectMake(250*Width ,0,475*Width,80*Width );
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.tag =240;
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = TextGrayColor;
        [bgview addSubview:rightLabel];
        
        
        
        
        //商品单价
        UILabel* priceLabe = [[UILabel alloc]init];
        priceLabe.font = [UIFont systemFontOfSize:14];
        priceLabe.text = @"¥300.00";
        priceLabe.frame= CGRectMake(24*Width, leftTopLabe.bottom+10*Width,300*Width , 80*Width);
        priceLabe.tag =250;
        priceLabe.textColor = NavColor;
        [bgview addSubview:priceLabe];
        
        //小计
        UILabel* allPriceLabel = [[UILabel alloc]init];
        allPriceLabel.textColor = BlackColor;
        
        NSString *totalString =[NSString stringWithFormat:@"小计：¥%@",@"900"];//总和
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
        NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
        [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
        [allPriceLabel setAttributedText:textColor];
        allPriceLabel.frame =CGRectMake(250*Width ,leftTopLabe.bottom+10*Width, 475*Width,80*Width );
        allPriceLabel.textAlignment=NSTextAlignmentRight;
        allPriceLabel.tag =260;
        allPriceLabel.font = [UIFont systemFontOfSize:14];
        [bgview addSubview:allPriceLabel];
        
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [bgview addSubview:xian];
        xian.frame =CGRectMake(24*Width,168.5*Width, CXCWidth, 1.5*Width);
        
    }
        return self;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic
{
    _dic=dic;
    
    UILabel *nameLabel =[self viewWithTag:230];
    UILabel *numberLabel =[self viewWithTag:240];
    UILabel *priceLabel =[self viewWithTag:250];
    UILabel *allLabel =[self viewWithTag:260];

    nameLabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"name"]];
    int box =[[_dic objectForKey:@"num"] intValue]/[[_dic objectForKey:@"boxnum"] intValue];
    int he =[[_dic objectForKey:@"num"] intValue]%[[_dic objectForKey:@"boxnum"] intValue];
    
    if (box==0) {
        numberLabel.text  = [NSString stringWithFormat:@"%d盒",he];
        
    }else if(box>0&&he>0)
    {
        numberLabel.text  = [NSString stringWithFormat:@"%d箱%d盒",box,he];
        
    }else if(box>0&&he==0)
    {
        numberLabel.text  = [NSString stringWithFormat:@"%d箱",box];
        
    }
    
    priceLabel.text =[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"price"]];
    allLabel.text =[NSString stringWithFormat:@"小计：%@",[_dic objectForKey:@"total"]];

    
    
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
