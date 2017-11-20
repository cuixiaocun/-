//
//  ComCompanyList.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ComCompanyList.h"
#import "MenuChooseVC.h"
#import "MJRefresh.h"
#import "ComCompanyCell.h"
#import "ShopStoreMainVC.h"
#import "ComcompanyTableviewCell.h"
@interface ComCompanyList ()<UITextFieldDelegate,MenuChooseDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSInteger currentPage; //当前页
    UIScrollView*topView;
    
    NSString *statuString;
    NSIndexPath *index;
    NSString *typeStr;
    NSMutableArray *typeArr;
    BOOL isMore;
    //横线
    UIImageView*xian;
    
}

@end

@implementation ComCompanyList
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    currentPage =1;
    infoArray =[[NSMutableArray alloc]init];
    typeArr =[[NSMutableArray alloc]init];
    isMore =YES;

    [self allType];
  

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
    [searchTextField setPlaceholder:@"请输入店铺"];
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
    searchBtn.frame = CGRectMake(CXCWidth-60,Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    
    searchBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];
    topView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, 85*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    topView.showsVerticalScrollIndicator = FALSE;
    topView.showsHorizontalScrollIndicator = FALSE;
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topView addSubview:xian];
    xian.frame =CGRectMake(0,83*Width, CXCWidth, 2*Width);
    //1\初始化layout
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width, CXCWidth, CXCHeight-Frame_rectStatus-85*Width-49)];
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
    currentPage =1;
    infoArray =[[NSMutableArray alloc]init];
    [self getInfoList];
    
    
}

- (void)changeStatuBtn:(UIButton *)btn
{
   
//    UIImageView *imageview =(UIImageView *)[self.view viewWithTag:14];
    
    [UIView animateWithDuration:0.15 animations:^{
//        [imageview setFrame:CGRectMake(CXCWidth/3*(btn.tag-220), 64+85*Width, CXCWidth/3, 3*Width)];
        
    }completion:^(BOOL finished){
        
    }];
    
    for (int i=0; i<typeArr.count; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    typeStr =[typeArr[btn.tag-220] objectForKey:@"cat_id"];
    NSLog(@"typeStrtypeStr=%@",typeStr);
    currentPage=1;
    [self getInfoList];



}
- (void)getInfoList
{
    
    UITextField *textf =[self.view viewWithTag:30];
    [textf resignFirstResponder];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"page":[NSString stringWithFormat:@"%ld",(long)currentPage],
                          @"keywords":[NSString stringWithFormat:@"%@",textf.text],
                          @"cat_id":[NSString stringWithFormat:@"%@",typeStr],
                          }];
    
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?product-f.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];

        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"])
        {
            NSMutableArray *array=[[dict objectForKey:@"data"] objectForKey:@"ite"];
            
            if (currentPage==1) {
                [infoArray removeAllObjects];
            }
            if ([array isKindOfClass:[NSNull class]]) {
                
                [self.tableView reloadData];
                return ;
            }
            [infoArray addObjectsFromArray:array];
            
            if ([infoArray count]==0 && currentPage==1) {
                
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
-(void)btnClickBtn:(UIButton *)cell
{
}

- (void)withDrawlsBtnAction
{
    UITextField *searchTextField =[self.view viewWithTag:30];
    [searchTextField resignFirstResponder];
    if ([[NSString stringWithFormat:@"%@",searchTextField.text] isEqualToString:@""]) {
        [MBProgressHUD showSuccess:@"请输入内容" ToView:self.view];
        return;
    }
    currentPage=1;
    [self getInfoList];
    
}
- (void)returnBtnAction
{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)allType{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"cat_id":@"",
                          }];
    NSLog(@"%@",dic1);
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?product-cate.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"])
        {
            
            NSArray *typeArry =[[dict objectForKey:@"data"] objectForKey:@"cate"];
            NSMutableDictionary *dic1 =[[NSMutableDictionary alloc]init];
            [dic1 setValue:@"全部" forKey:@"title"];
            [dic1 setValue:@"" forKey:@"cat_id"];
            [typeArr addObject:dic1];

            for (int i=0; i<typeArry.count; i++) {
                NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
                [dic setValue:[typeArry[i] objectForKey:@"title"] forKey:@"title"];
                [dic setValue:[typeArry[i] objectForKey:@"cat_id"] forKey:@"cat_id"];
                [typeArr addObject:dic];
                
            }
            
            for (int i=0; i<typeArr.count; i++) {
                UIButton * statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                statuBtn.frame = CGRectMake(CXCWidth/4*i, 0,CXCWidth/4-2*Width ,85*Width);
                [statuBtn setTitle:[typeArr[i] objectForKey:@"title"] forState:UIControlStateNormal];
                statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
                [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
                statuBtn.tag =220+i;
                [statuBtn addTarget:self action:@selector(changeStatuBtn:) forControlEvents:UIControlEventTouchUpInside];
                [topView addSubview:statuBtn];
                
                if(i==0)
                {
                    statuBtn.selected = YES;
                }
            }
            
            [topView setContentSize:CGSizeMake(CXCWidth/4*typeArr.count, 85*Width)];
            //横线
            xian.frame =CGRectMake(0,83*Width, CXCWidth/4*typeArr.count, 2*Width);

            
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    ComcompanyTableviewCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ComcompanyTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSDictionary *dict = [infoArray objectAtIndex:row];
    [cell setDic:dict];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopStoreMainVC*goode =[[ShopStoreMainVC alloc]init];
    goode.shopId =[NSString stringWithFormat:@"%@",[infoArray[indexPath.row] objectForKey:@"shop_id"]];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController  pushViewController:goode animated:YES];
    
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
    self.headerView.hidden =YES;
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    self.headerView.hidden =NO;
    
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    currentPage=1;
    [self getInfoList];
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
