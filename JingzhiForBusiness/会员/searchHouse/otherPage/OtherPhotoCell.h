//
//  OtherPhotoCell.h
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherPhotoCell : UITableViewCell
@property(strong,nonatomic)EGOImageView *imgView;//图片
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,retain)NSDictionary *dic;

@end
