//
//  SDLabTagsView.h
//  SDTagsView
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDLabTagsView : UIView
@property (nonatomic,strong)NSArray *tagsArr;
@property (nonatomic,assign)NSInteger rowNumber;

+(instancetype)sdLabTagsViewWithTagsArr:(NSArray *)tagsArr;
@end
