//
//  PublicMethod.m
//  CarShow
//
//  Created by wang rain on 12-4-24.
//

#import "PublicMethod.h"
#import "SGInfoAlert.h"
#import "HomePage.h"

static NSDictionary *dict;

@implementation PublicMethod

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}



+(void)setObject:(id)object key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

}


+(id)getObjectForKey:(NSString *)key
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        return NULL;
    }
}


+(void)removeObjectForKey:(NSString *)key{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

//获取手机唯一标识
+(NSString *)getAppKey{
    //手机唯一标识
    NSString *appkey =[self getObjectForKey:@"appKey"];
    return appkey;
}




//弹出提示框
+(void)setAlertInfo:(NSString *)info andSuperview:(UIView *)view{
    [SGInfoAlert showInfo:info
                  bgColor:[[UIColor darkGrayColor] CGColor]
                   inView:view
                 vertical:0.19];
}
#define certificate @"ca"

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSLog(@"%@",certData);
    NSLog(@"%@",cerPath);

    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    NSArray *arr =@[certData];
    
    securityPolicy.pinnedCertificates = [NSSet setWithArray:arr];
    
    return securityPolicy;
}

//urlString+SERVERURL
+(void)AFNetworkPOSTurl:(NSString *)urlString paraments:(NSDictionary *)dic success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVERURL,urlString];
    NSDictionary *parameter =dic;
    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];

    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"网络连接失败");
              
    }];
    
}

@end
