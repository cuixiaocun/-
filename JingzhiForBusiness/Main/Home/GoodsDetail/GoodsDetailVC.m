//
//  GoodsDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/17.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "HYConfirmOrderVC.h"
#import <WebKit/WebKit.h>
#import "LoginPage.h"
#import "AKGallery.h"
#import "ShopStoreDetailVC.h"

#import "ShopStoreMainVC.h"
@interface GoodsDetailVC ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,WKNavigationDelegate, WKUIDelegate,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UITextFieldDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    //替代导航栏的imageview
    UIImageView *topImageView;
    UIImageView* topImageViewNomal;
    NSMutableArray *inforArr;
    UIWebView * webView;
    UIView* blackBgView;//输入框背景透明黑
    UIView *alterView;//弹出输入框
    //顶部广告图
    SDCycleScrollView* cycleScrollView2;
    NSArray*ImgsArr;//下边图片
    UITableView *goodsTableview;//中间商品
    NSDictionary *dataDict ;




}
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation GoodsDetailVC
- (void)viewWillAppear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];



}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    inforArr =[[NSMutableArray alloc]init];
    NSArray* inforArray = [PublicMethod getObjectForKey:shopingCart];
    [inforArr addObjectsFromArray: inforArray];
    
    [self mainView];
    [self getDetialInformation];

}

- (void)shateButton
{

    [[self rdv_tabBarController] setSelectedIndex:1];

    [self.navigationController popViewControllerAnimated:NO];
    

}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView.delegate =self;
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =[UIColor whiteColor];
    topImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    topImageView.alpha =0.0;
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, Frame_rectStatus, 550*Width, Frame_rectNav)];
    [navTitle setText:@"商品详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [topImageView addSubview:navTitle];
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //右
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"details_btn_white"] forState:UIControlStateNormal];
    [topImageView addSubview:shareBtn];
    
    
    topImageViewNomal= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageViewNomal.userInteractionEnabled = YES;
    topImageViewNomal.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topImageViewNomal];
    topImageViewNomal.alpha =1.0;

    
    //添加返回按钮
    UIButton *  returnBtnNomal = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtnNomal.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtnNomal setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
    [returnBtnNomal addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageViewNomal addSubview:returnBtnNomal];
//    //右
    UIButton *shareBtnNomal = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-Frame_rectNav, Frame_rectStatus, Frame_rectNav, Frame_rectNav)];
    shareBtnNomal.backgroundColor = [UIColor clearColor];
    [shareBtnNomal addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtnNomal setImage:[UIImage imageNamed:@"details_btn_cart"] forState:UIControlStateNormal];
    [topImageViewNomal addSubview:shareBtnNomal];
    
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth,560*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.backgroundColor =TextGrayGray3Color;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
//    cycleScrollView2.localizationImageNamesGroup =@[@"vip_banner_01",@"vip_banner_01"];
    //    cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
    // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 20*Width+cycleScrollView2.bottom, 670*Width, 80*Width)];
    nameLabel.text =@"商品名称";
    nameLabel.textColor =BlackColor;
    nameLabel.tag=300;
    nameLabel.font =[UIFont systemFontOfSize:14];
    [bgScrollView addSubview:nameLabel];
    
    UILabel *pricesLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, nameLabel.bottom+15*Width, 200*Width, 60*Width)];
    pricesLabel.text =@"¥ 300.00";
    pricesLabel.font =[UIFont  systemFontOfSize:16];
    pricesLabel.textColor =NavColor;
    pricesLabel.tag =302;
    [bgScrollView addSubview:pricesLabel];
    
    UILabel *shanchu =[[UILabel alloc]initWithFrame:CGRectMake(pricesLabel.right+24*Width, nameLabel.bottom+15*Width, 200*Width, 60*Width)];
    shanchu.tag=301;
    NSString *oldPrice = @"¥12345";
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [shanchu setAttributedText:attri];
    shanchu.font =[UIFont  systemFontOfSize:12];
    shanchu.textColor =TextGrayGrayColor;
    [bgScrollView addSubview:shanchu];

    //线
    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(0, pricesLabel.bottom+10*Width, CXCWidth, 20*Width)];
    xian.backgroundColor =BGColor;
    [bgScrollView addSubview:xian];
    //数量
    UIView *numberBgview =[[UIView alloc]initWithFrame:CGRectMake(0, xian.bottom, CXCWidth, 82*Width*3)];
    numberBgview.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:numberBgview];
    NSArray *leftArr =@[@"库存",@"分类",@"数量"];
    NSArray *rightArr =@[@"99",@"基础建材",@"1"];
    for (int i=0; i<3; i++) {
        //显示
        UILabel*  proLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, i*Width*82,200*Width , 82*Width)];
        proLabel.text = [NSString stringWithFormat:@"%@",leftArr[i]];
        proLabel.font = [UIFont boldSystemFontOfSize:15];
        proLabel.textColor = [UIColor grayColor];
        [numberBgview addSubview:proLabel];
        //文字购买数量
        UILabel* rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(300*Width, i*Width*82,390*Width , 82*Width)];
               rightLabel.tag =20+i;
        rightLabel.textAlignment =NSTextAlignmentRight;
        rightLabel.font = [UIFont systemFontOfSize:16];
        rightLabel.textColor = BlackColor;
        [numberBgview addSubview:rightLabel];
        if (i==2) {
            //数量选择
            UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(300*Width, i*82*Width,450*Width,82*Width)];
            [numberBgview addSubview:chooseBtn];
            chooseBtn.tag =10;
            [chooseBtn addTarget:self action:@selector(numberChoose:) forControlEvents:UIControlEventTouchUpInside];
            rightLabel.text = @"1";
            //箭头
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(700*Width,23*Width+82*Width*2,21*Width , 31*Width)];
            [numberBgview addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"home_btn_nextpage"]];
            
        }else
        {
            rightLabel.text =[NSString stringWithFormat:@"%@",rightArr[i]] ;
            rightLabel.frame =CGRectMake(300*Width, i*Width*82,410*Width , 82*Width);
            if (i==0) {
                rightLabel.textColor =orangeColor;
            }
        }

       
        //线
        UIImageView *xian2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 82*Width*(i+1)-1.5*Width, CXCWidth, 1.5*Width)];
        xian2.backgroundColor =BGColor;
        [numberBgview addSubview:xian2];
    }
    //线
    UIImageView *xian2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, numberBgview.bottom, CXCWidth, 20*Width)];
    xian2.backgroundColor =BGColor;
    [bgScrollView addSubview:xian2];

//    //商品详情
//    UILabel *promlabel=[[UILabel alloc]initWithFrame:CGRectMake(24*Width, xian2.bottom+20*Width, 520*Width, 60*Width)];
//    promlabel.backgroundColor =[UIColor whiteColor];
//    promlabel.text =@"商品详情";
//    promlabel.font =[UIFont systemFontOfSize:16];
//    promlabel.textColor =BlackColor;
//    [bgScrollView addSubview:promlabel];
    
    
    webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0,xian2.bottom+20*Width,CXCWidth,0 )];
    webView.scalesPageToFit = NO;
    webView.delegate=self;
    webView.scrollView.scrollEnabled =NO;
    
    [bgScrollView addSubview:webView];
    goodsTableview  =[[UITableView alloc]init];
    [goodsTableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    goodsTableview .showsVerticalScrollIndicator = NO;
    goodsTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    goodsTableview.backgroundColor =[UIColor  whiteColor];
    [goodsTableview setDelegate:self];
    [goodsTableview setDataSource:self];
    [bgScrollView addSubview:goodsTableview];
    bgScrollView.userInteractionEnabled = YES;//控制是否可以响应用户点击事件（touch）
    bgScrollView.scrollEnabled = YES;//控制是否可以滚动
    
    //店铺
    UIButton * shoppingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shoppingBtn setFrame:CGRectMake(0*Width,CXCHeight-100*Width , 250*Width, 100*Width)];
    [shoppingBtn setBackgroundColor:BGColor];
    //上边图片
    UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(102.5*Width,8*Width,45*Width,45*Width)];
    topImgV.image=[UIImage imageNamed:@"mall_icon_store"];
    [shoppingBtn addSubview:topImgV];
    //下边文字
    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom+7*Width,250*Width,30*Width)];
    botLabel.textAlignment=NSTextAlignmentCenter;
    botLabel.font =[UIFont systemFontOfSize:13];
    botLabel.textColor =BlackColor;
    botLabel.text =[NSString stringWithFormat:@"%@",@"店铺"];
    [shoppingBtn addSubview:botLabel];

//    [shoppingBtn setTitle:@"店铺" forState:UIControlStateNormal];
//    [shoppingBtn setImage:[UIImage imageNamed:@"mall_icon_store"] forState:UIControlStateNormal];
//    [shoppingBtn setTitleEdgeInsets:UIEdgeInsetsMake(shoppingBtn.imageView.frame.size.height ,-shoppingBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [shoppingBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -shoppingBtn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    [shoppingBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
    shoppingBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    shoppingBtn.tag =990;
    [shoppingBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shoppingBtn];

    //立即购买
    UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartBtn setFrame:CGRectMake(250*Width,CXCHeight-100*Width , 250*Width, 100*Width)];
    [shopCartBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:112/255.0 blue:48/255.0 alpha:1]];
    shopCartBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    shopCartBtn.tag =991;

    [shopCartBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [shopCartBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [shopCartBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCartBtn];
    
    //预约购买
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(500*Width,CXCHeight-100*Width , 250*Width, 100*Width)];
    [buyBtn setBackgroundColor:[UIColor colorWithRed:230/255.00 green:47/255.00 blue:44/255.00 alpha:1]];
    buyBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    buyBtn.tag =992;
    buyBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [buyBtn setTitle:@"预约购买" forState:UIControlStateNormal];
    [buyBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [buyBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
   
}
- (void)numberChoose:(UIButton *)btn
{
    [self alterView:[@"1" integerValue]];
}
-(void)shopCartBtnAction
{
    UILabel *numbLable =[self.view viewWithTag:22];
    
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"此商品在购物车中+%@",numbLable.text] ToView:self.view];
    NSString*num =[NSString stringWithFormat:@"%@",numbLable.text];
    NSLog(@"%@",[PublicMethod getObjectForKey:shopingCart ]);

    
    //若无商品则重新加入 若有商品分两种1.商品重复只加数量2.商品不重复加新的商品
    if (inforArr.count==0) {

        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"name"]]forKey:@"goodsTitle"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"price"]] forKey:@"goodsPrice"];
        [infoDict setValue:[NSString stringWithFormat:@"NO"] forKey:@"selectState"];
        [infoDict setValue:[NSString stringWithFormat:@"%.2f",([[[dataDict objectForKey:@"product"] objectForKey:@"price"] floatValue] *[num floatValue])] forKey:@"goodsTotalPrice"];
        [infoDict setValue:[NSNumber numberWithInt:[num intValue]] forKey:@"goodsNum"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"id"]] forKey:@"goodID"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"boxnum"]] forKey:@"boxnum"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"img"]] forKey:@"img"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"deductible"]] forKey:@"deductible"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",@"1"] forKey:@"ishidden"];//@“1”是隐藏所有的x按钮




        //将数据模型放入数组中
        [inforArr addObject:infoDict];
        [PublicMethod setObject:inforArr key:shopingCart];
//        NSLog(@"%@",[PublicMethod getObjectForKey:shopingCart ]);
    }else
    {
        NSString *index =@"无";
        for (int i=0; i<inforArr.count; i++) {
            NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithDictionary:inforArr[i]];
            if ([[mDict objectForKey:@"goodID"]isEqualToString:[[dataDict objectForKey:@"product"] objectForKey:@"id"]]) {
                index =[NSString stringWithFormat:@"%d",i];
                
            }
        }
        //如果商品重复
        if (![index isEqualToString:@"无"]) {
            //替换数量
            NSInteger inta =[index integerValue];
            NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithDictionary:inforArr[inta] ];
            NSInteger number=[[mDict objectForKey:@"goodsNum"] integerValue]+[numbLable.text integerValue];
            [mDict setValue:[NSString stringWithFormat:@"%ld",number] forKey:@"goodsNum"];
            [inforArr replaceObjectAtIndex:inta withObject:mDict];
            
        }else
        {
           //如果商品不重复添加
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"name"]]forKey:@"goodsTitle"];
            [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"price"]] forKey:@"goodsPrice"];
            [infoDict setValue:[NSString stringWithFormat:@"NO"] forKey:@"selectState"];
            [infoDict setValue:[NSString stringWithFormat:@"%.2f",([@"10.0" floatValue] *[num floatValue])] forKey:@"goodsTotalPrice"];
            [infoDict setValue:[NSNumber numberWithInt:[num intValue]] forKey:@"goodsNum"];
            [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"id"]] forKey:@"goodID"];
            [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"boxnum"]] forKey:@"boxnum"];
            [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"img"]] forKey:@"img"];
            [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"deductible"]] forKey:@"deductible"];
            [infoDict setValue:[NSString stringWithFormat:@"%@",@"1"] forKey:@"ishidden"];//@“1”是隐藏所有的x按钮


            [inforArr addObject:infoDict ];
        }
        

      

        [PublicMethod setObject:inforArr key:shopingCart];
        
        //封装数据模型
        //将数据模型放入数组中
    }
    NSLog(@"===%@",[PublicMethod getObjectForKey:shopingCart ]);


}
- (void)buyBtnAction:(UIButton *)btn
{
    if (btn.tag==990) {
        ShopStoreMainVC *shop =[[ShopStoreMainVC alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
        
    }else if (btn.tag==991)
    {
        
        if (![PublicMethod getDataStringKey:@"IsLogin"])
        {//若没登录请登录
            LoginPage *loginPage =[[LoginPage     alloc]init];
            loginPage.status =@"present";
            [self.navigationController pushViewController:loginPage animated:YES];
            return;
        }
        UILabel *numbLable =[self.view viewWithTag:22];
        
        NSString*num =[NSString stringWithFormat:@"%@",numbLable.text];
        NSMutableArray* goodsMutableArr =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"name"]]forKey:@"goodsTitle"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"price"]] forKey:@"goodsPrice"];
        [infoDict setValue:[NSString stringWithFormat:@"NO"] forKey:@"selectState"];
        [infoDict setValue:[NSString stringWithFormat:@"%.2f",([[[dataDict objectForKey:@"product"] objectForKey:@"price"] floatValue] *[num floatValue])] forKey:@"goodsTotalPrice"];
        [infoDict setValue:[NSNumber numberWithInt:[num intValue]] forKey:@"goodsNum"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"id"]] forKey:@"goodID"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"boxnum"]] forKey:@"boxnum"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"img"]] forKey:@"img"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"deductible"]] forKey:@"deductible"];
        [infoDict setValue:[NSString stringWithFormat:@"%@",@"1"] forKey:@"ishidden"];//@“1”是隐藏所有的x按钮
        
        
        [goodsMutableArr addObject:infoDict];
        
        
        HYConfirmOrderVC *confirmOrderVC =[[HYConfirmOrderVC alloc]init];
        confirmOrderVC.googsArr =goodsMutableArr;
        [self.navigationController pushViewController:confirmOrderVC animated:YES];

    }
    
    
    
    
    
    
    
}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==bgScrollView)
    {
//        CGFloat sectionHeaderHeight;
        
//        sectionHeaderHeight =560*Width;
        
        //去掉UItableview的section的headerview黏性
//        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
//        {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        }
//        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
//        {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//        NSLog(@"scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
        
        //相对于图片的偏移量
        CGFloat reOffset = scrollView.contentOffset.y ;
        //    (kOriginalImageHeight - 64)这个数值决定了导航条在图片上滑时开始出现  alpha 从 0 ~ 0.99 变化
        //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
        CGFloat alpha = reOffset /(560.0*Width-Frame_NavAndStatus) ;
        NSLog(@"reOffset=%f",reOffset);
        // 设置导航条的背景图片 其透明度随  alpha 值 而改变
        topImageView.alpha =alpha;
        topImageViewNomal.alpha =1-alpha;
    
    }else
    {
    
        bgScrollView.userInteractionEnabled = YES;//控制是否可以响应用户点击事件（touch）
        bgScrollView.scrollEnabled = YES;//控制是否可以滚动
    }
   
    
    //  = [self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
//alterView
- (void)alterView:(NSInteger)index
{
    //若存在就不走里边的直接hidden=no;
    if (!blackBgView) {
        blackBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
        [blackBgView setAlpha:0.5];
        [blackBgView  setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:blackBgView];
        
        
        alterView=[[UIView alloc]initWithFrame:CGRectMake(75*Width, 200*Width, 620*Width, 360*Width)];
        [self.view addSubview:alterView];
        [alterView setBackgroundColor:[UIColor whiteColor]];
        [alterView.layer setCornerRadius:20*Width];
//        [alterView.layer setBorderWidth:1.0*Width];
//        alterView.layer.borderColor =BGColor.CGColor;
        [alterView.layer setMasksToBounds:YES];
        
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0*Width, 620*Width, 120*Width)];
        label.textAlignment =NSTextAlignmentCenter;
        [label setText:@"修改拿货数量"];
        [alterView addSubview:label];
        
        //购买商品的数量
        UITextField*  _numCountLab = [[UITextField alloc]initWithFrame:CGRectMake(210*Width,label.bottom,190*Width , 90*Width)];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        _numCountLab.tag=120;
        _numCountLab.delegate =self;
        _numCountLab.keyboardType =UIKeyboardTypeNumberPad;
        _numCountLab.layer.borderColor =BGColor.CGColor;
        [_numCountLab.layer setBorderWidth:1.0*Width];
        [alterView addSubview:_numCountLab];
        
        //减按钮
        UIButton* _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(120*Width, label.bottom, 90*Width, 90*Width);
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        [_deleteBtn setImage:[UIImage imageNamed:@"register_btn_reduce_modify_black"] forState:UIControlStateNormal];
        [_deleteBtn.layer setBorderWidth:1.0*Width];
        _deleteBtn.layer.borderColor =BGColor.CGColor;
        [alterView addSubview:_deleteBtn];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(15*Width, 15*Width,15*Width, 15*Width);
        
        
        //加按钮
        UIButton* _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(400*Width, label.bottom, 90*Width, 90*Width);
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(15*Width, 15*Width,15*Width, 15*Width);
        
        [_addBtn.layer setBorderWidth:1.0*Width];
        _addBtn.layer.borderColor =BGColor.CGColor;
        [_addBtn setImage:[UIImage imageNamed:@"register_btn_add_modify_black"] forState:UIControlStateNormal];
        
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        [alterView addSubview:_addBtn];
        //线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [alterView addSubview:xian];
        xian.frame =CGRectMake(0*Width,260*Width, 620*Width, 1*Width);
        //取消按钮
        UIButton*cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, xian.bottom, 310*Width, 100*Width)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [alterView addSubview:cancelBtn];
        //确认按钮
        UIButton*tureBtn =[[UIButton alloc]initWithFrame:CGRectMake(310*Width, xian.bottom, 310*Width, 100*Width)];
        [tureBtn setBackgroundColor:NavColor];
        [tureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tureBtn addTarget:self action:@selector(tureBtn) forControlEvents:UIControlEventTouchUpInside];
        [alterView addSubview:tureBtn];
    }
    
    UITextField *textF =[self.view viewWithTag:120];
    [textF becomeFirstResponder];//收起键盘
    UILabel *numberLabel =[self.view viewWithTag:22];
    textF.text =[NSString stringWithFormat:@"%@",numberLabel.text];//取得数量
    
    blackBgView.hidden=NO;
    alterView.hidden =NO;
    
}
//-
- (void)deleteBtnAction
{
    UITextField *textF =[self.view viewWithTag:120];
    if(textF.text.length==0||[textF.text isEqualToString:@"0"])
    {
        return;
        
    }else
    {
        textF.text =[NSString stringWithFormat:@"%ld",([textF.text integerValue]-1)];
        
        
    }
    
    
}
//+
- (void)addBtnAction
{
    UITextField *textF =[self.view viewWithTag:120];
    textF.text =[NSString stringWithFormat:@"%ld",([textF.text integerValue]+1)];
    
    
}
//确认
- (void)tureBtn
{
    
    blackBgView.hidden=YES;
    alterView.hidden =YES;
    
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    UILabel *numberLabel =[self.view viewWithTag:22];
    
    if ([textF.text integerValue]==0) {
        
        [MBProgressHUD showWarn:@"数量有误" ToView:self.view];
        numberLabel.text =@"1";
        
    }else
    {
        numberLabel.text =[NSString stringWithFormat:@"%ld",[textF.text integerValue]];
    }
}
//取消
-(void)cancelBtn
{
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    
    blackBgView.hidden=YES;
    
    alterView.hidden =YES;
    
}
- (void)getDetialInformation
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"product_id":_goodsId}];
    NSLog(@"%@",dic1);
     [PublicMethod AFNetworkPOSTurl:@"mobileapi/?product-detail.html" paraments:@{} addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
         dataDict  =[dict objectForKey:@"data"];
        
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            UILabel*nameLabel =[self.view viewWithTag:300];
            UILabel*jfLabel =[self.view viewWithTag:301];
            UILabel*pricesLabel =[self.view viewWithTag:302];
//            UILabel*nameLabel =[self.view viewWithTag:303];
            nameLabel.text =[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"name"]];
            jfLabel.text =[NSString stringWithFormat:@"最高可抵扣积分：%@",[[dataDict objectForKey:@"product"] objectForKey:@"deductible"]];
            pricesLabel.text =[NSString stringWithFormat:@"¥%@",[[dataDict objectForKey:@"product"] objectForKey:@"price"]];
            cycleScrollView2.imageURLStringsGroup =@[ [NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"img"]]];
            NSString *htmlString =[NSString stringWithFormat:@"%@",[[dataDict objectForKey:@"product"] objectForKey:@"html"]];
            NSString *newBacnStr = [self htmlEntityDecode:htmlString];
            
            [webView loadHTMLString:newBacnStr baseURL:nil];
            ImgsArr = [[dataDict objectForKey:@"product" ] objectForKey:@"imgs"];
            [goodsTableview reloadData];
        
            
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    
    //方法2
    CGRect frame = webView.frame;
    frame.size.width = CXCWidth;
    frame.size.height = 1;
    webView.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    frame.size.height = webView.scrollView.contentSize.height;
    NSLog(@"frame = %@", [NSValue valueWithCGRect:frame]);
    webView.frame = frame;
    [goodsTableview setFrame:CGRectMake(0,webView.bottom,CXCWidth,ImgsArr.count*400*Width)];
    [goodsTableview reloadData];
    NSLog(@"%f_----%f",goodsTableview.bottom+100*Width,CXCHeight);
    
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, goodsTableview.bottom+100*Width)];



}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableArray* arr= @[].mutableCopy;
//
//    for (int  i = 0; i<ImgsArr.count; i++) {
//        
//        AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:nil img:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ImgsArr[i]]]]]];
//        
//        [arr addObject:item];
//    }
//    
//    AKGallery* gallery = AKGallery.new;
//    gallery.items=arr;
//    gallery.custUI=AKGalleryCustUI.new;
//    gallery.selectIndex=indexPath.row;
//    gallery.completion=^{
//        NSLog(@"completion gallery");
//        
//    };
//    //show gallery
//    [self presentAKGallery:gallery animated:YES completion:nil];
//    //

    
}
-(void)presentAKGallery:(AKGallery *)gallery animated:(BOOL)flag completion:(void (^)(void))completion{
    
    //todo:defaults
    
    [gallery.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    
    
    [self presentViewController:gallery animated:flag completion:completion];
    
}


//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ImgsArr.count;
}
//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =  @"indentify";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    EGOImageView*imgView ;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        imgView =[[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 400*Width)];
        imgView.contentMode =UIViewContentModeScaleToFill;
        [cell addSubview:imgView];
    }
    
    imgView.tag =1001;
    imgView.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@",[ImgsArr objectAtIndex:indexPath.row]]];
    
    
    return cell;
}
//返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400*Width;
}
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 4)
    {
        [ProgressHUD showError:@"数量过大"];
        [textField  resignFirstResponder];
        return NO;

    }else
        return YES;
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
