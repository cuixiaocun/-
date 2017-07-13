//
//  ManageDeclareVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ManageDeclareVC.h"
#import "GoodsAndNumCell.h"
#import "ManageDeclarCell.h"
#import "DeclarDetailVC.h"
#import "IsTureAlterView.h"

@interface ManageDeclareVC ()<UITableViewDelegate,UITableViewDataSource,ManagerDelegate,IsTureAlterViewDelegate >
{
    NSArray *stockInforArr;
    NSIndexPath *index;
}
@end

@implementation ManageDeclareVC

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
    [navTitle setText:@"报单管理"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    if ([_statusString isEqualToString:@"全部"]) {
        status     =@"0";
    }else if ([_statusString isEqualToString:@"待审核"])
    {
        status =@"1";
        
    }else if ([_statusString isEqualToString:@"已审核"])
    {
        status =@"3";
        
    }
    [self getInfoList];

    
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
    NSArray *btnArr =@[@"全部",@"待审核",@"已审核"];
    for (int i=0; i<3; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statuBtn.frame = CGRectMake(CXCWidth/3*i, 0,CXCWidth/3-2*Width ,100*Width);
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
    stockInforArr  =[[NSArray alloc]init];
//    [self getStoke];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ if(indexPath.section==0)
 {
     return;
    
 }else
 {
     
     DeclarDetailVC *declar =[[DeclarDetailVC alloc]init];
     
     if ([[[infoArray objectAtIndex: index.row] objectForKey:@"status"]isEqualToString:@"1"]) {
         declar.isHavePass =@"YES";//可以审核的
         
     }else
     {
         declar.isHavePass =@"NO";//可以审核的
         
     }
   
     declar.ismy =@"1";
     declar.orderId =[infoArray[indexPath.row] objectForKey:@"id"];
     [self.navigationController pushViewController:declar animated:YES];
 
 }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        NSString *str=@"  当前产品数量";
        CGSize titleSize;//通过文本得到高度
        titleSize = [str boundingRectWithSize:CGSizeMake( MAXFLOAT,70*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel*promLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,0 ,CXCWidth,70*Width )];
        promLabel.text =str;
        promLabel.backgroundColor =BGColor;
        promLabel.font =[UIFont systemFontOfSize:14];
        promLabel.textColor =TextColor;
        return promLabel;
        

    }else
    {
        return nil;
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{  if(section==0)
  {
      return 70*Width;

  }else
      return 0.01*Width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return stockInforArr.count;
  
    }
    return infoArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 80*Width;
    }
    return 476*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        static NSString *CellIdentifier = @"Cell0";
        GoodsAndNumCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[GoodsAndNumCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
            NSDictionary *dict = stockInforArr [indexPath.row];
            [cell setDic:dict];
        return cell;
    
    }else
    {
        static NSString *CellIdentifier = @"Cell1";
        ManageDeclarCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ManageDeclarCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        cell.delegate =self;
            NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
            [cell setDic:dict];
        return cell;
        
    }
   
}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    
    if (btn.tag==222 ) {
        status =[NSString stringWithFormat:@"%ld",btn.tag-220+1];
        
    }else
    {
        status =[NSString stringWithFormat:@"%ld",btn.tag-220];
        
    }
    btn.selected =YES;
    
    currentPage=0;
    [self getInfoList];
    
    

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01*Width;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
    
    
}
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    index = [ self.tableView indexPathForCell:cell];
    
    switch (flag) {
        case 2000:
        {
        //详情
            DeclarDetailVC *declar =[[DeclarDetailVC alloc]init];

            if ([[[infoArray objectAtIndex: index.row] objectForKey:@"status"]isEqualToString:@"1"]) {
                
                declar.isHavePass =@"YES";//可以审核的

            }else
            {
                declar.isHavePass =@"NO";//可以审核的

            }
            declar.ismy =@"1";
            declar.orderId =[infoArray[index.row] objectForKey:@"id"];
            [self.navigationController pushViewController:declar animated:YES];
            
            break;
            
        }
        case 2001:
        {
           //审核通过
            IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要通过审核吗？"];
            isture.delegate =self;
            isture.tag =180;
            [self.view addSubview:isture];
            
            NSLog(@"驳回");
            return;

            
            break;

        }
        case 2003:
        {
            //审核通过
            IsTureAlterView *isture =[[IsTureAlterView alloc]initWithTitile:@"确认要驳回次报单吗？"];
            isture.delegate =self;
            isture.tag =181;
            [self.view addSubview:isture];
            
            NSLog(@"驳回");
            return;
            
            
            break;
            
        }

    
  }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IsTureAlterViewDelegate

-(void)cancelBtnActinAndTheAlterView:(UIView *)alter
{
    [alter removeFromSuperview];
    NSLog(@"取消");
    
}
-(void)tureBtnActionAndTheAlterView:(UIView *)alter
{
    if(alter.tag==180)
    {
        IsTureAlterView *isture = [self.view viewWithTag:180];
        [isture removeFromSuperview];
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setDictionary:@{
                              //            @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                              @"id":[[infoArray objectAtIndex: index.row] objectForKey:@"id"]}];
        
        [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/auditdagenonlineorder" paraments:dic1  addView:self.view success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                
                
                
                [[self rdv_tabBarController] setSelectedIndex:0];
                [MBProgressHUD showSuccess:@"审核成功" ToView:self.view];
                [self.tableView reloadData];
            }
            
        } fail:^(NSError *error) {
            
        }];

    
    }else
    {
        IsTureAlterView *isture = [self.view viewWithTag:181];
        [isture removeFromSuperview];
        NSLog(@"确认");
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setDictionary:@{
                              @"id": [[infoArray objectAtIndex: index.row] objectForKey:@"id"],
                              }
         ];
        [PublicMethod AFNetworkPOSTurl:@"Home/AgentOnlineorder/rejectReport" paraments:dic1  addView:self.view success:^(id responseDic) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
            if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
                [ProgressHUD showSuccess:@"驳回成功"];
                currentPage=0;
                [self getInfoList];
            }
            
        } fail:^(NSError *error) {
            
        }];
        
    }
    
    
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
    [dic1 setDictionary:@{@"currentPage":[NSString stringWithFormat:@"%ld",currentPage] ,
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          @"status":status
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/agenonlineorder" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if (currentPage==0) {
            [infoArray removeAllObjects];
        }
        stockInforArr =[[dict objectForKey:@"data"] objectForKey:@"agenstock"];
        [self.tableView reloadData];

        NSMutableArray *array=[[dict objectForKey:@"data"] objectForKey:@"agenorder"];
        if ([array isKindOfClass:[NSNull class]]) {
            [self.tableView reloadData];
            
            return ;
        }
        
        
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
//- (void)getStoke
//{
//    
//    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
//    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
//                          }
//     ];
//    
//    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/myagenstock" paraments:dic1  addView:self.view success:^(id responseDic) {
//        NSDictionary*  goodsDict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil] ;
//        if([ [NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"code"]]isEqualToString:@"0"])
//        {
//            
//                  }
//        
//    } fail:^(NSError *error) {
//        
//    }];
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
