//
//  PublicMethod.h
//  CarShow
//
//  Created by wang rain on 12-4-24.
//  Copyright (c) 2012年. All rights reserved.
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
#import "MBProgressHUD.h"
#import "MBProgressHUD+MP.h"
#import "SRActionSheet.h"
#import "UIImageView+WebCache.h"
#import "LoginPage.h"

//服务器地址
#define IMAGEURL  @"http://www.leplife.com/attachs/"
#define SERVERURL @"http://www.leplife.com"
//是否为空
#define IsNilString(__String)   (__String==nil ||[__String isEqual:[NSNull null]]|| [__String isEqualToString:@"null"] || [__String isEqualToString:@"<null>"]||[__String isEqualToString:@"(null)"]||[__String isEqualToString:@"null~null"]||[__String isEqualToString:@""])

#define orangeColor ([UIColor colorWithRed:255/255.0 green:102/255.0 blue:51/255.0 alpha:1])//

#define TextBlueColor ([UIColor colorWithRed:39/255.0 green:136/255.0 blue:236/255.0 alpha:1])//
#define TextColor ([UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1])//黑色的字
#define BlackColor ([UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1])//黑色的字

#define TextGrayColor ([UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1])//灰色的字
#define TextGrayGrayColor ([UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1])//灰色的字
#define TextGrayGray3Color ([UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1])//灰色的字

#define BGColor ([UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1])//背景颜色
#define NavColor ([UIColor colorWithRed:255/255.0 green:102/255.0 blue:51/255.0 alpha:1])//导航栏颜色
#define NavColorWhite ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1])//导航栏颜色

#define NomalBtnBg ([UIColor colorWithRed:127/255.0 green:173/255.0 blue:206/255.0 alpha:1])//按钮普通颜色
#define SelectBtnBg ([UIColor colorWithRed:51/255.0 green:127/255.0 blue:179/255.0 alpha:1])//按钮选中颜色
#define Version ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey])
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)


#define CXCHeight   ( ([UIScreen mainScreen].bounds.size.height==812.00)?([[UIScreen mainScreen] bounds].size.height-34):([[UIScreen mainScreen] bounds].size.height)/1.000)
#define CXCWidth ([[UIScreen mainScreen] bounds].size.width/1.000)
#define Width ([UIScreen mainScreen].bounds.size.width/750.000)
#define navBackarrow @"sf_icon_goBack"//返回箭头
#define navBackarrowWhite @"register_btn_goBack_white"
#define shopingCart @"ShopingCart"//购物车数组
#define member @"member"//会员字典
//#define agen @"agen"//会员字典

#define Frame_rectStatus ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define Frame_rectNav (self.navigationController.navigationBar.frame.size.height)
#define Frame_NavAndStatus (self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)
#define yuanjiao 4
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define KEYOFMD5 @"123456"
#define ThemeNotificationInformatica @"ThemeNotificationInformatica"

@interface PublicMethod : NSObject
{
    
}

//md5加密
+(NSString *)md5:(NSString *)str;
+(BOOL)isMobileNumber:(NSString *)mobile;
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
+(void)AFNetworkPOSTurl:(NSString *)urlString paraments:(NSDictionary *)dic addView:(UIView *)view addNavgationController:(UINavigationController*)nav success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail;
+(void)AFNetworkGETurl:(NSString *)urlString paraments:(NSDictionary *)dic addView:(UIView *)view addNavgationController:(UINavigationController*)nav success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail;
+(void)personalAFNetworkSuccess:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail;
//存取字符串
+ (void) saveDataString:(NSString *)string withKey:(NSString *)key;
+ (NSString *) getDataStringKey:(NSString *)key;

//存取数组
+ (void) saveArrData:(NSArray *)array withKey:(NSString *)key;
+ (NSArray *) getArrData:(NSString *)key;

//存取可变数组
+(void)setObject:(id)object key:(NSString *)key;

+(id)getObjectForKey:(NSString *)key;

//删除数据
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;
+(NSString*)stringNilString:(NSString *)string;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+(void)NavgationController:(UINavigationController*)na;
@end
