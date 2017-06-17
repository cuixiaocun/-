//
//  HomePage.m
//  Demo_simple
//
//  Created by  on 15/7/8.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "HomePage.h"
#import "Harpy.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "ShoppingCartVC.h"
#import "LoginPage.h"
#import "PersonalCenter.h"
#import "ViewController.h"
#import "ComMallView.h"
#import "SearchPage.h"
#import <MLLabel/MLLabel.h>
#import <MLLabel/MLLinkLabel.h>
#import <MLLabel/NSString+MLExpression.h>
#import <MLLabel/NSAttributedString+MLExpression.h>
#import "NoticeVC.h"
#import "GoodsDetailVC.h"

@interface HomePage ()<SDCycleScrollViewDelegate,OnClickCMallDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *imagesArray;//滚动图片数组
    NSArray *picArr;
    NSString *sharePhone;//传到广告页面的图片
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    UIView * bottomView;
    UIView *topview ;
}
@property (nonatomic,strong) ComMallView *comMallView;//按钮视图

@end

@implementation HomePage

//
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];

}
//首页
- (void)viewDidLoad {
    [super viewDidLoad];
    [Harpy checkVersion];
    [self.view setBackgroundColor:BGColor];
  
            //图片
            UIImageView *imageview =[[UIImageView alloc] init];
            [imageview setBackgroundColor:NavColor];
            [imageview setFrame:CGRectMake(0, 0, CXCWidth, 64)];
            [self.view addSubview:imageview];
            [self.view sendSubviewToBack:imageview];
            //标题
            UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 20, CXCWidth, 44)];
            [navTitle setText:@"心体荟控价管理系统"];
            [navTitle setTextAlignment:NSTextAlignmentCenter];
            [navTitle setBackgroundColor:[UIColor clearColor]];
            [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
            [navTitle setNumberOfLines:0];
            [navTitle setTextColor:[UIColor whiteColor]];
            [self.view addSubview:navTitle];
    [self makeThisView];
    [PublicMethod getAppKey];
    
   }

////首页页面布局
-(void)makeThisView
{
    topview =[[UIView alloc]initWithFrame:CGRectMake(0, 64,CXCWidth , 58*Width)];
    topview.backgroundColor = [UIColor colorWithRed:253/255.0 green:239/255.0 blue:212/255.0 alpha:1];
    [self.view addSubview:topview];
    UILabel *prelabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 0, CXCWidth*0.8, 58*Width)];
    prelabel.text =@"公告：心体荟商城上线大促销即将开始";
    prelabel.font =[UIFont systemFontOfSize:14];
    prelabel.textColor =[UIColor colorWithRed:249/255.0 green:98/255.0 blue:48/255.0 alpha:1];
    [topview  addSubview:prelabel ];
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(700*Width, 19*Width, 20*Width, 20*Width)];
    
    [btn setImage:[UIImage imageNamed:@"vip_btn_close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hiddenTheTopView) forControlEvents:UIControlEventTouchUpInside];
    
    [topview addSubview:btn];
    
    
    
    
    
    
    
    
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, topview.bottom, CXCWidth, CXCHeight-64-49)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 2800*Width)];
    //顶部广告图
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth, 310*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    cycleScrollView2.localizationImageNamesGroup =@[@"vip_banner_01",@"vip_banner_01"];
//    cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
// 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    
    UIView *btnView =[[UIView alloc]initWithFrame:CGRectMake(0,cycleScrollView2.bottom ,CXCWidth ,230*Width )];
    [btnView setBackgroundColor:[UIColor whiteColor ]];
    [bgScrollView addSubview:btnView];
      NSArray *topArr =@[@"vip_icon_nearby",@"vip_icon_search",@"vip_icon_notice",@"vip_icon_qa",@"proxy_me_icon_mima",@"proxy_me_icon_shengji",@"proxy_me_icon_tixian",@"proxy_me_icon_liuzhuan",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
     NSArray*bottomArr =@[@"附近代理",@"代理查询",@"公告",@"常见问题",@"密码修改",@"申请升级",@"提现",@"流转记录",@"会员订单",@"银行卡",@"返佣",@"代理审核",@"我的授权",@"",@"",] ;
    [btnView setBackgroundColor:[UIColor whiteColor]];
    for (int i=0; i<4; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(187*Width*(i%4),187.5*Width*(i/4),186*Width,230*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor whiteColor];
        [btnView addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(40.5*Width,25*Width,105*Width,105*Width)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
        topImgV.tag =1100+i;
        [btn addSubview:topImgV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom+10*Width,187*Width,90*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:14];
        botLabel.textColor =BlackColor;
        botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
        [btn addSubview:botLabel];
    }
    
    //商品
    UIView *goodsXian =[[UIView alloc]initWithFrame:CGRectMake(0, btnView.bottom, CXCWidth, 68*Width)];
    goodsXian.backgroundColor =BGColor;
    
    [bgScrollView addSubview:goodsXian];
    
    UIImageView *rightXian =[[UIImageView alloc]initWithFrame:CGRectMake(25*Width, 43*Width, 270*Width, 2*Width)];
    [rightXian setBackgroundColor:TextGrayGray3Color];
    [goodsXian addSubview:rightXian];
    
    UIImageView *zanImgv =[[UIImageView alloc]initWithFrame:CGRectMake(rightXian.right, 21.5*Width, 43*Width, 43*Width)];
    [zanImgv setBackgroundColor:BGColor];
    zanImgv.image =[UIImage imageNamed:@"vip_icon_good"];
    [goodsXian addSubview:zanImgv];

    UILabel*label =[[UILabel alloc]initWithFrame:CGRectMake(zanImgv.right+20*Width, 0, 200*Width, 88*Width)];
    label.text =@"商品";
    label.textColor =[UIColor colorWithRed:240/255.0 green:89/255.0 blue:42/255.0 alpha:1];
    label.font =[UIFont systemFontOfSize:17];
    [goodsXian addSubview:label];
    
    UIImageView *leftXian =[[UIImageView alloc]initWithFrame:CGRectMake(460*Width, 43*Width, 270*Width, 2*Width)];
    [leftXian setBackgroundColor:TextGrayGray3Color];
    [goodsXian addSubview:leftXian];
    
    
    
    
    if (self.comMallView == nil)
    {
        self.comMallView = [[ComMallView alloc] initWithFrame:CGRectMake(0, goodsXian.bottom, CXCWidth, 880*Width)];
        self.comMallView.CMallDelegate = self;
        self.comMallView.backgroundColor = BGColor;
        [bgScrollView addSubview:self.comMallView];
    }
    
    
    
    
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,  _comMallView.bottom, CXCWidth, 1000*Width)];
    bottomView.backgroundColor =[UIColor redColor];
    [bgScrollView addSubview:bottomView];
    
    //商品
    UIView *companyXian =[[UIView alloc]initWithFrame:CGRectMake(0,0, CXCWidth, 88*Width)];
    companyXian.backgroundColor =BGColor;
    
    [bottomView addSubview:companyXian];
    
    UIImageView *crightXian =[[UIImageView alloc]initWithFrame:CGRectMake(25*Width, 43*Width, 230*Width, 2*Width)];
    [crightXian setBackgroundColor:TextGrayGray3Color];
    [companyXian addSubview:crightXian];
    
    UIImageView *biaoImgv =[[UIImageView alloc]initWithFrame:CGRectMake(crightXian.right+10*Width, 21.5*Width, 45*Width, 45*Width)];
    [biaoImgv setBackgroundColor:BGColor];
    biaoImgv.image =[UIImage imageNamed:@"vip_icon_company_profile"];
    [companyXian addSubview:biaoImgv];
    
    UILabel*compLabel =[[UILabel alloc]initWithFrame:CGRectMake(biaoImgv.right+14*Width, 0, 200*Width, 88*Width)];
    compLabel.text =@"公司简介";
    compLabel.textColor =[UIColor colorWithRed:33/255.0 green:144/255.0 blue:244/255.0 alpha:1]   ;
    compLabel.font =[UIFont systemFontOfSize:17];
    [companyXian addSubview:compLabel];
    
    UIImageView *cleftXian =[[UIImageView alloc]initWithFrame:CGRectMake(490*Width, 43*Width, 230*Width, 2*Width)];
    [cleftXian setBackgroundColor:TextGrayGray3Color];
    [companyXian addSubview:cleftXian];
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, companyXian.bottom, CXCWidth, 500)];
    bgView.backgroundColor =[UIColor whiteColor];
    [bottomView addSubview:bgView];
    
    //头像
    EGOImageView *touImageV = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
    [touImageV setFrame:CGRectMake(24*Width, 32*Width, 72*Width, 72*Width)];
    //    [touImageV setImageURL:[NSURL URLWithString:headString]];
    [touImageV setImage:[UIImage imageNamed:@"proxy_icon_header"]];
    
    touImageV.tag =3330;
    touImageV.userInteractionEnabled =YES;
    [touImageV.layer setMasksToBounds:YES];
    [bgView addSubview:touImageV];
    
    //代理
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(touImageV.right+20*Width,touImageV.top-2*Width, 600*Width, 40*Width)];
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.tag =3331;
    levelLabel.text =@"广州市乔美华妆品有限公司";
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.font = [UIFont boldSystemFontOfSize:16];
    levelLabel.textColor = BlackColor;
    [bgView   addSubview:levelLabel];
    
    //电话
    UILabel *telphoneL = [[UILabel alloc]initWithFrame:CGRectMake(touImageV.right+24*Width,levelLabel.bottom, 600*Width, 40*Width)];
    telphoneL.textColor = [UIColor whiteColor];
    telphoneL.tag =3332;
    telphoneL.text=@"广州市奎文区家离得近撒委屈热无广州市乔美华妆品有限公司";
    telphoneL.textAlignment = NSTextAlignmentLeft;
    telphoneL.font = [UIFont boldSystemFontOfSize:13];
    telphoneL.textColor = TextGrayColor;
    [bgView addSubview:telphoneL];
    NSArray *imgArr =@[@"1.jpg",@"2.jpg",@"3.jpg"];
    for (int i=0; i<3; i++) {
        UIImageView *imgvOfcompany =[[UIImageView alloc]init];
        if (i==0)
        {
            imgvOfcompany.frame =CGRectMake(24*Width,touImageV.bottom+28*Width,  440*Width, 400*Width);
 
        }else if (i==1)
        {
            imgvOfcompany.frame =CGRectMake(476*Width,touImageV.bottom+28*Width,  250*Width, 194*Width);

        
        }else
        {
            imgvOfcompany.frame =CGRectMake(476*Width,touImageV.bottom+28*Width+206*Width,  250*Width, 194*Width);

        }
        [imgvOfcompany setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArr[i]]]];
        
        [bgView addSubview:imgvOfcompany];
        
    }
    
    MLLabel* textLabel=[[MLLabel    alloc]initWithFrame:CGRectMake(24*Width, touImageV.bottom+510*Width, 700*Width, 50*Width)];
    
    textLabel.textColor = TextGrayColor;
    textLabel.font = [UIFont systemFontOfSize:14.0f];
   textLabel.numberOfLines = 0;
//    textLabel.adjustsFontSizeToFitWidth = YES;
    textLabel.textInsets = UIEdgeInsetsZero;
    textLabel.lineSpacing = 10.0f;
    NSString *str =@"山东桥通天下网络科技公司是一家集设计、研发、营销为一体的互联网软件开发综合服务商我们的团队年轻、朝气、充满活力！我们的梦想是：致力于成为国内一流的软件开发服务商注重创新坚持高效，做中国最具有创新精神的软件开发商";
    textLabel.text =str ;
    [textLabel setDoBeforeDrawingTextBlock:nil];
    [textLabel setTextColor:TextGrayColor];
    [bottomView addSubview:textLabel];
//    textLabel.backgroundColor =[UIColor yellowColor];
    NSAttributedString*string2 =[[NSAttributedString alloc] initWithString:str];
   textLabel.height= [self heightForExpressionText:string2 width:700*Width];
    

}
- (void)hiddenTheTopView
{
    topview.hidden=YES;
    bgScrollView.top =64;

}
- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag ==300) {
        
    }else if (btn.tag==301)
    {
        SearchPage  *search =[[SearchPage alloc]init];
        [self.navigationController pushViewController:search animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    
    }else if (btn.tag==302)
    {
        NoticeVC  *notice =[[NoticeVC alloc]init];
        [self.navigationController pushViewController:notice animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        

        
    }else if (btn.tag==303)
    {
        
    }

}

//- (void)getInforBanner
//{
//    
//        [ProgressHUD show:@"加载中"];
//
//    NSString *url=[NSString stringWithFormat:@"/ad/getByCid"];
//    NSDictionary *parameter = @{
//                                @"cid":[NSString stringWithFormat:@"%@",[PublicMethod getObjectForKey:@"cid"]],
//                                @"location":@"1",
//                                @"deviceType":@"2"
//                                };
//    
//    [PublicMethod AFNetworkPOSTurl:url paraments:parameter success:^(id responseDic) {
//
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"请求成功JSON:%@", dict);
//        
//        if (dict) {
//            if ([[dict  objectForKey:@"result"] boolValue]) {
//                
//                picArr =[dict objectForKey:@"ads"];
//                imagesArray =[[NSMutableArray alloc]init];
//                NSMutableArray * titleArr=[[NSMutableArray alloc]init];
//                for (NSDictionary *dic in picArr) {
//                    [titleArr  addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]]];
//                    [imagesArray addObject:[NSString stringWithFormat:@"%@/%@",IMAGEURL,[dic objectForKey:@"icon"]]];
//                }
//                    cycleScrollView2.imageURLStringsGroup = imagesArray;
//                    cycleScrollView2.titlesGroup = titleArr;
//                
//                [ProgressHUD dismiss];
//                    
//                
//            }else{
//                
//                [ProgressHUD showError:@""];
//            }
//        }
//        
//        
//    } fail:^(NSError *error) {
//        NSLog(@"网络连接失败");
//
//        [ProgressHUD showError:@"网络连接失败"];
//        
//    }];
//    
//}
//
//-(void)gnBtnClick:(UIButton *)sender
//{
//
////    LinliquanVC *linliVC =[[LinliquanVC alloc]init];
////    [self.leveyTabBarController hidesTabBar:YES animated:YES];
////
////    [self.navigationController pushViewController:linliVC animated:YES];
//    
//    
//}
//    
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"---点击了第%ld张图片", (long)index);
//    
//}
- (void)getInfor
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"uname":@"123",@"a":@"e24354",@"password":@"213",@"deviceType":@"2",@"w":@"2345"}];
    NSDictionary *dic = [PublicMethod ASCIIwithDic:dic1];
    NSLog(@"%@",dic);
    [PublicMethod AFNetworkPOSTurl:@"接口名" paraments:dic success:^(id responseDic) {
        
    } fail:^(NSError *error) {
    
    }];

}
static MLLinkLabel * kProtypeLabel() {
    static MLLinkLabel *_protypeLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _protypeLabel = [MLLinkLabel new];
        _protypeLabel.font = [UIFont systemFontOfSize:16.0f];
        
        _protypeLabel.numberOfLines = 0;
        _protypeLabel.textInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _protypeLabel.lineHeightMultiple = 1.1f;
    });
    return _protypeLabel;
}


- (CGFloat)heightForExpressionText:(NSAttributedString*)expressionText width:(CGFloat)width
{
    //nib里左右边距是10
    width-=10.0f*2;
    
    MLLinkLabel *label = kProtypeLabel();
    label.attributedText = expressionText;
    return [label preferredSizeWithMaxWidth:width].height + 5.0f*2; //上下间距
}
-(void)btnClickPush:(NSString *)str
{
    GoodsDetailVC*goode =[[GoodsDetailVC alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    [self.navigationController  pushViewController:goode animated:YES];
    

}
@end
