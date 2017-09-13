//
//  MenuChooseVC.h
//  家装
//
//  Created by Admin on 2017/9/9.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropMenuView.h"
///添加代理，用于按钮加减的实现
@protocol MenuChooseDelegate <NSObject>

-(void)btnClickBtn:(UIButton *)cell;
@end

@interface MenuChooseVC : UIView<DropMenuViewDelegate>
{
    UIScrollView *sdTagsView;
    NSInteger currTag;
    NSArray* allArr;


}
@property(assign,nonatomic)id<MenuChooseDelegate>delegate;
@property (nonatomic, strong) DropMenuView *oneLinkageDropMenu;
@property (nonatomic, strong) NSArray *addressArr;

- (id)initWithFrame:(CGRect)frame buttonArr:(NSArray *)btnArr;
@end
