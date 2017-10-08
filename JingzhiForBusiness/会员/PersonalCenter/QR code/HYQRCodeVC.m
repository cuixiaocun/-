//
//  HYQRCodeVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HYQRCodeVC.h"
#import "QRCodeGenerator.h"
#import "LMJScrollTextView.h"

@interface HYQRCodeVC ()
{
    //底部scrollview
    UIScrollView *bgScrollView;
    UIImageView*mainImgView;
    LMJScrollTextView * _scrollTextView2;
    NSString *codeString;
    
}
@end

@implementation HYQRCodeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"推广二维码"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    [self   getERweima];
    
    
    [self mainView];
}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator =
    NO;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1350*Width)];

    
    UIImageView *bgImgView =[[UIImageView   alloc]initWithFrame:CGRectMake( 20*Width,80*Width, 710*Width,860*Width)];
    [bgImgView setUserInteractionEnabled:YES];
    bgImgView.image =[UIImage imageNamed:@"qrcode_icon_slogan"];
    [bgScrollView addSubview:bgImgView];
    
    
    mainImgView =[[UIImageView   alloc]initWithFrame:CGRectMake(230*Width, 270*Width, 250*Width,250*Width)];
    [mainImgView setUserInteractionEnabled:YES];
    [mainImgView setBackgroundColor:[UIColor whiteColor]];
    [mainImgView.layer setBorderWidth:5.0*Width];
    mainImgView.tag =1245;
    [mainImgView.layer setMasksToBounds:YES];
     mainImgView.layer.borderColor =NavColor.CGColor;
    
    
  
    [bgImgView addSubview:mainImgView];
    
//    UIButton* saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [saveBtn setFrame:CGRectMake(220*Width,625*Width , 270*Width, 88*Width)];
//    [saveBtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:91/255.0 blue:94/255.0 alpha:1]];
//    [saveBtn.layer setCornerRadius:4];
//    [saveBtn.layer setMasksToBounds:YES];
//    
//    [saveBtn setTitle:@"点击复制推广链接" forState:UIControlStateNormal];
//    [saveBtn.titleLabel setTextColor:[UIColor whiteColor]];
//    [saveBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
//    [saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [bgImgView addSubview:saveBtn];
    
    UIButton* saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(0*Width,625*Width , 750*Width, 50*Width)];
//    [saveBtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:91/255.0 blue:94/255.0 alpha:1]];
    [saveBtn.layer setCornerRadius:4];
    [saveBtn.layer setMasksToBounds:YES];
    
    [saveBtn setTitle:@"点击复制推广链接" forState:UIControlStateNormal];
    [saveBtn setTitleColor:NavColor forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [saveBtn addTarget:self action:@selector(fuzhi:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:saveBtn];
    
//
//    UIButton *linkBtn =[[UIButton alloc]initWithFrame:CGRectMake(200*Width, 1110*Width, 350*Width, 60*Width)];
////    linkBtn=[UIButton buttonWithType:UIButtonTypeSystem];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"推广链接"];
//    [linkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//
//    NSRange strRange = {0,[str length]};
//    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor   ] range:strRange];
//
//    [linkBtn setAttributedTitle:str forState:UIControlStateNormal];
//    [bgScrollView addSubview:linkBtn];
//
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = @"https://www.baidu.com";
//   
//

}
- (void)saveBtnAction
{
    UIImageView *qrImgV =[self.view viewWithTag:1245];
    UIImageWriteToSavedPhotosAlbum(qrImgV.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"成功保存到相册";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
    [MBProgressHUD showSuccess:@"成功保存到相册" ToView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginAdmin
{

}
- (void)getERweima
{
    
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setDictionary:@{
                              }];
        NSString *url ;
    if ([[PublicMethod getDataStringKey:@"IsLogin"] isEqualToString:@"HY"]) {
        url =@"Home/Member/code";
    }else if([[PublicMethod getDataStringKey:@"IsLogin"] isEqualToString:@"DL"])
    {
        url=@"Home/AgentOnlineorder/getAgenTuiGuangUrl";
    }
    

    
    
    
    
        [PublicMethod AFNetworkPOSTurl:url paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                if ([[PublicMethod getDataStringKey:@"IsLogin"] isEqualToString:@"HY"]) {
                    
                    mainImgView.image=[QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"code"]] imageSize:245];
                    codeString =[NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"code"]];
                    
                    //往返滚动
                    _scrollTextView2 = [[LMJScrollTextView alloc] initWithFrame:CGRectMake(100*Width, 700*Width,550*Width,82*Width) textScrollModel:LMJTextScrollWandering direction:LMJTextScrollMoveLeft];
                    //                _scrollTextView2.backgroundColor = [UIColor redColor];
                    [bgScrollView addSubview:_scrollTextView2];
                    [self addLabelWithFrame:CGRectMake(0*Width, 0*Width,550*Width,82*Width) text:codeString];
                    [_scrollTextView2 startScrollWithText:codeString textColor:NavColor font:[UIFont systemFontOfSize:14]];
                    
                    UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(100*Width, 700*Width,580*Width,82*Width)];
                    chooseBtn.tag =139;
                    [chooseBtn addTarget:self action:@selector(fuzhi:) forControlEvents:UIControlEventTouchUpInside];
                    [bgScrollView addSubview:chooseBtn];
                    
                }else if([[PublicMethod getDataStringKey:@"IsLogin"] isEqualToString:@"DL"])
                {
                    NSLog(@"%@",dict);
                    codeString =[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"url"]]];

                    mainImgView.image=[QRCodeGenerator qrImageForString:codeString imageSize:245];
                    
                    //往返滚动
                    _scrollTextView2 = [[LMJScrollTextView alloc] initWithFrame:CGRectMake(100*Width, 700*Width,550*Width,82*Width) textScrollModel:LMJTextScrollWandering direction:LMJTextScrollMoveLeft];
                    //                _scrollTextView2.backgroundColor = [UIColor redColor];
                    [bgScrollView addSubview:_scrollTextView2];
                    [self addLabelWithFrame:CGRectMake(0*Width, 0*Width,550*Width,82*Width) text:codeString];
                    [_scrollTextView2 startScrollWithText:codeString textColor:NavColor font:[UIFont systemFontOfSize:14]];
                    
                    UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(100*Width, 700*Width,580*Width,82*Width)];
                    chooseBtn.tag =139;
                    [chooseBtn addTarget:self action:@selector(fuzhi:) forControlEvents:UIControlEventTouchUpInside];
                    [bgScrollView addSubview:chooseBtn];
                    
                }
                

                
                
                              }
        } fail:^(NSError *error) {
            
        }];

}
-(void)addLabelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text      = text;
    label.textColor = NavColor;
//    label.backgroundColor =[UIColor greenColor];
    label.font      = [UIFont boldSystemFontOfSize:15];
    [_scrollTextView2 addSubview:label];
}
- (void)fuzhi:(UIButton *)btn
{
    [MBProgressHUD showSuccess:@"复制成功" ToView:self.view];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = codeString;
}
-(void)changeSpeed
{
    [_scrollTextView2 setMoveSpeed:0.005];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
