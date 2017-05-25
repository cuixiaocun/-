//
//  MyRequest.m
//  AFCache
//
//  Created by tc on 2016/11/10.
//  Copyright © 2016年 tc. All rights reserved.
//
#define IsNilString(__String)   (__String==nil || [__String isEqualToString:@"null"] || [__String isEqualToString:@"<null>"])

#import "MyRequest.h"
#import "AFNetworking.h"
#import "EGOCache.h"
#import "Reachability.h"
@implementation MyRequest


+(void)GET:(NSString *)url CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
//
//    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    EGOCache *cache = [EGOCache globalCache];
//
//    if (![self interStatus]) {
//         //无网络
//        NSString *interNetError = [url stringByAppendingString:@"interNetError"];
//
//        NSData *responseObject = [cache dataForKey:interNetError];
//        
//        if (responseObject.length != 0) {
//            
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            
//            success(responseObject,YES,dict);
//            
//            return;
//        }
//    }
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];
//    
//    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 30.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    
//    if ([cache hasCacheForKey:url]) {
//        
//        NSData *responseObject = [cache dataForKey:url];
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//        success(responseObject,YES,dict);
//        
//        return;
//    }
//    
//    if (!IsNilString(loadString)) {
//        
//        [LoadingView showProgressHUD:loadString];
//
//    }
//    [manager POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (!IsNilString(loadString)) {
//            [LoadingView hideProgressHUD];
//        }
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        BOOL succe = NO;
//        if ([[dict objectForKey:@"code"] isKindOfClass:[NSNumber class]]) {
//            if ([[dict valueForKey:@"code"] isEqualToNumber:@100]) {
//                succe = YES;
//            } else
//                succe = NO;;
//        } else if ([[dict objectForKey:@"code"] isKindOfClass:[NSString class]]) {
//            if ([[dict valueForKey:@"code"] isEqualToString:@"100"]) {
//                succe = YES;
//            } else
//                succe = NO;
//        }
//        
//        NSString *interNetError = [url stringByAppendingString:@"interNetError"];
//        [cache setData:responseObject forKey:interNetError];
//
//        if (CacheTime && succe){
//            
//            if (CacheTime == -1) {
//                [cache setData:responseObject forKey:url];
//            }else{
//                [cache setData:responseObject forKey:url withTimeoutInterval:CacheTime];
//            }
//        }
//        success(responseObject,succe,dict);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (!IsNilString(loadString)) {
//            [LoadingView hideProgressHUD];
//        }
//        [LoadingView showAlertHUD:@"网络没有连接上" duration:2];
//
//        failure(error);
//    }];
//
//
}

+ (void)POST:(NSString *)url withParameters:(NSDictionary *)parmas CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString remark:(NSString *)remark success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    EGOCache *cache = [EGOCache globalCache];
/*******************************无网络的时候***************************/
    if (![self interStatus]) {
        
        //拼接作为找到缓存的标志url+interNetError
        NSString *interNetError = [[url stringByAppendingString:@"interNetError"] stringByAppendingString:remark];
         //从缓存中找到数据
        NSData *responseObject = [cache dataForKey:interNetError];
        NSLog(@"cache:%@",cache);
        NSLog(@"cacheinterNetError:%@",[cache dataForKey:interNetError]);
        //若不为空
        if ((responseObject.length != 0)) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //返回的是缓存的数据
            success(responseObject,YES,dict,NO);
            return;

        }
    }
/**********************************有网的时候***************************/
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
/****通过传来的url检查是否有缓存 如果有就先返回缓存的**/
    if ([cache hasCacheForKey:[url stringByAppendingString:remark]]) {
        NSData *responseObject = [cache dataForKey:[url stringByAppendingString:remark]];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(responseObject,YES,dict,NO);
        
        return;
    }
    //如果loadString不为空
    if (!IsNilString(loadString)) {
        
        [ProgressHUD show:@"正在加载中"];
    }
    [manager POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"message:%@",dict);

        if (dict) {
            if ([[dict  objectForKey:@"result"] boolValue]) {
                
                BOOL succe = [[dict  objectForKey:@"result"] boolValue];
                // 记忆查找时候的标志
                NSString *interNetError = [[url stringByAppendingString:@"interNetError"] stringByAppendingString:remark];
                //保存缓存
                [cache setData:responseObject forKey:interNetError];
                [ProgressHUD dismiss];
                success(responseObject,succe,dict,YES);
                if (CacheTime == -1) {
                    [cache setData:responseObject forKey:[url stringByAppendingString:remark]];
                }else{
                    [cache setData:responseObject forKey:[url stringByAppendingString:remark] withTimeoutInterval:CacheTime];
                    }
     
           }
            
        }
    }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failure(error);
        [ProgressHUD showError:@"网络连接错误"];
    }];

}

//同步判断网络状态，可能在部分iOS系统会卡顿iOS9 iOS10没有问题
+(BOOL)interStatus
{
    BOOL status ;
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus status22 = [reach currentReachabilityStatus];
    
     // 判断网络状态
    if (status22 == ReachableViaWiFi) {
        
        status = YES;
        //无线网
    } else if (status22 == ReachableViaWWAN) {
        status = YES;
        //移动网
    } else {
        status = NO;
        
    }
    
    return status;
}









@end
