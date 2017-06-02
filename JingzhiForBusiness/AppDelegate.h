//
//  AppDelegate.h
//  JingzhiForBusiness
//
//  Created by Admin on 2017/3/21.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;


}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIViewController *viewController;

- (void)saveContext;


@end

