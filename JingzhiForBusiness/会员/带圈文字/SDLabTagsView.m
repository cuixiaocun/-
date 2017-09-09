//
//  SDLabTagsView.m
//  SDTagsView
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "SDLabTagsView.h"
#import "SDHeader.h"
#import "TagsModel.h"
#import "SDHelper.h"
@interface SDLabTagsView ()
{
    UIView *sdTagsView;
}
@property (nonatomic,strong)UILabel *tagsLab;
@end
@implementation SDLabTagsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUP];
      
    }
    return self;
}

-(void)setUP{
    // 创建标签容器
    sdTagsView = [[UIView alloc] init];
    sdTagsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:sdTagsView];
}

+(instancetype)sdLabTagsViewWithTagsArr:(NSArray *)tagsArr{
    SDLabTagsView *sdLabTagsView =[[SDLabTagsView alloc]init];
    sdLabTagsView.tagsArr =tagsArr;
    [sdLabTagsView setUItags:tagsArr];
    return sdLabTagsView;
}

-(void)setUItags:(NSArray *)arr{
    
    int width = 0;
    
    int j = 0;
    
    int row = 0;
    
    
    for (int i = 0 ; i < arr.count; i++) {
        
        TagsModel *model =arr[i];
        int labWidth = [SDHelper widthForLabel:model.title fontSize:11]+10;
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(8*Width*j + width, row * 40*Width, labWidth, 33*Width);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.text =model.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        label.numberOfLines = 1;
        label.layer.borderWidth = 1;
        label.textColor = [SDHelper getColor:model.color];
        label.layer.borderColor = [SDHelper getColor:model.color].CGColor;
        [sdTagsView addSubview:label];
        
        width = width + labWidth;
        
        j++;
        
        if (width > 460*Width - 50*Width) {
            
            j = 0;
            width = 10;
            row++;
            label.frame = CGRectMake(8*Width*j + width, row * 40*Width, labWidth, 33*Width);
            width = width + labWidth;
            j++;
            
        }

        if (i==arr.count-1) {
            _rowNumber =row;
        }
    }
    
}



@end
