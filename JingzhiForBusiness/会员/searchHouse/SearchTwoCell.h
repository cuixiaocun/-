//
//  SearchTwoCell.h
//  家装
//
//  Created by Admin on 2017/9/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDLabTagsView.h"
@interface SearchTwoCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *phoneImageV;
@property(nonatomic,strong)SDLabTagsView *tagLabel;
@property(nonatomic,strong)UIImageView *xianImageV;

@property (nonatomic,strong)NSMutableArray *dataArr;
@end
