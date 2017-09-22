//
//  XYMScanViewController.m
//  healthcoming
//
//  Created by jack xu on 16/11/15.
//  Copyright © 2016年 Franky. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "XYMScanViewController.h"
#import "XYMScanView.h"
#import <AVFoundation/AVFoundation.h>
#import "AntiFakeVC.h"
@interface XYMScanViewController ()<XYMScanViewDelegate>
{
    int line_tag;
    UIView *highlightView;
    NSString *scanMessage;
    BOOL isRequesting;
    NSString *errorMessage;
    NSString *successMessage;
}

@property (nonatomic,weak) XYMScanView *scanV;

@end

@implementation XYMScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(CXCHeight<500)
    {
        XYMScanView *scanV = [[XYMScanView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        scanV.delegate = self;
        [self.view addSubview:scanV];
        _scanV = scanV;
    
    }else
    {
        XYMScanView *scanV = [[XYMScanView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
        scanV.delegate = self;
        [self.view addSubview:scanV];
        _scanV = scanV;
    
    }
    

    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"扫码"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    

    
   }
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)getScanDataString:(NSString*)scanDataString{
    NSLog(@"二维码内容：%@",scanDataString);

    if ([_whichView isEqualToString:@"防伪查询"]) {
        
        [self getResult:scanDataString];
        

//        AntiFakeVC *antifack =[[AntiFakeVC alloc]init];
//        antifack.dic=@{@"image":@"",@"name":@"温碧泉透白莹润护肤霜套装",@"prices":@"400",@"isTure":@"YES",@"isAuthentication":@"YES"};
//        antifack.codeString =scanDataString;
//        [self.navigationController pushViewController:antifack animated:YES];
        return;
        
    }
    [self.delegate getScanString:scanDataString];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getResult:(NSString *)scanDataString
{
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"sn":scanDataString}];
    
    [PublicMethod AFNetworkPOSTurl:@"Home/member/fandsecurity" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
            successMessage =[NSString stringWithFormat:@"%@",[dict objectForKey:@"data"]];
            [self performSelector:@selector(delayMethodSucess) withObject:nil afterDelay:0.5f];

        }else
        {

            [self.navigationController popViewControllerAnimated:YES];
            errorMessage =[NSString stringWithFormat:@"%@",[dict objectForKey:@"msg"]];
            [self performSelector:@selector(delayMethodError) withObject:nil afterDelay:0.5f];

        
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)delayMethodError
{
    [ProgressHUD showError:errorMessage];

}
- (void)delayMethodSucess
{

    [ProgressHUD showSuccess:successMessage];

}
@end
