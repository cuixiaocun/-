//
//  NearDelegateCell.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/24.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearDelegateCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
