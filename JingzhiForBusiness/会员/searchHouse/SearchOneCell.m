//
//  SearchOneCell.m
//  家装
//
//  Created by Admin on 2017/9/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "SearchOneCell.h"
#import "TagsModel.h"
@implementation SearchOneCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        
        //图片
        _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
        _phoneImageV.backgroundColor =BGColor;
        _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 260*Width, 190*Width);
        [self addSubview:_phoneImageV];
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_phoneImageV.top, 460*Width, 40*Width)];
        _nameLabel.text = @"歌尔绿城";
        _nameLabel.textColor=TextColor;
        _nameLabel.numberOfLines =0;
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        
        //地址
        _addressLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+30*Width, _nameLabel.bottom,430*Width, 100*Width)];
        _addressLabel.numberOfLines =0;
        _addressLabel.text =@"高新区-高新一路东方东街1999号路北200米";
        _addressLabel.font =[UIFont systemFontOfSize:12];
        _addressLabel.textColor =TextGrayColor;
        [self addSubview:_addressLabel];

        _tagLabel =[[UILabel alloc]init];
        _tagLabel.frame =CGRectMake(_phoneImageV.right+30*Width, _addressLabel.bottom, 120*Width, 40*Width);
        _tagLabel.textAlignment  =NSTextAlignmentCenter;
        [_tagLabel.layer setBorderWidth:1];
        [_tagLabel.layer setCornerRadius:2];
        [_tagLabel.layer setMasksToBounds:YES];
        _tagLabel.font =[UIFont systemFontOfSize:13];
        _tagLabel.textColor =TextBlueColor;
        _tagLabel.layer.borderColor =TextBlueColor.CGColor;

        [self addSubview:_tagLabel];

        //价格
        _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+30*Width, _tagLabel.bottom, 260*Width, 60*Width)];
        _priceLabel.text =@"12000.00元/m²";
        _priceLabel.font =[UIFont systemFontOfSize:13];
        _priceLabel.textColor =NavColor;
        [self addSubview:_priceLabel];
        //面积
        _areaLabel =[[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.right+30*Width, _tagLabel.bottom, 270*Width, 60*Width)];
        _areaLabel.text =@"100-300m²";
        _areaLabel.font =[UIFont systemFontOfSize:12];
        _areaLabel.textColor =TextGrayColor;
        [self addSubview:_areaLabel];
        //线
        _xianImageV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width,270*Width-1.5*Width, 690*Width, 1.5*Width)];
        _xianImageV.backgroundColor =BGColor;
        [self addSubview:_xianImageV];
    

    
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    [_phoneImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dic objectForKey:@"thumb"]]]];
    _nameLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"name"])?@"":[dic objectForKey:@"name"] ];
    _addressLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"addr"])?@"":[dic objectForKey:@"addr"] ];
    _areaLabel.text =[NSString stringWithFormat:@"%@", IsNilString([dic  objectForKey:@"area_name"])?@"":[dic objectForKey:@"area_name"] ];
    
    if([[NSString stringWithFormat:@"%@",[dic  objectForKey:@"xinxitype"]] isEqualToString:@"0"])
    {
        _tagLabel.text =@"新  房";
        _tagLabel.textColor =NavColor;
        _tagLabel.layer.borderColor =NavColor.CGColor;
        _priceLabel.text =[NSString stringWithFormat:@"售价:%@元/m²", IsNilString([dic  objectForKey:@"price"])?@"":[dic objectForKey:@"price"] ];


    }else if([[NSString stringWithFormat:@"%@",[dic  objectForKey:@"xinxitype"]] isEqualToString:@"1"])
    {
        _tagLabel.text =@"二手房";
        _tagLabel.textColor =[UIColor colorWithRed:0 green:213/255.00 blue:155/255.00 alpha:1];
        _tagLabel.layer.borderColor =[UIColor colorWithRed:0 green:213/255.00 blue:155/255.00 alpha:1].CGColor;
        _priceLabel.text =[NSString stringWithFormat:@"售价:%@元/m²", IsNilString([dic  objectForKey:@"price"])?@"":[dic objectForKey:@"price"] ];

    }else if([[NSString stringWithFormat:@"%@",[dic  objectForKey:@"xinxitype"]] isEqualToString:@"2"])
    {
        _tagLabel.text =@"租  房";
        _tagLabel.textColor =[UIColor colorWithRed:22/255.00 green:128/255.00 blue:240/255.00 alpha:1];
        _tagLabel.layer.borderColor =[UIColor colorWithRed:22/255.00 green:128/255.00 blue:240/255.00 alpha:1].CGColor;
        _priceLabel.text =[NSString stringWithFormat:@"月租金:%@元/月", IsNilString([dic  objectForKey:@"price"])?@"":[dic objectForKey:@"price"] ];

    }

}

@end
