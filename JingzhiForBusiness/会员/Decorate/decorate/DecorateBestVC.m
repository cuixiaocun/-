//
//  DecorateBestVC.m
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DecorateBestVC.h"
#import "DecorateBestCell.h"
#import "MenuChooseVC.h"
#import "AKGallery.h"
@interface DecorateBestVC ()<MenuChooseDelegate>
{
    MenuChooseVC *topView;
    NSMutableArray *typeArr;
    NSMutableArray *apartmentArr;
    NSMutableArray *orderArr;
    
    
    NSString *typeId;
    NSString *apartmentId;
    NSString *orderId;


}
@end

@implementation DecorateBestVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    currentPage =1;
    
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
    [navTitle setText:@"精选设计案例"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];

    NSArray *btnArr =@[@"户型",@"风格",@"排序"];
    topView =[[MenuChooseVC alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, 85*Width) buttonArr:btnArr];
    topView.backgroundColor =[UIColor redColor];
    topView.delegate =self;
    topView.level = 2;

    [self.view addSubview:topView];
    
    UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(0*Width,0*Width,CXCWidth,1.5*Width)];
    xianV.backgroundColor =BGColor;
    [topView addSubview:xianV];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width, CXCWidth, CXCHeight-Frame_rectStatus-85*Width)];
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
    
    [self getInfoList ];
    infoArray = [[NSMutableArray alloc] init];
    //    [self performSelector:@selector(getInfoList)];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)btnClickBtn:(UIButton *)cell
{
    if (cell.tag==230) {
        topView.addressArr =apartmentArr;
        topView.typeString =@"area_list";
        topView.level = 1;
        NSLog(@"cityArr = %@",apartmentArr);
    }else if (cell.tag==231)
    {
        topView.addressArr =typeArr;
        topView.typeString =@"area_list";
        topView.level = 1;
        
    }else if (cell.tag==232)
    {
        topView.addressArr =orderArr;
        topView.typeString =@"area_list";
        topView.level = 1;
        NSLog(@"cityArr = %@",orderArr);
    }
    
    
}
-(void)chooseBtnReturn:(UIButton *)btn withStringId:(NSString *)stringId
{
    if (btn.tag==230) {
        apartmentId =stringId;
    }else if (btn.tag==231) {
        typeId =stringId;
    }else if (btn.tag==232) {
        orderId =stringId;
    }
    NSLog(@"apartmentId=%@typeId=%@priceId=%@orderId",apartmentId,typeId,orderId);
    //刷新
    currentPage=1;
    
    [self performSelector:@selector(getInfoList)];
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
    return infoArray.count ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 522*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    DecorateBestCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DecorateBestCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
        NSDictionary *dict = [infoArray objectAtIndex:row];
        [cell setDic:dict];
    return cell;
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
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width, CXCWidth, CXCHeight-Frame_rectStatus-85*Width)];
    
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
        currentPage = 1;
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.18f];
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
        [CATransaction commit];
    }
    
    else{
        
        if ([hv.title.text isEqualToString:@"松开即可更新..."]) {
            currentPage = 1;
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
    
    currentPage=1;
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
    UITextField *searchTF =[self.view viewWithTag:30];
    [searchTF resignFirstResponder];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"apartment_layout_id":[NSString stringWithFormat:@"%@",apartmentId],
                          @"type_id":[NSString stringWithFormat:@"%@",typeId],
                          @"order":[NSString stringWithFormat:@"%@",orderId],
                          @"page":[NSString stringWithFormat:@"%ld",(long)currentPage],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?case-items" paraments:dic1 addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {

            if (currentPage==1) {
                [infoArray removeAllObjects];
            }
            apartmentArr =[[NSMutableArray alloc] init];
            typeArr =[[NSMutableArray alloc] init];
            orderArr =[[NSMutableArray alloc] init];
           
            //户型
            NSArray *apartmentArry =[[dict objectForKey:@"data"] objectForKey:@"apartment_layout_list"];
            NSMutableDictionary  *dictionary =[[NSMutableDictionary alloc]init];
            [dictionary setValue:[NSString stringWithFormat:@"%@",@"不限"] forKey:@"name"];
            [dictionary setValue:[NSString stringWithFormat:@"%@",@""] forKey:@"zipcode"];
            [apartmentArr addObject:dictionary];
            for (NSDictionary*dic in apartmentArry) {
                NSMutableDictionary  *dictionary =[[NSMutableDictionary alloc]init];
                [dictionary setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] forKey:@"name"];
                [dictionary setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"attr_value_id"]] forKey:@"zipcode"];
                [apartmentArr addObject:dictionary];
            }
            //type列表
            NSArray *typeArry =[[dict objectForKey:@"data"] objectForKey:@"type_list"];
            NSMutableDictionary  *dictionary1 =[[NSMutableDictionary alloc]init];
            [dictionary1 setValue:[NSString stringWithFormat:@"%@",@"不限"] forKey:@"name"];
            [dictionary1 setValue:[NSString stringWithFormat:@"%@",@""] forKey:@"zipcode"];
            [typeArr addObject:dictionary1];
            for (NSDictionary*dic in typeArry) {
                NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
                [dictionary setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] forKey:@"name"];
                [dictionary setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"attr_value_id"]] forKey:@"zipcode"];
                [typeArr addObject:dictionary];
                NSLog(@"%@",typeArr);
                NSLog(@"%@",[dic objectForKey:@"title"]);

            }
           
            //Order
            NSArray *orderArry =[[dict objectForKey:@"data"] objectForKey:@"order_list"];
            NSMutableDictionary  *dictionary3 =[[NSMutableDictionary alloc]init];
            [dictionary3 setValue:[NSString stringWithFormat:@"%@",@"不限"] forKey:@"name"];
            [dictionary3 setValue:[NSString stringWithFormat:@"%@",@"0"] forKey:@"zipcode"];
            [orderArr addObject:dictionary3];
            for (int i=0;i<orderArry.count; i++) {
                NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
                [dictionary setValue:[NSString stringWithFormat:@"%@",orderArry[i]] forKey:@"name"];
                [dictionary setValue:[NSString stringWithFormat:@"%d",i+1] forKey:@"zipcode"];
                [orderArr addObject:dictionary];
            }
            NSMutableArray *array=[[dict objectForKey:@"data"] objectForKey:@"items"];
            if ([array isKindOfClass:[NSNull class]]) {
                [MBProgressHUD showError:@"暂无信息" ToView:self.view];
                [self.tableView reloadData];

                return ;
            }

            [infoArray addObjectsFromArray:array];

            if ([infoArray count]==0 && currentPage==1) {
                [MBProgressHUD showError:@"暂无信息" ToView:self.view];
                [self.tableView reloadData];


            }
            pageCount =infoArray.count/10;
            //判断是否加载更多
            if (array.count==0 || array.count<10){
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
            if (currentPage==1) {
                [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            [self.tableView reloadData];

        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jxsjWithId:[infoArray[indexPath.row] objectForKey:@"case_id"]];

    
}
- (void)jxsjWithId:(NSString *)stringId
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"case_id":stringId
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?case-detail.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController  success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            NSArray *_dataList =[dict objectForKey:@"data"];
            NSMutableArray* arr= @[].mutableCopy;
            
            for (int  i = 0; i<_dataList.count; i++) {
                
                AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:[NSString stringWithFormat:@"%@%@",IMAGEURL,[_dataList[i] objectForKey:@"photo"]] img:nil];
                [arr addObject:item];
            }
            
            AKGallery* gallery = AKGallery.new;
            gallery.items=arr;
            gallery.custUI=AKGalleryCustUI.new;
            gallery.selectIndex=0;
            gallery.completion=^{
                NSLog(@"completion gallery");
            };
            
            //show gallery
            [self presentAKGallery:gallery animated:YES completion:nil];
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
