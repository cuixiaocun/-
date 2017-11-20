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
#import "HouseDetailMainVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "EGOImageButton.h"
@interface SearchHouseVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *imagesArray;//滚动图片数组
    SDCycleScrollView *cycleScrollView2;//这个是轮播
    TPKeyboardAvoidingTableView *tableview;
    UIScrollView *bgScrollView;//最底下的背景
    NSArray *imgArr;//banner
    NSArray *inforArr;//下边推荐
    NSArray *meiriOne;
    NSArray *meiriThree;

}
@end

@implementation SearchHouseVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme) name:ThemeNotificationInformatica object:nil];
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, Frame_rectStatus , 550*Width, Frame_rectNav)];
    [navTitle setText:@"搜房"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
//    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CXCWidth-Frame_rectNav, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [rightBtn setImage:[UIImage imageNamed:@"sf_icon_search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [topImageView addSubview:rightBtn];
    inforArr =[[NSArray alloc]init];
    [self mainView];
}
//更换城市重新请求
-(void)changeTheme{
    
    NSLog(@"搜房换城市了啊");
    
    
}

- (void)rightBtnAction
{
    SearchHouseTableViewController  *search =[[SearchHouseTableViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus)];
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
    titleLabel.tag =3001;
    [bestRecomV addSubview:titleLabel];
    
     EGOImageButton*topImgv =[[EGOImageButton alloc]initWithFrame:CGRectMake(titleLabel.right+24*Width, xian.bottom+15*Width, 220*Width, 170*Width)];
    topImgv.backgroundColor =[UIColor grayColor];
    topImgv.contentMode =UIViewContentModeScaleToFill;
    [bestRecomV addSubview:topImgv];
    [topImgv  addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    topImgv.tag =3002;
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
    timelabel.tag =3003;
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
        UIView *btn =[[UIView alloc]initWithFrame:CGRectMake(25*(i+1)*Width+216*Width*(i%3),dtLabel.bottom+10*Width,216.7*Width,170*Width)];
        btn.backgroundColor =[UIColor redColor];
        [bestRecomV addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width,0*Width,216.7*Width,170*Width)];
        topImgV.image =[UIImage imageNamed:@"timg-8.jpeg"];
        topImgV.tag =20+i;
        topImgv.userInteractionEnabled =YES;
        [btn addSubview:topImgV];
//
        UIImageView  *tmView =[[UIImageView alloc]initWithFrame:CGRectMake(0*Width,0*Width,216.7*Width,170*Width)];
        tmView.alpha =0.3;
        tmView.userInteractionEnabled =YES;
        tmView.backgroundColor =[UIColor blackColor];
        [btn addSubview:tmView];
      //  shang边文字
        UILabel *topLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.top+15*Width,216.7*Width,45*Width)];
        topLabel.textAlignment=NSTextAlignmentCenter;
        topLabel.font =[UIFont systemFontOfSize:13];
        topLabel.text =@"恒大绿洲";
        topLabel.tag =120+i;
        topLabel.userInteractionEnabled =YES;
        topLabel.textColor =[UIColor whiteColor];
        [btn addSubview:topLabel];
        //中间文字
        UILabel *midLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topLabel.bottom,216.7*Width,45*Width)];
        midLabel.textAlignment=NSTextAlignmentCenter;
        midLabel.font =[UIFont systemFontOfSize:12];
        midLabel.text =@"高新经济开发区";
        midLabel.tag =220+i;
        midLabel.userInteractionEnabled =YES;

        midLabel.textColor =[UIColor whiteColor];
        [btn addSubview:midLabel];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,midLabel.bottom,216.7*Width,45*Width)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.text =@"孤灯广场";
        botLabel.tag =320+i;
        botLabel.userInteractionEnabled =YES;
        botLabel.textColor =[UIColor whiteColor];
        botLabel.font =[UIFont systemFontOfSize:12];
        botLabel.textColor =[UIColor whiteColor];
        [btn addSubview:botLabel];
        
        UIButton *selfBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0*Width,216.7*Width,170*Width)];
        [btn addSubview:selfBtn];
        [selfBtn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        selfBtn.tag =i+300;
        
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
    
    
    imgArr =[[NSMutableArray alloc]init];
    [self getBestRecommend];
    tableview  =[[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0,bestRecomV.bottom, CXCWidth, 1000*1.5)style:UITableViewStyleGrouped];
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
    [self getInfoSF];
    


}

- (void)myBtnAciton:(UIButton *)btn
{
    HouseDetailMainVC *house =[[HouseDetailMainVC alloc]init];
    house.searchId =[meiriThree[btn.tag-300] objectForKey:@"home_id"];
    house.xinxiTypeId =[NSString stringWithFormat:@"%@",[meiriThree[btn.tag-300] objectForKey:@"xinxitype"]];
    [self.navigationController  pushViewController:house animated:YES];
    
}
- (void)getBestRecommend
{


}
-(void)getBanner
{
    imagesArray =[[NSMutableArray alloc]init];
    for (int i=0; i<imgArr.count; i++) {
        [imagesArray insertObject:[NSString stringWithFormat:@"%@%@",IMAGEURL,[imgArr[i] objectForKey:@"thumb"]] atIndex:i];
    }
    cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 100*Width;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 80*Width;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(section==0)
//    {
//        return 4;
//
//    }else
    
        return inforArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section==0)
//    {
        return 270*Width;
//    }else
//        return 210*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"CellWithNumber";
        SearchOneCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SearchOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        cell.dic = inforArr[indexPath.row];
        return cell;
//    }else
//    {
//        static NSString *CellIdentifier = @"Cell";
//        SearchTwoCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[SearchTwoCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                            reuseIdentifier:CellIdentifier ];
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//        }
//        return cell;
//
//
//    }
    //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
    //    [cell setDic:dict];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    HouseDetailMainVC *house =[[HouseDetailMainVC alloc]init];
    house.searchId =[inforArr[indexPath.row] objectForKey:@"home_id"];
    house.xinxiTypeId =[NSString stringWithFormat:@"%@",[inforArr[indexPath.row] objectForKey:@"xinxitype"]];

    [self.navigationController  pushViewController:house animated:YES];

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
    SearchHouseTableViewController  *search =[[SearchHouseTableViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
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
- (void)getInfoSF
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?soufang-sindex.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController  success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            
            imgArr  =[[dict objectForKey:@"data"] objectForKey:@"top_advs"];
            [self getBanner];
            UILabel *titleLabel =[self.view viewWithTag:3001];
            meiriOne =[[dict objectForKey:@"data"] objectForKey:@"meiriyoutui1"];
            titleLabel.text =[NSString stringWithFormat:@"%@", IsNilString([meiriOne[0]  objectForKey:@"name"])?@"":[meiriOne[0]  objectForKey:@"name"] ];
            EGOImageView *topImgv =[self.view viewWithTag:3002];
            [topImgv setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[meiriOne[0] objectForKey:@"thumb"]]]];
            UILabel *timeLabel =[self.view viewWithTag:3003];
            timeLabel.text =[PublicMethod timeWithTimeIntervalString:[meiriOne[0]  objectForKey:@"dateline"]];

            meiriThree =[[dict objectForKey:@"data"] objectForKey:@"meiriyoutui3"];
            
            for (int i=0; i<3; i++) {
                UIImageView *img =[self.view viewWithTag:20+i];
                UILabel *topLabel =[self.view viewWithTag:220+i];
                UILabel *midLabel =[self.view viewWithTag:220+i];
                UILabel *botLabel =[self.view viewWithTag:320+i];
                UILabel *timeAlllabel =[self.view viewWithTag:11];

                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[meiriThree[i] objectForKey:@"thumb"]]]];
                topLabel.text =[NSString stringWithFormat:@"%@", IsNilString([meiriThree[i]  objectForKey:@"name"])?@"":[meiriThree[i]  objectForKey:@"name"] ];
                midLabel.text =[NSString stringWithFormat:@"%@", IsNilString([meiriThree[i]  objectForKey:@"area_name"])?@"":[meiriThree[i]  objectForKey:@"area_name"] ];
                botLabel.text =[NSString stringWithFormat:@"%@", IsNilString([meiriThree[i]  objectForKey:@"addr"])?@"":[meiriThree[i]  objectForKey:@"addr"] ];
                timeAlllabel.text =[PublicMethod timeWithTimeIntervalString:[meiriThree[i]  objectForKey:@"dateline"]];

            }
            inforArr =[[dict objectForKey:@"data"] objectForKey:@"items"];
            tableview.height =inforArr.count*270*Width+180*Width;
            [bgScrollView setContentSize:CGSizeMake(CXCWidth, tableview.bottom)];
            
            [tableview  reloadData];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)choose
{
    
    HouseDetailMainVC *house =[[HouseDetailMainVC alloc]init];
    house.searchId =[meiriOne[0] objectForKey:@"home_id"];
    house.xinxiTypeId =[NSString stringWithFormat:@"%@",[meiriOne[0] objectForKey:@"xinxitype"]];

    [self.navigationController  pushViewController:house animated:YES];

    
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
