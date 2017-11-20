//
//  FindDesignerVC.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FindDesignerVC.h"
#import "MenuChooseVC.h"
#import "FindDesignerCell.h"
#import "FindDesignerDetailVC.h"
@interface FindDesignerVC ()<MenuChooseDelegate,FindCesignerDelegate,UITextFieldDelegate>
{
    MenuChooseVC *topView;
    
    NSMutableArray *typeArr;
    NSMutableArray *typeStringArr;
    
    
    NSString *cityId;
    NSString *levelId;
    NSString *jyId;
    NSString *zwId;
    NSString *sxId;

    
    
    
    
    
}
@end

@implementation FindDesignerVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    typeArr =[[NSMutableArray alloc]init];
    cityId = @"";
    levelId = @"";
    jyId = @"";
    zwId = @"";
    sxId = @"";
   
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
    [searchTextField setPlaceholder:@"请输入设计师"];
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
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];
    
    NSArray *btnArr =@[@"区域",@"等级",@"经验",@"职位",@"排序"];
    topView =[[MenuChooseVC alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, 85*Width) buttonArr:btnArr];
    topView.backgroundColor =[UIColor redColor];
    topView.delegate =self;
    topView.level = 2;

    [self.view addSubview:topView];
    UIView *xianV =[[UIView alloc]initWithFrame:CGRectMake(0*Width,0*Width,CXCWidth,1.5*Width)];
    xianV.backgroundColor =BGColor;
    [topView addSubview:xianV];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,Frame_NavAndStatus+85*Width+20*Width, CXCWidth, CXCHeight-20-85*Width)];
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
    [self performSelector:@selector(getInfoList)];
    [self getType];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}
- (void)getType
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-get_designer_cates.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        NSLog(@"%@",dict);
        //type列表
        NSMutableArray  *cityArr =[[NSMutableArray alloc]init];
        NSMutableArray  *levelArr =[[NSMutableArray alloc]init];
        NSMutableArray  *jingyanArr =[[NSMutableArray alloc]init];
        NSMutableArray  *zhiweiArr =[[NSMutableArray alloc]init];
        NSMutableArray  *shunxuArr =[[NSMutableArray alloc]init];
        cityArr = [dict objectForKey:@"area_list"];
        levelArr=[dict objectForKey:@"group_list"];
        jingyanArr=[[dict objectForKey:@"jy_list"] objectForKey:@"values"];
        zhiweiArr=[[dict objectForKey:@"zw_list"] objectForKey:@"values"];
        shunxuArr=[dict objectForKey:@"order_list"];
        NSMutableArray  *cityArry =[[NSMutableArray alloc]init];
        NSMutableArray  *levelArry =[[NSMutableArray alloc]init];
        NSMutableArray  *jingyanArry =[[NSMutableArray alloc]init];
        NSMutableArray  *zhiweiArry =[[NSMutableArray alloc]init];
        NSMutableArray  *shunxuArry =[[NSMutableArray alloc]init];
        
        
        NSMutableDictionary  *dictionary1 =[[NSMutableDictionary alloc]init];
        [dictionary1 setValue:[NSString stringWithFormat:@"%@",@"不限"] forKey:@"name"];
        [dictionary1 setValue:[NSString stringWithFormat:@"%@",@""] forKey:@"zipcode"];
        [cityArry addObject:dictionary1];
        for (NSDictionary *dicTwo in cityArr) {
            NSMutableDictionary *dictionaryTwo  =[[NSMutableDictionary alloc]init];//新的字典
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"area_name"]] forKey:@"name"];
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"city_id"]] forKey:@"zipcode"];
            [cityArry addObject:dictionaryTwo];
            
        }
        [typeArr addObject:cityArry];
        
        

        [levelArry addObject:dictionary1];
        for (NSDictionary *dicTwo in levelArr) {
            NSMutableDictionary *dictionaryTwo  =[[NSMutableDictionary alloc]init];//新的字典
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"group_name"]] forKey:@"name"];
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"group_id"]] forKey:@"zipcode"];
            [levelArry addObject:dictionaryTwo];
            
        }
        [typeArr addObject:levelArry];
        
        
        [jingyanArry addObject:dictionary1];
        for (NSDictionary *dicTwo in jingyanArr) {
            NSMutableDictionary *dictionaryTwo  =[[NSMutableDictionary alloc]init];//新的字典
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"title"]] forKey:@"name"];
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"attr_value_id"]] forKey:@"zipcode"];
            [jingyanArry addObject:dictionaryTwo];
            
        }
        [typeArr addObject:jingyanArry];
     
        
        
        [zhiweiArry addObject:dictionary1];
        for (NSDictionary *dicTwo in zhiweiArr) {
            NSMutableDictionary *dictionaryTwo  =[[NSMutableDictionary alloc]init];//新的字典
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"title"]] forKey:@"name"];
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"attr_value_id"]] forKey:@"zipcode"];
            [zhiweiArry addObject:dictionaryTwo];
        }
        [typeArr addObject:zhiweiArry];
        
        
        [shunxuArry addObject:dictionary1];
        for (NSDictionary *dicTwo in shunxuArr) {
            NSMutableDictionary *dictionaryTwo  =[[NSMutableDictionary alloc]init];//新的字典
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"title"]] forKey:@"name"];
            [dictionaryTwo setValue:[NSString stringWithFormat:@"%@",[dicTwo objectForKey:@"title"]] forKey:@"zipcode"];
            [shunxuArry addObject:dictionaryTwo];
        }
        [typeArr addObject:shunxuArry];
   
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)btnClickBtn:(UIButton *)cell
{
    UITextField *textF =[self.view viewWithTag:30];
    [textF resignFirstResponder];
    
    // cell.tag -230
    topView.addressArr =typeArr[cell.tag -230] ;
    topView.typeString =@"area_list";
    topView.level = 1;
    [topView.oneLinkageDropMenu dismiss];
    
}
-(void)chooseBtnReturn:(UIButton *)btn withStringId:(NSString *)stringId
{
    if (btn.tag==230) {
        cityId =stringId;
    }else if (btn.tag==231) {
        levelId =stringId;
    }else if (btn.tag==232) {
        jyId =stringId;
    }else if (btn.tag==233) {
        zwId =stringId;
    }else if (btn.tag==234) {
        sxId =stringId;
    }
    NSLog(@"cityId=%@levelId=%@jyId=%@zwId=%@sxId=%@",cityId,levelId,jyId,zwId,sxId);
    //刷新
    currentPage=1;
    
    [self performSelector:@selector(getInfoList)];
}
- (void)changeStatuBtnOut:(UIButton *)btn
{
    
    
}
- (void)withDrawlsBtnAction
{
    [self getInfoList];
    
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
    return 360*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    FindDesignerCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FindDesignerCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.delegate =self;
    NSDictionary *dict = [infoArray objectAtIndex:row];
    [cell setDic:dict];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindDesignerDetailVC *find =[[FindDesignerDetailVC alloc]init];
    find.sjsUserId=[NSString stringWithFormat:@"%@",[infoArray[indexPath.row] objectForKey:@"uid"]];
    [self.navigationController pushViewController:find animated:YES];
}
-(void)btnClick:(UITableViewCell *)cell andBtnActionTag:(NSInteger)tag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    NSString* uid  = [NSString stringWithFormat:@"%@",[infoArray[index.row] objectForKey:@"uid"]];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"uid":uid,
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-yuyue.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:@"预约成功" ToView:self.view];
        }
        
    } fail:^(NSError *error) {
        
    }];



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
    UITextField *textF =[self.view viewWithTag:30];
    [textF resignFirstResponder];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"page":[NSString stringWithFormat:@"%ld",(long)currentPage],
                          @"area_id":[NSString stringWithFormat:@"%@",cityId],
                          @"group_id":[NSString stringWithFormat:@"%@",levelId],
                          @"jy":[NSString stringWithFormat:@"%@",jyId],//经验
                          @"xw":[NSString stringWithFormat:@"%@",zwId],//职位
                          @"order":[NSString stringWithFormat:@"%@",sxId],//排序
                          @"keywords":[NSString stringWithFormat:@"%@",textF.text],
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-items.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            NSMutableArray *array =[[NSMutableArray alloc]init];
            array=[[dict objectForKey:@"data"] objectForKey:@"items"];
           
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
            [infoArray addObjectsFromArray:array];

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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self getInfoList];
    [textField resignFirstResponder];
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
