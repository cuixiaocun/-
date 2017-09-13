//
//  StudyTableViewCell.h
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *promtpmcLabel;
@property(nonatomic,retain)NSDictionary *dic;
@end
