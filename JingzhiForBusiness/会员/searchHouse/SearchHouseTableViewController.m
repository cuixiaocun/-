//
//  SearchHouseTableViewController.m
//  家装
//
//  Created by Admin on 2017/9/8.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "SearchHouseTableViewController.h"
#import "SearchOneCell.h"
#import "MenuChooseVC.h"
#import "HouseDetailMainVC.h"
@interface SearchHouseTableViewController ()<UITextFieldDelegate,MenuChooseDelegate>
{

    MenuChooseVC *topView;

}
@end

@implementation SearchHouseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    currentPage =0;

    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
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
    searchBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    searchBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];
    
    
    
    NSArray *btnArr =@[@"区域",@"类型",@"价格",@"排序",@"123"];
    topView =[[MenuChooseVC alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus+1, CXCWidth, 85*Width) buttonArr:btnArr];
    topView.backgroundColor =[UIColor redColor];
    topView.level = 2;
    topView.delegate =self;
    
    [self.view addSubview:topView];
//    for (int i=0; i<4; i++) {
//        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        statuBtn.frame = CGRectMake(CXCWidth/4*i, 0,CXCWidth/4-2*Width ,85*Width);
//        if (i==0) {
//            statuBtn.selected =YES;
//        }else
//        {
//            statuBtn.selected =NO;
//        }
//        [statuBtn addTarget:self action:@selector(changeStatuBtnOut:) forControlEvents:UIControlEventTouchUpInside];
//        [topView addSubview:statuBtn];
//        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
//        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
//        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
//        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
//        [statuBtn setImage:[UIImage imageNamed:@"sf_icon_down"]forState:UIControlStateNormal];
//        [statuBtn setImage:[UIImage imageNamed:@"sf_icon_down_pre"]forState:UIControlStateSelected];
//        
//        statuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//左对齐(UIControlContentHorizontalAlignment、UIControlContentHorizontalAlignmentCenter、UIControlContentHorizontalAlignmentRight)
//        [statuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -statuBtn.imageView.bounds.size.width, 0, statuBtn.imageView.bounds.size.width)];
//        
//        [statuBtn setImageEdgeInsets:UIEdgeInsetsMake(0, statuBtn.titleLabel.bounds.size.width, 0, -statuBtn.titleLabel.bounds.size.width)];
//        statuBtn.tag =230+i;
//        [statuBtn addTarget:self action:@selector(changeStatuBtnOut:) forControlEvents:UIControlEventTouchUpInside];
//        [topView addSubview:statuBtn];
//        
//    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topView addSubview:xian];
    xian.frame =CGRectMake(0,83*Width, CXCWidth, 2*Width);
        
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width, CXCWidth, CXCHeight-Frame_rectStatus)];
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
    //    [self performSelector:@selector(getInfoList)];
    

 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSArray *)addressArr{
    
    if (_addressArr == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil]];
        _addressArr = [dic objectForKey:@"address"];
        NSLog(@"address=%@",_addressArr);
    }
    return _addressArr;
}
-(void)btnClickBtn:(UIButton *)cell
{
    topView.addressArr =self.addressArr;
    topView.typeString =@"city";


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
    return 270*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    SearchOneCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SearchOneCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
//    NSDictionary *dict = [infoArray objectAtIndex:row];
//    [cell setDic:dict];
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
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width, CXCWidth, CXCHeight-20)];
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    HouseDetailMainVC *house =[[HouseDetailMainVC alloc]init];
    [self.navigationController  pushViewController:house animated:YES];

}/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
