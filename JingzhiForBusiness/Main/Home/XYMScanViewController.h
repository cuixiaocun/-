//
//  XYMScanViewController.h
//  healthcoming
//
//  Created by jack xu on 16/11/15.
//  Copyright © 2016年 Franky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYMScanViewControllerDelegate <NSObject>

-(void)getScanString:(NSString*)scanDataString;

@end


@interface XYMScanViewController : UIViewController
@property (nonatomic,assign) id<XYMScanViewControllerDelegate> delegate;
@property(nonatomic,assign)NSString *whichView;

//扫码框的宽（正方形）
@property(nonatomic,assign)int scanViewW;
@end
