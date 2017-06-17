//
//  NoticeVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/16.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeCell.h"
@interface NoticeVC ()

@end

@implementation NoticeVC

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
    [navTitle setText:@"公告"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    
    
    [self mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mainView
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,64+20*Width, CXCWidth, CXCHeight-100*Width-20)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
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


}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return infoArray.count ;
    return 5;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray*arr=@[@{@"key":@"sdlfjhkas17763671722李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气",@"index":@"0",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdl17763671722f卡死了带回家科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdl死了带回家科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得0536-7371734好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都0536-7371734是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货18363671722了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"}];
    NSString *titleContent =[[arr objectAtIndex:indexPath.row] objectForKey:@"key"];
    CGSize titleSize;//通过文本得到高度
    
    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return  titleSize.height+190*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    NoticeCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    NSArray*arr=@[@{@"key":@"sdlfjhkas17763671722李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气",@"index":@"0",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdl17763671722f卡死了带回家科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdl死了带回家科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得0536-7371734好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都0536-7371734是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴科维奇人",@"index":@"1",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货18363671722了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"},
                  @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2",@"time":@"2017-09-09 20：15：23"}];
    cell.dic =arr[indexPath.row];
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    DeclarDetailVC *declar =[[DeclarDetailVC alloc]init];
    //    [self.navigationController pushViewController:declar animated:YES];
    
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
    [self.tableView setFrame:CGRectMake(0,64+20*Width, CXCWidth, CXCHeight-100*Width-20)];
    
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
