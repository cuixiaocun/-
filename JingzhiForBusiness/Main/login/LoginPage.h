//
//  LoginPage.h
//  Demo_simple
//
//  Created by Eleven on 15/4/19.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicMethod.h"

@interface LoginPage : UIViewController<UITextFieldDelegate>
{
}
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
