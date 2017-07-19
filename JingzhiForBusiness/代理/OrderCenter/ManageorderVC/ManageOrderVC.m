//
//  ManageOrderVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ManageOrderVC.h"
#import "ManageOrderCell.h"
#import "LogisticsDetailVC.h"
#import "ScanningAndTracingVC.h"
#import "IsTureAlterView.h"
#import "SendGoodsVC.h"
@interface ManageOrderVC ()<ManagerOrderCellDelegate,IsTureAlterViewDelegate>
{

    NSString *status;
    NSInteger indexTag;

}
@end

@implementation ManageOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
    [navTitle setText:@"订单管理"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    if ([_statusString isEqualToString:@"全部"]) {
        status =@"0";
    }else if ([_statusString isEqualToString:@"未发货"])
    {
        status =@"2";

    }else if ([_statusString isEqualToString:@"已发货"])
    {
        status =@"3";
        
    }else if ([_statusString isEqualToString:@"已完成"])
    {
        status =@"4";
        
    }

    
    [self mainView];
}
- (void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)mainView
{
    
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 100*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray *btnArr =@[@"全部",@"未发货",@"已发货",@"已完成"];
    for (int i=0; i<4; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statuBtn.frame = CGRectMake(CXCWidth/4*i, 0,CXCWidth/4-2*Width ,100*Width);
        if ([_statusString isEqualToString:btnArr[i]]) {
            statuBtn.selected =YES;
        }
        if (i<4) {
            //横线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [topView addSubview:xian];
            xian.frame =CGRectMake(statuBtn.right,25*Width, Width, 50*Width);
            
        }
        //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
        statuBtn.tag =220+i;
        [statuBtn addTarget:self action:@selector(changeStatuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:statuBtn];
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topView addSubview:xian];
    xian.frame =CGRectMake(0,98*Width, CXCWidth, 2*Width);
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,64+100*Width, CXCWidth, CXCHeight-100*Width-20)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBackgroundColor:BGColor];
    self.tableView .showsVerticalScrollIndicator = NO;
    
    //下拉刷新
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    //上拉加载
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    infoArray = [[NSMutableArray alloc] init];
    [self performSelector:@selector(getInfoList)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<5; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    if (btn.tag==220 ) {
        status =[NSString stringWithFormat:@"%ld",btn.tag-220];

    }else
    {
        status =[NSString stringWithFormat:@"%ld",btn.tag-220+1];

    }
    btn.selected =YES;
    
    currentPage=0;
    [self getInfoList];
    
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return infoArray.count ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 484*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    ManageOrderCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ManageOrderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    cell.delegate=self;
        NSDictionary *dict = [infoArray objectAtIndex:row];
        [cell setDic:dict];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
    [self.tableView setFrame:CGRectMake(0,64+100*Width, CXCWidth, CXCHeight-20)];
    
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
    [dic1 setDictionary:@{
                          @"currentPage":[NSString stringWithFormat:@"%ld",currentPage] ,
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          @"status":status
                          }
     ];
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/getalltoagenorder" paraments:dic1  addView:self.view success:^(id responseDic) {
        
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
//        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"] ]isEqualToString:@"0"]) {
        
        
        if (currentPage==0) {
            [infoArray removeAllObjects];
            
        }
        if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"] ]isEqualToString:@"0"]) {
            [self.tableView reloadData];
            return ;

        }
        NSMutableArray *array=[[dict objectForKey:@"data"] objectForKey:@"agenorder"];
        
        
        [infoArray addObjectsFromArray:array];
        
        if ([infoArray count]==0 && currentPage==0) {
            
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
            //                [self.tableView setScrollsToTop:YES];
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
    
}
#pragma mark MyOrderDelelgate
-(void)btnClick:(UITableViewCell *)cell andActionTag:(NSInteger)tag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    indexTag =index.row;

    if(tag==2000)
    {
        
        NSLog(@"%@",@"查看物流");
        LogisticsDetailVC *logisticsDetailVC =[[LogisticsDetailVC alloc]init];
        NSDictionary *dic=infoArray[index.row];
//        NSMutableDictionary *dicDetail =[NSMutableDictionary dictionary];
//        [dicDetail setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"receivename"]] forKey:@"name"];
//        [dicDetail setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"phone"]] forKey:@"phone"];
//        [dicDetail setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]] forKey:@"address"];
//        [dicDetail setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] forKey:@"status"];
        
        logisticsDetailVC.logistics =[NSString stringWithFormat:@"%@",[dic objectForKey:@"logistics"]];
        logisticsDetailVC.logisticscom  =[NSString stringWithFormat:@"%@",[dic objectForKey:@"logisticscom"]];
        logisticsDetailVC.dicDetail =dic;


        [self.navigationController pushViewController:logisticsDetailVC animated:YES];
        
        
        
    }else if (tag==2001)
    {
        
        
        IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要流转到上一级吗？"];
        isture.delegate =self;
        isture.tag =180;
        [self.view addSubview:isture];
        NSLog(@"%@",@"流转");

        return;
        

        
        
    }else if (tag==2002)
    {
        int box =[[infoArray[indexTag] objectForKey:@"num"] intValue]/[[infoArray[indexTag] objectForKey:@"boxnum"] intValue];
        if (box>0) {
            ScanningAndTracingVC *scanningDetailVC =[[ScanningAndTracingVC alloc]init];
            scanningDetailVC.orderDetailDic =infoArray[indexTag];

            [self.navigationController pushViewController:scanningDetailVC animated:YES];
            NSLog(@"%@",@"发货");
        }else
        {
            SendGoodsVC*send =[[SendGoodsVC alloc]init];
            send.orderDetailDic =infoArray[indexTag];
            [self.navigationController pushViewController:send animated:YES];
        }

        
        
       

    }else if (tag==2003)
    {
        
        
        IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要驳回此申请吗？"];
        isture.delegate =self;
        isture.tag =181;
        [self.view addSubview:isture];
        NSLog(@"%@",@"驳回");
        
        return;
        
        
        
        
    }

    
}
#pragma mark - IsTureAlterViewDelegate

-(void)cancelBtnActinAndTheAlterView:(UIView *)alter
{
    [alter removeFromSuperview];
    NSLog(@"取消");
    
}
-(void)tureBtnActionAndTheAlterView:(UIView *)alter
{
    if(alter.tag ==180)
    {IsTureAlterView *isture = [self.view viewWithTag:180];
        [isture removeFromSuperview];
        NSLog(@"确认");
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setDictionary:@{
                              @"orderid": [infoArray[indexTag] objectForKey:@"id"],
                              }
         ];
        
        [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/flowagenorder" paraments:dic1  addView:self.view success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                [ProgressHUD showSuccess:@"流转成功"];
                currentPage=0;
                [self getInfoList];
            }
            
        } fail:^(NSError *error) {
            
        }];
    
    }
    
    
    
    
}

@end
