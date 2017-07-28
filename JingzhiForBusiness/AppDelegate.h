//
//  AppDelegate.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/3/21.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
/*支付宝的*/
#import <AlipaySDK/AlipaySDK.h>


/*微信的*/
#import "WXApi.h"
#import "WXApiManager.h"


/*极光推送的*/
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>



/*百度地图的*/
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件




static NSString *appKey = @"7f98c36e1b9d6f41fe983fe7";
static NSString *channel = @"App Store";
static BOOL isProduction = YES;
@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>
{
    BMKMapManager* _mapManager;


}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIViewController *viewController;

- (void)saveContext;


@end

