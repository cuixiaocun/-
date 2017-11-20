//
//  ShopStoreTalkCell.h
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@interface ShopStoreTalkCell : UICollectionViewCell{
    UIImageView *xian;
}
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) StarView *starImgView;
@property (nonatomic,strong) UIImageView *xian;
@property (nonatomic,strong) UIView *bottomV;

@property(nonatomic,retain)NSDictionary *dic;


@end
