//
//  EditCommentVC.h
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCommentVC : UIViewController<UITextViewDelegate>
@property (nonatomic,strong) UITextView *contentTextView;//活动内容
@property (nonatomic,strong) NSString *askId;//活动id

@end
