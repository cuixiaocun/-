//
//  AppDelegate.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/3/21.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AppDelegate.h"
#import "JPushViewController.h"
#import "Harpy.h"

//第三方tabbar
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"

//会员代理登录是一个界面
#import "LoginPage.h"

/*如下是会员的的*/
#import "HomePage.h"
#import "SearchHouseVC.h"
#import "SJSPersonalCenterVC.h"
#import "ShoppingCartVC.h"
#import "ShoppingMainVC.h"
#import "DecorateMainVC.h"
#import "ZLCGuidePageView.h"

@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>
{
    NSString *registrationID;

}
@end
static NSInteger seq = 0;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setupViewControllers];
    [self customizeInterface];
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"XGHQHyG1dAOZMEr8Ri0INK7vUtYMmabz"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    [PublicMethod removeObjectForKey: @"IsLogin"];
    [PublicMethod removeObjectForKey: member];
    [PublicMethod removeObjectForKey: agen];

    [PublicMethod removeObjectForKey: shopingCart];
    [PublicMethod removeObjectForKey: @"token"];
    [PublicMethod removeObjectForKey: @"Isdelegate"];
    [PublicMethod removeObjectForKey: @"zhangyue_searchJiLu"];
    [PublicMethod removeObjectForKey: @"wantSearch"];
    
    [self getToken];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    

    /*******************************************向微信注册********************************/
    [WXApi registerApp:@"wxa4ab2adb1a8934e4"];
    
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    
    /*******************************************极光推送**********************************/
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    // Optional
//    // 获取IDFA
//    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    
//    //如不需要使用IDFA，advertisingIdentifier 可为nil
//    [JPUSHService setupWithOption:launchOptions appKey:@"7f98c36e1b9d6f41fe983fe7"
//                          channel:@"App Store"
//                 apsForProduction:YES
//            advertisingIdentifier:nil];
//    
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID1) {
//      NSLog(@"[self tags]=%@",registrationID1);
//      [PublicMethod saveDataString:[NSString stringWithFormat:@"%@",registrationID1 ]withKey:@"registrationID"];
//    }];
//    
//    // apn 内容获取：
//    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
//    NSLog(@"remoteNotification = %@",remoteNotification);
//
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    //是否第一次进入
    if (![PublicMethod getDataStringKey:@"WetherFirstInput"])
    {
        [self YinDaoPage];
    };
    
  
//    [Harpy checkVersion];

    return YES;
}

- (void) YinDaoPage
{
    [PublicMethod saveDataString:@"1" withKey:@"WetherFirstInput"];
    
    //引导页图片数组
//    NSArray *images =  @[[UIImage imageNamed:@"bp_01_1242"],[UIImage imageNamed:@"bp_02_1242"],[UIImage imageNamed:@"bp_03_1242"]];
    //创建引导页视图
//    ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:CGRectMake( 0, 0, CXCWidth, CXCHeight) WithImages:images];
//    [self.window addSubview:pageView];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"JingzhiForBusiness"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
- (void)setupViewControllers {
//    if ([[PublicMethod getDataStringKey:@"WetherFirstInput"]isEqualToString:@"1"]) {//若为1，表示登录了
//        [PublicMethod saveDataString:@"1" withKey:@"WetherFirstInput"];//是否第一次进入
//    
    UIViewController *firstViewController = [[HomePage alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]initWithRootViewController:firstViewController];
        [firstNavigationController setNavigationBarHidden:YES];

    
    UIViewController *secondViewController = [[SearchHouseVC alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]                                             initWithRootViewController:secondViewController];
        [secondNavigationController setNavigationBarHidden:YES];

   
    UIViewController *threeViewController = [[DecorateMainVC alloc] init];
    UINavigationController *threeNavigationController = [[UINavigationController alloc]initWithRootViewController:threeViewController];
        [threeNavigationController setNavigationBarHidden:YES];
    
    
    UIViewController *fourViewController = [[ShoppingMainVC alloc] init];
    UINavigationController *fourNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:fourViewController];
    [threeNavigationController setNavigationBarHidden:YES];
    
    
    UIViewController *fiveViewController = [[SJSPersonalCenterVC alloc] init];
    UINavigationController *fiveNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:fiveViewController];
    [threeNavigationController setNavigationBarHidden:YES];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,threeNavigationController,fourNavigationController,fiveNavigationController]];
    self.viewController = tabBarController;
    [self customizeTabBarForController:tabBarController];
    
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"icon_home", @"home_icon_soufang",@"home_icon_zhuangxiu",@"home_icon_mall", @"home_icon_me"];
    NSArray *tabBarItemTitles = @[@"首页", @"搜房", @"装修",@"商城", @"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_pre.png",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        NSLog(@"%@",[NSString stringWithFormat:@"%@_pre",
                     [tabBarItemImages objectAtIndex:index]]);
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                         NSForegroundColorAttributeName:NavColor,
                                         };
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                           NSForegroundColorAttributeName:TextGrayColor,
                                           };
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else
    {
    
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:self];

    
    }
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (void)getToken
{
    if (![PublicMethod getDataStringKey:@"token"]) {
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
        NSString *url=@"http://heart.qwangluo.cn/index.php/home/Index/makeToken";
        //    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];//当加密的时候用
        NSMutableDictionary*parameter =[NSMutableDictionary dictionary];
        [parameter setDictionary:@{}];
        [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"请求成功JSON:%@", dict);
            NSDictionary*dataDict  =[dict objectForKey:@"data"];
            [PublicMethod setObject:[dataDict objectForKey:@"token"] key:@"token"];
            NSLog(@"token%@",[PublicMethod getObjectForKey:@"token"]);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSLog(@"My token is: %@", deviceToken);
//    [JPUSHService registerDeviceToken:deviceToken];
//}
//// iOS 10 Support  显示本地通知
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    NSLog(@"userInfo = %@",userInfo);
//    
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
////        [self presentVC:userInfo[@"aps"][@"alert"]];
//
////        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
////        [alertView show];
//        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        
//        alertWindow.rootViewController = [[UIViewController alloc] init];
//        
//        alertWindow.windowLevel = UIWindowLevelAlert + 1;
//        
//        [alertWindow makeKeyAndVisible];
//        
//        //初始化弹窗口控制器
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *cancelAction =
//        [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self  presentVC:userInfo[@"aps"][@"alert"]];
//            
//        }];
//        [alertController addAction:cancelAction];
//        
//        //显示弹出框
//        
//        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
//        
//
//
//    }
//    else
//    {
//        NSLog(@"本地通知");
//    }
//    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//}
//
// iOS 10 Support  点击弹出的通知后走的方法
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    // Required
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    NSLog(@"userInfo = %@",userInfo);
//    //表示通过推送点击进入
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
////        [self presentVC:userInfo[@"aps"][@"alert"]];
//
////        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
////        [alertView show];
//        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        
//        alertWindow.rootViewController = [[UIViewController alloc] init];
//        
//        alertWindow.windowLevel = UIWindowLevelAlert + 1;
//        
//        [alertWindow makeKeyAndVisible];
//        
//        //初始化弹窗口控制器
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *cancelAction =
//        [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self  presentVC:userInfo[@"aps"][@"alert"]];
//            
//        }];
//        [alertController addAction:cancelAction];
//        
//        //显示弹出框
//        
//        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
//        
//
//    }
//    else
//    {
//        NSLog(@"本地通知");
//    }
//    completionHandler();  // 系统要求执行这个方法
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    [self presentVC:alertView.message];
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    NSLog(@"尼玛的推送消息呢????===%@",userInfo);
//    // 取得 APNs 标准信息内容，如果没需要可以不取
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
//    [JPUSHService handleRemoteNotification:userInfo];
//    application.applicationIconBadgeNumber = 0;
//    
////    [self presentVC:userInfo[@"aps"][@"alert"]];
////    
////        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
////        [alertView show];
//    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    alertWindow.rootViewController = [[UIViewController alloc] init];
//    
//    alertWindow.windowLevel = UIWindowLevelAlert + 1;
//    
//    [alertWindow makeKeyAndVisible];
//    
//    //初始化弹窗口控制器
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction =
//    [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self  presentVC:userInfo[@"aps"][@"alert"]];
//        
//    }];
//
//    
//    [alertController addAction:cancelAction];
//    
//    //显示弹出框
//    
//    [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
//    
//
//}
//- (void)presentVC:(NSString *)userInfo
//{
//    
//    UIViewController *topmostVC = [self topViewController];
//    JPushViewController *jp =[[JPushViewController alloc]init];
//    jp.detailString =userInfo;
//    
//    [topmostVC presentViewController:jp animated:NO completion:^{
//    }];
//    
//    [topmostVC.navigationController  pushViewController:jp animated:YES];
//}
//- (void)networkDidReceiveMessage:(NSNotification *)notification//接收自定义消息
//{
//    NSDictionary * userInfo = [notification userInfo];
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
//    NSLog(@"content = %@,customizeField1 = %@",content,customizeField1);
//    
//}
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSLog(@"1234567890-=%@",payResoult);
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ZHIFUCHENGGONG" object:nil];
                
                break;
                
            default:
            {
                UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                
                alertWindow.rootViewController = [[UIViewController alloc] init];
                
                alertWindow.windowLevel = UIWindowLevelAlert + 1;
                
                [alertWindow makeKeyAndVisible];
                
                //初始化弹窗口控制器
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction =
                [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                
                [alertController addAction:cancelAction];
                
                //显示弹出框
                
                [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
                
                

            
            
            }
                
                
                
                
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//
//        switch (resp.errCode) {
//            case 0:
//                 
//                payResoult = @"支付结果：成功！";
//                break;
//            case -1:
//                payResoult = @"支付结果：失败！";
//                break;
//            case -2:
//                payResoult = @"用户已经退出支付！";
//                break;
//            default:
//                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                break;
//        }
    }
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        NSLog(@"---VC%@",vc.class);
        
        return vc;
        
    }
    return nil;
}


@end
