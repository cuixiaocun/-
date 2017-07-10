//
//  PublicMethod.m
//  CarShow
//
//  Created by wang rain on 12-4-24.
//

#import "PublicMethod.h"
#import "SGInfoAlert.h"
#import "HomePage.h"

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
+(BOOL)isMobileNumber:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
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
+(void)AFNetworkPOSTurl:(NSString *)urlString paraments:(NSDictionary *)dic addView:(UIView *)view  success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail
{
    [ProgressHUD show:@"请等待"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url=[NSString stringWithFormat:@"%@/%@",SERVERURL,urlString];
    //    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];//当加密的时候用
    NSMutableDictionary*parameter =[NSMutableDictionary dictionary];
    [parameter setDictionary:dic];
    [parameter setObject:[NSString stringWithFormat:@"%@",[PublicMethod getObjectForKey:@"token"]] forKey:@"token"];
//    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];//证书的时候
    NSLog(@"%@",parameter);

    [manager POST:url parameters:parameter  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            success(responseObject);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@请求成功JSON:%@", urlString,dict);
            NSLog(@"请求成功JSON:%@", [self logDic:dict]);
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                [ProgressHUD dismiss];
         
                
            }else
            {
                [ProgressHUD dismiss];
                [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[dict objectForKey:@"msg"]] ToView:view];

            
            }
            
            
        }
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"网络连接失败");
              [ProgressHUD showError:@"网络连接失败，请检查网络"];

    }];
    
}
+(void)AFNetworkGETurl:(NSString *)urlString paraments:(NSDictionary *)dic addView:(UIView *)view  success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];
    NSString *url=[NSString stringWithFormat:@"%@/%@",SERVERURL,urlString];
    //    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];//当加密的时候用
//    NSDictionary *parameter =dic;
    //    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];//证书的时候
    NSMutableDictionary*parameter =[NSMutableDictionary dictionary];
    [parameter setDictionary:dic];
    [parameter setObject:[NSString stringWithFormat:@"%@",[PublicMethod getObjectForKey:@"token"]] forKey:@"token"];
    [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"请求成功JSON:%@", [self logDic:dict]);
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                
                
                
                
            }else
            {
                [ProgressHUD dismiss];
                [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[dict objectForKey:@"msg"]] ToView:view];
                
                
            }
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络连接失败");
        [ProgressHUD showError:@"网络连接失败，请检查网络"];
        
    }];
}
+ (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =[[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =[tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =[[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =[NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
//把字典放进来，通过key的ASCII重新排列，根据重新排列的key数组拼接Key=value@key=value&...最后加上秘钥拼接成为新的字符串，将此字符串加到刚进来时候的字典里，返回
+ (NSMutableDictionary*)ASCIIwithDic:(NSMutableDictionary *)dict
{
    return dict;
    
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

//取数组
+ (NSMutableArray *) getMutableArrayData:(NSString *)key
{
    NSUserDefaults *getDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [getDefaults objectForKey:key];
    NSMutableArray *retrievedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
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
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18)
        return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *////将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex= [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
+(NSString*)stringNilString:(NSString *)string
{
    
    NSString* selfString =[NSString stringWithFormat:@"%@", IsNilString(string)?@"":string];
    return selfString;
    
}
@end
