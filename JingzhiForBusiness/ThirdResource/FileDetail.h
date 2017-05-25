//
//  FileDetail.h
//  Demo_simple
//
//  Created by Doron on 16/1/26.
//  Copyright © 2016年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDetail : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSData *data;
+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data;
@end
