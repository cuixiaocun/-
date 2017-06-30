//
//  SetIDNumberVC.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/1.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetIDNumberVCDelegate <NSObject>
@optional
- (void)successUpPhoto:(NSString*)str;
@end

@interface SetIDNumberVC : UIViewController
@property (nonatomic, weak) id<SetIDNumberVCDelegate> delegate;

@end
