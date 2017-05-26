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
//md5加密
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



//获取手机唯一标识
+(NSString *)getAppKey{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"%@",identifierForVendor);
    
    return identifierForVendor;
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

//urlString+SERVERURL（post）请求网络
+(void)AFNetworkPOSTurl:(NSString *)urlString paraments:(NSDictionary *)dic success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVERURL,urlString];
    NSDictionary *parameter =dic;
//    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];

    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
            
            
            
            
        }
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"网络连接失败");
              [ProgressHUD showError:@"网络连接失败，请检查网络"];

    }];
    
}

//把字典放进来，通过key的ASCII重新排列，根据重新排列的key数组拼接Key=value@key=value&...最后加上秘钥拼接成为新的字符串，将此字符串加到刚进来时候的字典里，返回
+ (NSMutableDictionary*)ASCIIwithDic:(NSMutableDictionary *)dict
{
    NSMutableString *contentString  =[NSMutableString string];

    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for (int i=0; i<sortedArray.count; i++) {
        if (i==sortedArray.count-1) {
            [contentString appendFormat:@"%@=%@&key=%@", sortedArray[i], [dict valueForKey:sortedArray[i]],KEYOFMD5];
        }else
        {
            [contentString appendFormat:@"%@=%@&", sortedArray[i], [dict valueForKey:sortedArray[i]]];
            
        }
        
    }
    [dict setValue:[PublicMethod md5:contentString] forKey:@"sign"];
    NSLog(@"%@",dict);
    
    
    //
    //
    //    //拼接字符串
    //    for (NSString *categoryId in sortedArray) {
    //        [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
    //
    //        if (![categoryId isEqualToString:@"sign"] && ![categoryId isEqualToString:@"timestamp"]){
    //            if([categoryId isEqualToString:@"biz_content"]){
    //                NSError *error = nil;
    //                NSDictionary* bizDict = [dict objectForKey:@"biz_content"];
    //                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bizDict options:NSJSONWritingPrettyPrinted error: &error];
    //                NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
    //                NSString* jsonString1 = [[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding];
    //                NSString *jsonString2 = [jsonString1 stringByReplacingOccurrencesOfString:@" : " withString:@":"];
    //                [contentString appendFormat:@"biz_content=%@&",jsonString2];
    //            }else{
    //                [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
    //            }
    //
    //
    //        }
    //    }
    //    //添加key字段
    //    [contentString appendFormat:@"timestamp=%@", [dict objectForKey:@"timestamp"]];
    //    NSString *strUrl1 = [contentString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    //    //    NSString *strUrl2 = [strUrl1 stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    //    NSString *strUrl3 = [strUrl1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return dict;
    
}

//存数组
+ (void) saveArrData:(NSArray *)array withKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    [saveDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:array] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//取数组
+ (NSArray *) getArrData:(NSString *)key
{
    NSUserDefaults *getDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [getDefaults objectForKey:key];
    NSArray *retrievedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return retrievedArray;
}
//存字典数据
+ (void) saveData:(NSDictionary *)dict withKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    [saveDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:dict] forKey:key];
    [saveDefaults synchronize];
}
//取字典
+ (NSDictionary *) getDataKey:(NSString *)key
{
    NSUserDefaults *getDefaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:[getDefaults objectForKey:_captureView.videoPathKey]];
    NSData *data = [getDefaults objectForKey:key];
    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return retrievedDictionary;
}
//存字符串
+ (void) saveDataString:(NSString *)string withKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    [saveDefaults setObject:string forKey:key];
}
//取字符串
+ (NSString *) getDataStringKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    return [saveDefaults objectForKey:key];
}
//删除数据
+(void)removeObjectForKey:(NSString *)key{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

@end
