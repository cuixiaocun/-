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
        _addressLabel.text =@"高新区-高新一路东方东街1999号路北200fujkdsfh米";
        _addressLabel.font =[UIFont systemFontOfSize:12];
        _addressLabel.textColor =TextGrayColor;
        [self addSubview:_addressLabel];

        _tagLabel =[SDLabTagsView sdLabTagsViewWithTagsArr:self.dataArr];
//        _tagLabel.backgroundColor =orangeColor ;
        _tagLabel.frame =CGRectMake(_phoneImageV.right+30*Width, _addressLabel.bottom, 460*Width, (_tagLabel.rowNumber+1)*40*Width);
        [self addSubview:_tagLabel];
        //价格
        _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+30*Width, _tagLabel.bottom, 220*Width, 60*Width)];
        _priceLabel.text =@"12000.00元/m²";
        _priceLabel.font =[UIFont systemFontOfSize:13];
        _priceLabel.textColor =NavColor;
        [self addSubview:_priceLabel];
        //面积
        _areaLabel =[[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.right+30*Width, _tagLabel.bottom, 220*Width, 60*Width)];
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
- (NSMutableArray *)dataArr{
    {
        if (!_dataArr){
            NSArray *dataArr =@[@{@"color":@"eb3027",@"title":@"22"},@{@"color":@"22b6ff",@"title":@"2222222"},@{@"color":@"51b20a",@"title":@"222"},@{@"color":@"eb3027",@"title":@"122222"}];
            NSMutableArray *tempArr =[NSMutableArray array];
            for (NSDictionary *dict in dataArr){
                TagsModel *model =[[TagsModel alloc]initWithTagsDict:dict];
                [tempArr addObject:model];
            }
            _dataArr =[tempArr copy];
        }
        return _dataArr;
    }

}
-(void)setDic:(NSDictionary *)dic
{


}

@end
