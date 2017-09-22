//
//  FindCompanyFiveCell.h
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCompanyFiveCell : UICollectionViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,strong)UIImageView *phoneImageV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *caseLabel;
@property(nonatomic,strong)UILabel *collegesLabel;
@property(nonatomic,strong)UILabel *ideaLabel;
@property(nonatomic,strong)UIImageView *xianImageV;
@property (nonatomic,strong)NSMutableArray *dataArr;


@end
