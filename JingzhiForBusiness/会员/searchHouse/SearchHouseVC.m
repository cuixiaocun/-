//
//  SearchHouseVC.m
//  家装
//
//  Created by Admin on 2017/9/7.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "SearchHouseVC.h"
#import "UIImageView+WebCache.h"
#import "SearchOneCell.h"
#import "SearchTwoCell.h"
#import "SearchHouseTableViewController.h"
@interface SearchHouseVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *imagesArray;//滚动图片数组
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    UITableView *tableview;
}
@end

@implementation SearchHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"搜房"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CXCWidth-44, 20, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"home_icon_search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [topImageView addSubview:rightBtn];

    [self mainView];
}
- (void)rightBtnAction
{
    SearchHouseTableViewController  *search =[[SearchHouseTableViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];


}
- (void)returnBtnAction
{

}
- (void)mainView
{

    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CXCWidth, CXCHeight-64-49)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1000*2)];
    [self.view addSubview:bgScrollView];
    //顶部广告图
    cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth, 240*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    //每日优推
    UIView  *bestRecomV =[[UIView alloc]initWithFrame:CGRectMake(0, cycleScrollView2.bottom, CXCWidth, 610*Width)];
    bestRecomV.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:bestRecomV];
    
    UILabel *promLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*Width, 0*Width, 690*Width,78.5*Width )];
    promLabel.text =@"每日优推";
    promLabel.textColor =TextColor;
    promLabel.font =[UIFont systemFontOfSize:14];
    [bestRecomV addSubview:promLabel];
    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(0,promLabel.bottom, CXCWidth, 1.5*Width)];
    xian.backgroundColor =BGColor;
    [bestRecomV addSubview:xian];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*Width, xian.bottom+20*Width, 450*Width,120*Width )];
    titleLabel.text =@"欧洲小镇筹备中，大家快来选购吧，等你有";
    titleLabel.tag =10;
    titleLabel.textColor =TextColor;
    titleLabel.numberOfLines =0;
    titleLabel.font =[UIFont systemFontOfSize:14];
    [bestRecomV addSubview:titleLabel];
    
    EGOImageView *topImgv =[[EGOImageView alloc]initWithFrame:CGRectMake(titleLabel.right+24*Width, xian.bottom+15*Width, 220*Width, 170*Width)];
    topImgv.backgroundColor =[UIColor grayColor];
    topImgv.contentMode =UIViewContentModeScaleToFill;
    [bestRecomV addSubview:topImgv];
    UIImageView *xiantwo =[[UIImageView alloc]initWithFrame:CGRectMake(0,topImgv.bottom+13.5*Width, CXCWidth, 1.5*Width)];
    xiantwo.backgroundColor =BGColor;
    [bestRecomV addSubview:xiantwo];
    UILabel *prelabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,  xiantwo.top-65*Width,80*Width, 40*Width)];
    prelabel.text =@"导购";
    prelabel.textAlignment  =NSTextAlignmentCenter;
    [prelabel.layer setBorderWidth:1];
    [prelabel.layer setCornerRadius:2];
    prelabel.layer.borderColor =orangeColor.CGColor;
    [prelabel.layer setMasksToBounds:YES];
    prelabel.font =[UIFont systemFontOfSize:12];
    prelabel.textColor =orangeColor;
    [bestRecomV  addSubview:prelabel ];
    UILabel *timelabel =[[UILabel alloc]initWithFrame:CGRectMake(prelabel.right+10*Width, prelabel.top,480*Width, 40*Width)];
    timelabel.text =@"2017-09-10";
    timelabel.tag =11;
    timelabel.font =[UIFont systemFontOfSize:12];
    timelabel.textColor =TextGrayColor;
    [bestRecomV  addSubview:timelabel ];
    //下半部分
    UILabel *dtLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*Width, xiantwo.bottom+20*Width, 650*Width,50*Width )];
    dtLabel.text =@"亲，这些楼盘有新的动态，赶紧来看看吧";
    dtLabel.tag =10;
    dtLabel.numberOfLines =0;
    dtLabel.textColor =TextColor;
    dtLabel.font =[UIFont systemFontOfSize:14];
    [bestRecomV addSubview:dtLabel];
    for (int i=0; i<3; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(25*(i+1)*Width+216*Width*(i%3),dtLabel.bottom+10*Width,216.7*Width,170*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        btn.backgroundColor =[UIColor redColor];
        [bestRecomV addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width,0*Width,216.7*Width,170*Width)];
        topImgV.image =[UIImage imageNamed:@"timg-8.jpeg"];
        topImgV.tag =20+i;
        [btn addSubview:topImgV];
        
        UIView *tmView =[[UIView alloc]initWithFrame:CGRectMake(0*Width,0*Width,216.7*Width,170*Width)];
        tmView.alpha =0.3;
        tmView.backgroundColor =[UIColor blackColor];
        [btn addSubview:tmView];
        //shang边文字
        UILabel *topLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.top+15*Width,216.7*Width,45*Width)];
        topLabel.textAlignment=NSTextAlignmentCenter;
        topLabel.font =[UIFont systemFontOfSize:13];
        topLabel.text =@"恒大绿洲";
        topLabel.textColor =[UIColor whiteColor];
        [btn addSubview:topLabel];
        //中间文字
        UILabel *midLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topLabel.bottom,216.7*Width,45*Width)];
        midLabel.textAlignment=NSTextAlignmentCenter;
        midLabel.font =[UIFont systemFontOfSize:12];
        midLabel.text =@"高新经济开发区";
        midLabel.textColor =[UIColor whiteColor];
        [btn addSubview:midLabel];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,midLabel.bottom,216.7*Width,45*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.text =@"孤灯广场";
        botLabel.textColor =[UIColor whiteColor];
        botLabel.font =[UIFont systemFontOfSize:12];
        botLabel.textColor =[UIColor whiteColor];
        [btn addSubview:botLabel];
    }
    UILabel *allprelabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,dtLabel.bottom+ 190*Width,140*Width, 40*Width)];
    allprelabel.text =@"楼盘推荐";
    allprelabel.textAlignment  =NSTextAlignmentCenter;
    [allprelabel.layer setBorderWidth:1];
    [allprelabel.layer setCornerRadius:2];
    allprelabel.layer.borderColor =orangeColor.CGColor;
    [allprelabel.layer setMasksToBounds:YES];
    allprelabel.font =[UIFont systemFontOfSize:12];
    allprelabel.textColor =orangeColor;
    [bestRecomV  addSubview:allprelabel ];
    UILabel *timeAlllabel =[[UILabel alloc]initWithFrame:CGRectMake(allprelabel.right+10*Width, allprelabel.top,480*Width, 40*Width)];
    timeAlllabel.text =@"2017-09-10";
    timeAlllabel.tag =11;
    timeAlllabel.font =[UIFont systemFontOfSize:12];
    timeAlllabel.textColor =TextGrayColor;
    [bestRecomV  addSubview:timeAlllabel ];
    
    [self getBanner];//banner
    [self getBestRecommend];
    tableview  =[[UITableView alloc]initWithFrame:CGRectMake(0,bestRecomV.bottom, CXCWidth, 1000*1.5)style:UITableViewStyleGrouped];
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableview .showsVerticalScrollIndicator = NO;
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview setFrame:CGRectMake(0,bestRecomV.bottom, CXCWidth, CXCHeight-20)];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    tableview.scrollEnabled = NO;
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview .showsVerticalScrollIndicator = NO;
    [bgScrollView addSubview:tableview];
    tableview.frame =CGRectMake(0,bestRecomV.bottom, CXCWidth, 1000*1.5);

    
    


}

- (void)myBtnAciton:(UIButton *)btn
{


}
- (void)getBestRecommend
{


}
-(void)getBanner
{
    cycleScrollView2.imageURLStringsGroup = @[@"home_banner01",@"home_banner01",@"home_banner01"];//放上图片
    
    //    [PublicMethod AFNetworkPOSTurl:@"Home/Index/show" paraments:@{}  addView:self.view success:^(id responseDic) {
    //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
    //        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
    //            imgArr=[[NSArray alloc]init];
    //            imgArr =  [dict objectForKey:@"data"];
    //            imagesArray =[[NSMutableArray alloc]init];
    //
    //            for (int i=0; i<imgArr.count; i++) {
    //                [imagesArray insertObject:[imgArr[i] objectForKey:@"img"] atIndex:i];
    //            }
    //            cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
    //        }
    //
    //    } fail:^(NSError *error) {
    //        
    //    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 100*Width;

    }else
    {
        return 100*Width;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 80*Width;

    }else
    {
        return 80*Width;

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 4;
        
    }else
        
        return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 270*Width;
    }else
        return 210*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"CellWithNumber";
        
        SearchOneCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SearchOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        return cell;
        
        
    }else
    {
        static NSString *CellIdentifier = @"Cell";
        
        SearchTwoCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SearchTwoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        return cell;
        
        
    }
    //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
    //    [cell setDic:dict];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 100*Width)];
    UILabel *xianV =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth,80*Width)];
    xianV.backgroundColor =BGColor;
    [bgview addSubview:xianV];
    //下边文字
    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,20*Width,CXCWidth,80*Width)];
    botLabel.font =[UIFont systemFontOfSize:16];
    botLabel.textColor =BlackColor;
    botLabel.backgroundColor =[UIColor whiteColor];
    if (section ==0) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    房源推荐"];
    }else if(section ==1) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    购房贴士"];
        
    }
    [bgview  addSubview:botLabel];
    return bgview;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
    if(section ==0)
    {
        [addressBtn addTarget:self action:@selector(moreTJ) forControlEvents:UIControlEventTouchUpInside];

    }else
    {
        [addressBtn addTarget:self action:@selector(moreTS) forControlEvents:UIControlEventTouchUpInside];

    }
    
    UILabel *addLabel = [[UILabel alloc] init];
    [addLabel setText:@"查看更多 >"];
    addLabel.tag =30;
    addLabel.textColor =BlackColor;
    addLabel.textAlignment =NSTextAlignmentCenter;
    [addLabel setFont:[UIFont systemFontOfSize:14]];
    [addLabel setFrame:CGRectMake(0*Width,1.5*Width,CXCWidth , 78.5*Width)];
    addLabel.backgroundColor =[UIColor whiteColor];
    [addressBtn addSubview:addLabel];
    [addressBtn setBackgroundColor:[UIColor whiteColor]];
    UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 0*Width, 690*Width, 1.5*Width)];
    addressBtn.backgroundColor =BGColor;
    [addressBtn addSubview:addShowImgV];
    return addressBtn;
}
- (void)moreTJ
{
    NSLog(@"111");
}
- (void)moreTS
{
    NSLog(@"222");

}
- (void)examinePass:(UIButton*)btn
{
    
    
}
- (void)chooseAddress
{


}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<5; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    
    
    
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
