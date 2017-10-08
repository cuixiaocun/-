//
//  KnowledgeVC.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "KnowledgeVC.h"
#import "MenuChooseVC.h"
#import "EditKnowledgeVC.h"
#import "KnowledgeCell.h"
#import "PostMessageVC.h"
@interface KnowledgeVC ()<UITextFieldDelegate,MenuChooseDelegate>
{
    MenuChooseVC *topView;
}
@end

@implementation KnowledgeVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
//    //添加返回按钮
//    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
//    [returnBtn setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
//    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [topImageView addSubview:returnBtn];
    
    UIView *navBgView =[[UIView alloc]initWithFrame:CGRectMake(140*Width, Frame_rectStatus+8,470*Width , 28)];
    [topImageView addSubview:navBgView];
    [navBgView.layer setCornerRadius:14];
    navBgView.backgroundColor =BGColor;
    UIImageView *bigShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(18, 6, 16, 16)];
    bigShowImgV.image =[UIImage imageNamed:@"sf_icon_search"];
    [navBgView addSubview:bigShowImgV];
    UITextField *searchTextField = [[UITextField alloc] init];
    [searchTextField setPlaceholder:@"请输入问题"];
    [searchTextField setDelegate:self];
    searchTextField.tag =30;
    [searchTextField setFont:[UIFont systemFontOfSize:14]];
    [searchTextField setTextColor:[UIColor blackColor]];
    [searchTextField setFrame:CGRectMake(bigShowImgV.right+10, 0,350*Width,28)];
    searchTextField.returnKeyType=UIReturnKeySearch;
    [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [navBgView addSubview:searchTextField];
    
    
    //搜索按钮
    UIButton *  searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CXCWidth-60, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    searchBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];
    
    NSArray *btnArr =@[@"家装设计",@"装修流程",@"家居产品",@"装饰材料",@"排序"];
    topView =[[MenuChooseVC alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, 85*Width) buttonArr:btnArr];
    topView.backgroundColor =[UIColor redColor];
    topView.delegate =self;
    topView.level = 2;
    
    [self.view addSubview:topView];
    
    UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(0*Width,0*Width,CXCWidth,1.5*Width)];
    xianV.backgroundColor =BGColor;
    [topView addSubview:xianV];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width+20*Width, CXCWidth, CXCHeight-Frame_rectStatus-85*Width)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView .showsVerticalScrollIndicator = NO;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    // 下拉刷新
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    // 上拉加载
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    
    
    infoArray = [[NSMutableArray alloc] init];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(CXCWidth-230*Width,CXCHeight-350*Width , 150*Width, 150*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.shadowColor = NavColor.CGColor;

    layer.cornerRadius = 75*Width;
    [self.view.layer addSublayer:layer];
    
    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(CXCWidth-230*Width,CXCHeight-350*Width , 150*Width, 150*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:75*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [nextBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

}
- (void)sendMessage
{
    EditKnowledgeVC *edit=[[EditKnowledgeVC alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    [self.navigationController pushViewController:edit animated:YES];


}
-(void)btnClickBtn:(UIButton *)cell
{
    [topView.oneLinkageDropMenu dismiss];
}
- (void)changeStatuBtnOut:(UIButton *)btn
{
    
    
}
- (void)withDrawlsBtnAction
{
    
    
}
- (void)returnBtnAction
{
    [topView.oneLinkageDropMenu dismiss];

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10 ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 185*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    KnowledgeCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[KnowledgeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //    NSDictionary *dict = [infoArray objectAtIndex:row];
    //    [cell setDic:dict];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostMessageVC *post =[[PostMessageVC alloc]init];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    [self.navigationController pushViewController:post animated:YES];
    
}


#pragma mark - Pull to Refresh
- (void) pinHeaderView
{
    [super pinHeaderView];
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"加载中...";
    [CATransaction begin];
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width, CXCWidth, CXCHeight-Frame_rectStatus)];
    
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    ((DemoTableHeaderView *)self.headerView).arrowImage.hidden = YES;
    [CATransaction commit];;
}
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    
    // do custom handling for the header view
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    ((DemoTableHeaderView *)self.headerView).time.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:[NSDate date]]];
    [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    if (willRefreshOnRelease){
        hv.title.text = @"松开即可更新...";
        currentPage = 0;
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.18f];
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
        [CATransaction commit];
    }
    
    else{
        
        if ([hv.title.text isEqualToString:@"松开即可更新..."]) {
            currentPage = 0;
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.18f];
            ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
        }
        
        hv.title.text = @"下拉即可刷新...";
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        ((DemoTableHeaderView *)self.headerView).arrowImage.hidden = NO;
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DIdentity;
        [CATransaction commit];
    }
    
}
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:0];
    
    
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}
#pragma mark - Load More

- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
}
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0];
    
    
    // Inform STableViewController that we have finished loading more items
    
    return YES;
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
        [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight]
                       scrollView:scrollView];
    } else if (!isLoadingMore && self.canLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        //NSLog(@"%f====%f",scrollPosition,[self footerLoadMoreHeight]);
        if (scrollPosition < [self footerLoadMoreHeight] && scrollPosition > 20) {
            
            [fv.infoLabel setText:@"上拉加载更多..."];
        }else if(scrollPosition < 20){
            //[fv.infoLabel setText:@"释放开始加载..."];
            [fv.infoLabel setText:@"正在加载..."];
            [self loadMore];
        }
        
    }
}

#pragma mark - Dummy data methods
- (void) addItemsOnTop
{
    
    currentPage=0;
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (currentPage >= pageCount-1){
        self.canLoadMore = NO; // signal that there won't be any more items to load
    }else{
        self.canLoadMore = YES;
    }
    
    
    
    
    if (!self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
    
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self refreshCompleted];
}


- (void) addItemsOnBottom
{
    currentPage++;
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    
    if (currentPage >= pageCount-1)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}
- (void)getInfoList
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"page":[NSString stringWithFormat:@"%ld",(long)currentPage] ,
                          //                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:member] objectForKey:@"id"]]
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"Home/Member/recommend2" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            if (currentPage==0) {
                [infoArray removeAllObjects];
                
            }
            NSMutableArray *array=[dict objectForKey:@"data"];
            if ([array isKindOfClass:[NSNull class]]) {
                [PublicMethod setAlertInfo:@"暂无信息" andSuperview:self.view];
                
                return ;
            }
            
            
            [infoArray addObjectsFromArray:array];
            
            if ([infoArray count]==0 && currentPage==0) {
                [PublicMethod setAlertInfo:@"暂无信息" andSuperview:self.view];
                
            }
            pageCount =infoArray.count/20;
            //判断是否加载更多
            if (array.count==0 || array.count<20){
                self.canLoadMore = NO; // signal that there won't be any more items to load
            }else{
                self.canLoadMore = YES;//要是分页的话就要改成yes并且把上面的currentPage=1注掉
            }
            
            DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
            [fv.activityIndicator stopAnimating];
            
            if (!self.canLoadMore) {
                fv.infoLabel.hidden = YES;
            }else{
                fv.infoLabel.hidden = NO;
            }
            
            
            [self.tableView reloadData];
            if (currentPage==0) {
                [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            [self.tableView reloadData];
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
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
