//
//  ForgetPasswordVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/29.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordVC : UIViewController<UITextFieldDelegate>
@property NSString *idno;
@property (nonatomic,retain) NSString *phoneNum;
@property (nonatomic,copy) NSString *isHYOrDL;//会员1代理2



@end
