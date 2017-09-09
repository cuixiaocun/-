//
//  ComMallCollectionViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区商城按钮

#import <UIKit/UIKit.h>
#import "SDImageCache.h"
@interface ComMallCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *promtpmcLabel;
@property (nonatomic,strong) UILabel *pricesLabel;
@property(nonatomic,retain)NSDictionary *dic;

@end
