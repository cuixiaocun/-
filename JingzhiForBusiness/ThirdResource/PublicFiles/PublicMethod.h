//
//  PublicMethod.h
//  CarShow
//
//  Created by wang rain on 12-4-24.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "ProgressHUD.h"
#import "WXY_ActiveView.h"
#import "AFNetworking.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "DDMenuController.h" 
#import "EGOImageView.h"
#import "DesSecret.h"

//服务器地址
#define IMAGEURL  @"https://www.lianqunwuye.com:4432/SmartCommunity/"
#define SERVERURL @"https://www.lianqunwuye.com:4432/SmartCommunity_API"
//是否为空
#define IsNilString(__String)   (__String==nil || [__String isEqualToString:@"null"] || [__String isEqualToString:@"<null>"]||[__String isEqual:[NSNull null]]||[__String isEqualToString:@"(null)"]||[__String isEqualToString:@"null~null"])


#define TextBlueColor ([UIColor colorWithRed:20/255.0 green:138/255.0 blue:246/255.0 alpha:1])
#define TextGrayColor ([UIColor colorWithRed:81/255.0 green:99/255.0 blue:119/255.0 alpha:1])
#define BGColor ([UIColor colorWithRed:241/255.0 green:242/255.0 blue:243/255.0 alpha:1])
#define NavColor ([UIColor colorWithRed:241/255.0 green:44/255.0 blue:66/255.0 alpha:1])
#define NomalBtnBg ([UIColor colorWithRed:127/255.0 green:173/255.0 blue:206/255.0 alpha:1])
#define HightBtnBg ([UIColor colorWithRed:51/255.0 green:127/255.0 blue:179/255.0 alpha:1])
#define Version ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey])

#define CXCHeight ([[UIScreen mainScreen] bounds].size.height)/1.0
#define CXCWidth ([[UIScreen mainScreen] bounds].size.width)/1.0
#define Width [UIScreen mainScreen].bounds.size.width/750.0

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define Frame_Y ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0 ? 20 : 0.0)

#define KEYOFMD5 @"123456"









@interface PublicMethod : NSObject



+(NSString *)md5:(NSString *)str;

+(void)setObject:(id)object key:(NSString *)key;

+(id)getObjectForKey:(NSString *)key;

+(void)removeObjectForKey:(NSString *)key;

+(id)getTabber;//tabber

//获取手机唯一标识
+(NSString *)getAppKey;
//弹出提示框
+(void)setAlertInfo:(NSString *)info andSuperview:(UIView *)view;
+ (AFSecurityPolicy*)customSecurityPolicy;//验证证书
+(void)AFNetworkPOSTurl:(NSString *)urlString paraments:(NSDictionary *)dic success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail;
+ (NSDictionary*)ASCIIwithDic:(NSDictionary *)dict;
//存取字典
+ (void) saveData:(NSDictionary *)dict withKey:(NSString *)key;
+ (NSDictionary *) getDataKey:(NSString *)key;

//存取字符串
+ (void) saveDataString:(NSString *)string withKey:(NSString *)key;
+ (NSString *) getDataStringKey:(NSString *)key;

//存取数组
+ (void) saveArrData:(NSArray *)array withKey:(NSString *)key;
+ (NSArray *) getArrData:(NSString *)key;
//删除数据
+(void)removeObjectForKey:(NSString *)key;

@end
