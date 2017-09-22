//
//  DiaryDetailVC.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DiaryDetailVC.h"
#import "DiaryDetailTableViewCell.h"
#import "MJRefresh.h"

@interface DiaryDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *bgScrollView;//最底下的背景
    //替代导航栏的imageview
    UIImageView *topImageView;
    UIImageView* topImageViewNomal;
    UIView *tabbarView;
    NSArray *photoOfArr;
    UIImageView *touImageView;
}


@end

@implementation DiaryDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    photoOfArr =[[NSArray alloc]init];
    
    [self mainView];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, 676*Width)];
    [bgScrollView setUserInteractionEnabled:NO];
    bgScrollView.delegate =self;
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    bgScrollView.backgroundColor =BGColor   ;
    //    //右
//    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
//    shareBtn.backgroundColor = [UIColor clearColor];
//    [shareBtn addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
//    [shareBtn setImage:[UIImage imageNamed:@"details_btn_white"] forState:UIControlStateNormal];
//    [topImageView addSubview:shareBtn];
//    
    
    
   //    //    //右
//    UIButton *shareBtnNomal = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
//    shareBtnNomal.backgroundColor = [UIColor clearColor];
//    [shareBtnNomal addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
//    [shareBtnNomal setImage:[UIImage imageNamed:@"details_btn_cart"] forState:UIControlStateNormal];
//    [topImageViewNomal addSubview:shareBtnNomal];
    
    touImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 556*Width)];
    touImageView.image =[UIImage imageNamed:@"timg-8.jpeg"];
    touImageView.backgroundColor =[UIColor grayColor];
    [bgScrollView addSubview:touImageView];
    [touImageView setUserInteractionEnabled:YES];
    
    
    
    UIImageView *tmImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 556*Width)];
    tmImgV.backgroundColor =[UIColor blackColor];
    tmImgV.alpha =0.2;
    [bgScrollView addSubview:tmImgV];
    
    for (int i=0;i<3; i++) {
        UILabel *label =[[UILabel alloc]init];
        label.textColor =[UIColor whiteColor];
        label.tag =110+i;
        if (i==0) {
            label.frame =CGRectMake(46*Width, 390*Width+65*i*Width, Width*500, 80*Width);
            label.font =[UIFont boldSystemFontOfSize:15];
            _styleLabel=label;
            label.text =@"焕然一新打造美";
            
            
        }else if(i==1)
        {
            label.frame =CGRectMake(46*Width, _styleLabel.bottom, Width*250, 65*Width);
            label.font =[UIFont boldSystemFontOfSize:14];
            _nameLabel =label;
            label.text =@"东方世纪城";
            
        }else if(i==2)
            
        {
            label.frame =CGRectMake(_nameLabel.right, _styleLabel.bottom, Width*250, 65*Width);

            label.font =[UIFont boldSystemFontOfSize:14];
            _contentLabel =label;
            label.text =@"两室一厅";
            
        }
        [touImageView addSubview:label];
        
    }
    

    _seeBtn =[[UIButton alloc]initWithFrame:CGRectMake(535*Width, _styleLabel.bottom,110*Width , 60*Width)];
    [touImageView addSubview:_seeBtn];
    [_seeBtn addTarget:self action:@selector(seeBtn:) forControlEvents:UIControlEventTouchUpInside];
    _seeBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [_seeBtn setImage:[UIImage imageNamed:@"zx_rj_icon_liulan"] forState:UIControlStateNormal];
    [_seeBtn setTitle:@"100" forState:UIControlStateNormal];
    _talkBtn =[[UIButton alloc]initWithFrame:CGRectMake(645*Width, _styleLabel.bottom,110*Width , 60*Width)];
    [touImageView addSubview:_talkBtn];
    [_talkBtn addTarget:self action:@selector(talkBtn:) forControlEvents:UIControlEventTouchUpInside];
    _talkBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [_talkBtn setImage:[UIImage imageNamed:@"zx_rj_icon_pinglun"] forState:UIControlStateNormal];
    [_talkBtn setTitle:@"100" forState:UIControlStateNormal];
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, touImageView.bottom, CXCWidth, 120*Width)];
    bgView.backgroundColor =[UIColor whiteColor];
    [bgScrollView   addSubview:bgView];
    
    //shang边文字
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*Width,20*Width,220*Width,40*Width)];
    _priceLabel.font =[UIFont systemFontOfSize:13];
    _priceLabel.text =@"均价：12355";
    _priceLabel.textColor =TextColor;
    [bgView addSubview:_priceLabel];
    //shang边文字
    _isquanbaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.right,20*Width,480*Width,40*Width)];
    _isquanbaoLabel.font =[UIFont systemFontOfSize:13];
    _isquanbaoLabel.text =@"全包";
    _isquanbaoLabel.textColor =TextColor;
    [bgView addSubview:_isquanbaoLabel];

    self.startLabel = [[UILabel alloc] initWithFrame:CGRectMake(450*Width,20*Width,280*Width,40*Width)];
    self.startLabel.textColor = TextGrayColor;
    _startLabel.textAlignment =NSTextAlignmentRight;
    self.startLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.startLabel.backgroundColor = [UIColor clearColor];
    self.startLabel.text =@"开始时间：2014-09-01";
    [bgView addSubview:self.startLabel];
    self.kfsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*Width,_priceLabel.bottom,420*Width,40*Width)];
    self.kfsLabel.textColor = TextGrayColor;
    self.kfsLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.kfsLabel.backgroundColor = [UIColor clearColor];
    self.kfsLabel.text =@"施工单位：山东桥通天下";
    [bgView addSubview:self.kfsLabel];
    

    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(450*Width,_startLabel.bottom,280*Width,60*Width)];
    self.endLabel.textColor = TextGrayColor;
    _endLabel.textAlignment =NSTextAlignmentRight;
    self.endLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.endLabel.backgroundColor = [UIColor clearColor];
    self.endLabel.text =@"竣工时间：2014-09-01";
    [bgView addSubview:self.endLabel];
    
    //橘黄色的
    _orangeLabel   =[[UILabel alloc]initWithFrame:CGRectMake(620*Width,536*Width,130*Width,40*Width)];
    _orangeLabel.textAlignment=NSTextAlignmentCenter;
    _orangeLabel.text =@"木工阶段";
    _orangeLabel.backgroundColor=orangeColor;
    _orangeLabel.textColor =[UIColor whiteColor];
    _orangeLabel.font =[UIFont systemFontOfSize:12];
    [bgScrollView addSubview:_orangeLabel];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.orangeLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(20*Width, 20*Width)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = _orangeLabel.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.orangeLabel.layer.mask = maskLayer;
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0, CXCWidth,CXCHeight ) style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,0, CXCWidth, CXCHeight-100*Width)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView .showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
////    //下拉刷新
//    self.headerView = bgScrollView;
//    //上拉加载
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
//    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
//    self.footerView = footerView;
    infoArray = [[NSMutableArray alloc] init];
    [self addFooter];

    topImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    topImageView.alpha =0.0;
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"歌尔绿城"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [topImageView addSubview:navTitle];
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    topImageViewNomal= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageViewNomal.userInteractionEnabled = YES;
    topImageViewNomal.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topImageViewNomal];
    topImageViewNomal.alpha =1.0;
    

    //添加返回按钮
    UIButton *  returnBtnNomal = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtnNomal.frame = CGRectMake(0, 20, 44, 44);
    [returnBtnNomal setImage:[UIImage imageNamed:@"sf_icon_xiang_goBack"] forState:UIControlStateNormal];
    [returnBtnNomal addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageViewNomal addSubview:returnBtnNomal];

    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor colorWithRed:59/255.00 green:63/255.00 blue:80/255.00 alpha:1]];
    [self.view addSubview:bottomBgview];
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(50*Width, 0, 500*Width, 100*Width)];
    [subPromLabel setText:@"想了解具体细节？找TA问问"];
    [subPromLabel  setFont:[UIFont systemFontOfSize:16]];
    [bottomBgview  addSubview:subPromLabel];
    [subPromLabel  setTextColor:[UIColor whiteColor]];
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(540*Width,20*Width , 170*Width, 60*Width)];
    [confirmBtn setBackgroundColor:orangeColor];
    confirmBtn.layer.cornerRadius =30*Width;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmBtn setTitle:@"免费设计" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(searchSheji) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];
    
    
    
}

- (void)searchSheji
{
    
    
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)seeBtn:(UIButton *)btn
{

}
-(void)talkBtn:(UIButton *)btn
{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return bgScrollView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 676*Width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return infoArray.count ;
    return 10 ;

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *titleContent =@"看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美。也开始想象自己有这样的家。我最开始感觉就是在看软装，这个沙发，那个吊灯...totally wrong direction.现在开始落地起来，开始找装修公司设计师，SD、MF、NH，开始看预算，开始和小伙伴聊中央空调，\n西门子开关，比较优劣，开始看各位16楼的日记，哈，工作之余的事情就是装修！现在是午休时间，给自己开了篇。";
    CGSize titleSize;//通过文本得到高度
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return  titleSize.height+160*Width+230*3*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    DiaryDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DiaryDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
//    cell.dic =infoArray[indexPath.row];
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (void)getInfoList
{
    
    
    
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
        //        for (int i = 0; i<5; i++) {
        //           [vc.fakeColors addObject:MJRandomColor];
        //        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.tableView reloadData];
            // 结束刷新
            [vc.tableView footerEndRefreshing];
        });
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==_tableView)
    {
        
        //相对于图片的偏移量
        CGFloat reOffset = scrollView.contentOffset.y ;
        //    (kOriginalImageHeight - 64)这个数值决定了导航条在图片上滑时开始出现  alpha 从 0 ~ 0.99 变化
        //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
        CGFloat alpha = reOffset /(556.0*Width-64) ;
        NSLog(@"reOffset=%f",alpha);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
