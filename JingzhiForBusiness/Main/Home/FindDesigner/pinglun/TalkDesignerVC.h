//
//  TalkDesignerVC.h
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@interface TalkDesignerVC : UIViewController
@property(nonatomic,strong)UIImageView *phoneImageV;
@property (nonatomic,strong) StarView *sjImgView;
@property (nonatomic,strong) StarView *fwImgView;
@property (nonatomic,strong) StarView *txImgView;
@property(strong,nonatomic)NSString *sjsUserId;

@end
