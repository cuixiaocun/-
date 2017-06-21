//
//  AppDelegate.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/3/21.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "AppDelegate.h"
//第三方tabbar
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"

//会员代理登录是一个界面
#import "LoginPage.h"

/*如下是会员的的*/
#import "HomePage.h"
#import "HYPersonalCenterVC.h"
#import "ShoppingCartVC.h"

/*如下是代理的*/
#import "DeclarationCenterVC.h"
#import "OrderCenterVC.h"
#import "PersonalCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
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
    [PublicMethod removeObjectForKey: @"member"];
    return YES;
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
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
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

    UIViewController *secondViewController = [[ShoppingCartVC alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
        [secondNavigationController setNavigationBarHidden:YES];

    UIViewController *threeViewController = [[HYPersonalCenterVC alloc] init];
    UINavigationController *threeNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:threeViewController];
        [threeNavigationController setNavigationBarHidden:YES];
            
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,threeNavigationController]];
    self.viewController = tabBarController;
    [self customizeTabBarForController:tabBarController];
        
//    }else//若不为1表示没登录
//    {
//        LoginPage *rootViewController = [[LoginPage alloc] init];
//        UINavigationController* _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
//        self.viewController =_navigationController;
//        [_navigationController setNavigationBarHidden:YES];
//
//    }
//
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"huiyuan_icon_home", @"huiyuan_icon_cart",@"proxy_icon_me"];
    
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

@end
