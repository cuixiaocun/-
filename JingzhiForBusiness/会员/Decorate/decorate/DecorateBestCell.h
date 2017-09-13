//
//  DecorateBestCell.h
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DecorateBestCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *promtpmcLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,retain)NSDictionary *dic;
@end
