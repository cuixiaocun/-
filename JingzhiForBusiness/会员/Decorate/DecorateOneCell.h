//
//  DecorateOneCell.h
//  家装
//
//  Created by Admin on 2017/9/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DecorateOneCell : UICollectionViewCell
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *promtpmcLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,retain)NSDictionary *dic;
@end
