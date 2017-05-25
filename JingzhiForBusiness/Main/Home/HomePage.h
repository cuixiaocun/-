//
//  HomePage.h
//  Demo_simple
//
//  Created by 丁振 on 15/7/8.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicMethod.h"

@interface HomePage : UIViewController<NSURLSessionDelegate>

@property(nonatomic,retain)NSURLConnection *connection;

//+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
