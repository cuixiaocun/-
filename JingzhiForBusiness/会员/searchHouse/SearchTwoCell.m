//
//  SearchTwoCell.m
//  家装
//
//  Created by Admin on 2017/9/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "SearchTwoCell.h"
#import "TagsModel.h"
@implementation SearchTwoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*Width,30*Width, 460*Width, 100*Width)];
        _nameLabel.text = @"重要！买二手房怎么查看房屋产权手房怎么查看房屋产权及其年限";
        _nameLabel.textColor=TextColor;
        _nameLabel.numberOfLines =0;
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        

        //图片
        _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
        _phoneImageV.backgroundColor =BGColor;
        _phoneImageV.frame=CGRectMake(_nameLabel.right+24*Width, 20*Width, 220*Width, 170*Width);
        [self addSubview:_phoneImageV];
        _tagLabel =[SDLabTagsView sdLabTagsViewWithTagsArr:self.dataArr];
        _tagLabel.frame =CGRectMake(_nameLabel.left, _nameLabel.bottom+10*Width, 460*Width, (_tagLabel.rowNumber+1)*30);
        [self addSubview:_tagLabel];
        
           //面积
        _xianImageV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width,210*Width-1.5*Width, 690*Width, 1.5*Width)];
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
