//
//  FileDetail.m
//  Demo_simple
//
//  Created by Doron on 16/1/26.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "FileDetail.h"

@implementation FileDetail
+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data {
    FileDetail *file = [[self alloc] init];
    file.name = name;
    file.data = data;
    return file;
}
@end
