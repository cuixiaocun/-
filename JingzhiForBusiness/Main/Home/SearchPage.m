//
//  SearchPage.m
//  Demo_simple
//
//  Created by Doron on 16/1/11.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "SearchPage.h"
#import "SearchCellTableViewCell.h"

@interface SearchPage ()
{

    UIView *nilBgView;

}

@end

@implementation SearchPage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//左侧当行页面
-(void)leftBtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//右侧个人用户页面
-(void)rightBtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
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
    
    UIView *navBgView =[[UIView alloc]initWithFrame:CGRectMake(120*Width, 20+14*Width,480*Width , 60*Width)];
    [topImageView addSubview:navBgView];
    [navBgView.layer setCornerRadius:4];
    
    navBgView.backgroundColor =[UIColor whiteColor];
    UIImageView *bigShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(36*Width, 15*Width, 30*Width, 30*Width)];
    bigShowImgV.image =[UIImage imageNamed:@"viporder_icon_search"];
    [navBgView addSubview:bigShowImgV];
    UITextField *searchTextField = [[UITextField alloc] init];
    [searchTextField setPlaceholder:@"代理编号,微信号,手机号"];
    [searchTextField setDelegate:self];
    searchTextField.tag =30;
    [searchTextField setFont:[UIFont systemFontOfSize:14]];
    [searchTextField setTextColor:[UIColor blackColor]];
    [searchTextField setFrame:CGRectMake(bigShowImgV.right+12*Width, 0,400*Width,60*Width)];
    [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [navBgView addSubview:searchTextField];
    
    
    //搜索按钮
    UIButton *  searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    searchBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:searchBtn];
    
    
    
    nilBgView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, CXCHeight-64)];
    nilBgView.backgroundColor =BGColor;
    [self.view addSubview:nilBgView];
    
    UIImageView *nilImgV =[[UIImageView alloc]initWithFrame:CGRectMake(200*Width, CXCHeight*0.25, 350*Width,CXCHeight*0.2 )];
    nilImgV.image =[UIImage imageNamed:@"daili_icon_search_empty"];
    [nilBgView addSubview:nilImgV];
    
    UILabel *nilLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, nilImgV.bottom, CXCWidth, 120*Width)];
    nilLabel.textColor =[UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    nilLabel.textAlignment =NSTextAlignmentCenter;
    nilLabel.text =@"暂无搜索记录";
    nilLabel.font =[UIFont systemFontOfSize:15];
    [nilBgView addSubview:nilLabel];
    nilBgView.hidden = YES;
    
    
    
    //添加tableview
    [self.tableView setFrame:CGRectMake(0, 64, CXCWidth, CXCHeight-64)];
    [self.tableView setHidden:YES];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
//    //添加tableview
//    [self.tableView setFrame:CGRectMake(0, 44+Frame_Y+35+2, 320, UI_SCREEN_HEIGHT-44-35-20)];
//    [self.tableView setBackgroundColor:[UIColor clearColor]];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
    // 下拉刷新
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    
    // 上拉加载
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    
    infoArray = [[NSMutableArray alloc] init];
    currentPage=1;
    
//    [self getInfoList];
    
    //提示文字
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(30*Width, 20+44+15, 690*Width, 20)];
    [navTitle setText:@"最近搜索"];
    [navTitle setTag:28];
    [navTitle setTextAlignment:NSTextAlignmentLeft];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont systemFontOfSize:16]];
    [navTitle setTextColor:[UIColor colorWithWhite:0.6 alpha:1]];
    [self.view addSubview:navTitle];
    
    
    if (![PublicMethod getArrData:@"zhangyue_searchJiLu"]) {
        NSMutableArray *array =[[NSMutableArray alloc]init];
        [PublicMethod saveArrData:array withKey:@"zhangyue_searchJiLu"];
    }
    
    
    [self refreshWeiKeView];
    
    
}


-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//搜索
- (void)withDrawlsBtnAction
{    UITextField *textField =(UITextField *)[self.view viewWithTag:30];

    if (!IsNilString(textField.text)) {
        
    
       for (int i=0;i<10; i++) {
        [[self.view viewWithTag:i+1] removeFromSuperview];
        [[self.view viewWithTag:i+50] removeFromSuperview];
    }
    NSMutableArray *array =[NSMutableArray arrayWithArray:[PublicMethod getArrData:@"zhangyue_searchJiLu"]];

    if ([array containsObject:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
        [array removeObject:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    [array insertObject:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] atIndex:0];
    
    [PublicMethod saveArrData:array withKey:@"zhangyue_searchJiLu"];
    
    UILabel *label =(UILabel *)[self.view viewWithTag:28];
    [label setText:@""];
    [self.tableView setHidden:NO];
    currentPage =1;
    
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    [textField resignFirstResponder];
        }else
            
        {
            [MBProgressHUD showWarn:@"输入框不能为空" ToView:self.view];
            return;
        }
}




-(void)searchWeiKe:(UIButton *)btn{
    UITextField *textfield =(UITextField *)[self.view viewWithTag:30];
    [textfield resignFirstResponder];
    if (btn.tag!=29) {
        textfield.text=btn.titleLabel.text;
    }
    NSString *strTel=[NSString stringWithFormat:@"%@",textfield.text];
    strTel=[strTel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([strTel isEqualToString:@""] ||[textfield.text length]==0) {
        if ([self.view viewWithTag:200]) {
            [[self.view viewWithTag:200] removeFromSuperview];
        }
        
        UILabel *label =(UILabel *)[self.view viewWithTag:28];
        [label setText:@"最近搜索"];
        
        return;
    }
    
    
    NSMutableArray *array =[NSMutableArray arrayWithArray:[PublicMethod getArrData:@"zhangyue_searchJiLu"]];
    
    for (int i=0; i<array.count; i++) {
        [[self.view viewWithTag:i+1] removeFromSuperview];
    }
    
    
    if ([array containsObject:[textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
        [array removeObject:[textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    [array insertObject:[textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] atIndex:0];
    
    [PublicMethod saveArrData:array withKey:@"zhangyue_searchJiLu"];
    
    
    [self refreshWeiKeView];
    for (int i=0;i<10; i++) {
        [[self.view viewWithTag:i+1] removeFromSuperview];
        [[self.view viewWithTag:i+50] removeFromSuperview];
    }
    UILabel *label =(UILabel *)[self.view viewWithTag:28];
    [label setText:@""];
    [self.tableView setHidden:NO];
    currentPage =1;
    
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    
    if ([self.view viewWithTag:200]) {
        [[self.view viewWithTag:200] removeFromSuperview];
    }
    
    
    
    
    
    
}

- (void)searchWeiKeQX:(UIButton *)btn//清除所有记录
{
    
    [PublicMethod saveArrData:nil withKey:@"zhangyue_searchJiLu"];
    
    [PublicMethod saveArrData:nil withKey:@"wantSearch"];
    for (int i=0;i<10; i++) {
        [[self.view viewWithTag:i+1] removeFromSuperview];
        [[self.view viewWithTag:i+50] removeFromSuperview];
    }
    
    
    
}

-(void)refreshWeiKeView{
    [self.tableView setHidden:YES];
    for (int i=0;i<10; i++) {
        [[self.view viewWithTag:i+1] removeFromSuperview];
        [[self.view viewWithTag:i+50] removeFromSuperview];
    }
    UILabel *label =(UILabel *)[self.view viewWithTag:28];
    NSMutableArray *array1 ;
    
    if ([label.text isEqualToString:@"最近搜索"]) {
        array1 =[NSMutableArray arrayWithArray:[PublicMethod getArrData:@"zhangyue_searchJiLu"]];
        
    }else{
        array1 =[NSMutableArray arrayWithArray:[PublicMethod getArrData:@"wantSearch"]];
        
    }
    NSMutableArray *array2 =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<array1.count; i++) {
        if (i<10) {
            [array2 addObject:[array1 objectAtIndex:i]];
        }
    }
    if ([label.text isEqualToString:@"最近搜索"]) {
        
        [PublicMethod saveArrData:array2 withKey:@"zhangyue_searchJiLu"];
    }
    NSMutableArray *array =array2;
    
    //    float totallength=0.0;
    //    float totalheight=0.0;
    for (int i=0; i<array.count; i++) {
        
        UIImageView *logoImg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viporder_icon_search"]];
        [logoImg setTag:50+i];
        [logoImg setFrame:CGRectMake(15,20+90+30*i, 16, 16)];
        [self.view addSubview:logoImg];
        NSString *title =[array objectAtIndex:i];
        CGSize size =[title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:NSLineBreakByWordWrapping];
        
        UIButton *btntype =[UIButton buttonWithType:UIButtonTypeCustom];
        [btntype setFrame:CGRectMake(40, 20+83+30*i, size.width+10, 30)];
        [btntype.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btntype setTag:i+1];
        [btntype setTitleColor:[UIColor colorWithWhite:0.2 alpha:1] forState:UIControlStateNormal];
        [btntype setTitle:title forState:UIControlStateNormal];
        [btntype addTarget:self action:@selector(searchWeiKe:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btntype];
        if (i==array.count-1) {
            UIButton *btntype =[UIButton buttonWithType:UIButtonTypeCustom];
            [btntype setFrame:CGRectMake(0, 20+83+30*i+30, 100, 30)];
            [btntype.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btntype setTag:i+2];
            [btntype setTitleColor:[UIColor colorWithWhite:0.2 alpha:1] forState:UIControlStateNormal];
            [btntype setTitle:@"清除历史记录" forState:UIControlStateNormal];
            [btntype addTarget:self action:@selector(searchWeiKeQX:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btntype];
            
        }
        
    }
    
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Text Field
#pragma mark

//控制textfield输入长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text length]>=50 && range.length!=1)
        return NO;
    else {
        
        
        if ([string isEqualToString:@""]) {
            [PublicMethod removeObjectForKey:@"wantSearch"];
            if (textField.text.length==1) {
                UILabel *label =(UILabel *)[self.view viewWithTag:28];
                [label setText:@"最近搜索"];
                [self refreshWeiKeView];
                return YES;
            }
        }
        NSMutableArray *wantSearch = [[NSMutableArray alloc] init];
        for (NSString *historyStr in [PublicMethod getArrData:@"zhangyue_searchJiLu"]) {
            if (textField.text.length==0) {
                if ([historyStr rangeOfString:string].location==NSNotFound) {
                    
                    
                }else{
                    
                    [wantSearch addObject:historyStr];
                    
                }
                
            }else{
                NSMutableString *newStr = [NSMutableString stringWithFormat:@"%@",textField.text];
                if ([string isEqualToString:@""]) {
                    [newStr replaceCharactersInRange:range withString:string];
                }else{
                    [newStr insertString:string atIndex:range.location];
                }
                if ([historyStr rangeOfString:newStr].location==NSNotFound) {
                    
                    
                }else{
                    
                    [wantSearch addObject:historyStr];
                    
                }
            }
            
        }
        [PublicMethod saveArrData:wantSearch withKey:@"wantSearch"];
        if (wantSearch.count>0) {
            UILabel *label =(UILabel *)[self.view viewWithTag:28];
            [label setText:@"您是不是要搜索"];
            [self refreshWeiKeView];
            
        }else{
            UILabel *label =(UILabel *)[self.view viewWithTag:28];
            [label setText:@"最近搜索"];
            [PublicMethod removeObjectForKey:@"wantSearch"];
            
            [self refreshWeiKeView];
        }
        
        
        
        return YES;
    }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
        [textField resignFirstResponder];
        
        return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    UILabel *label =(UILabel *)[self.view viewWithTag:28];
    [label setText:@"最近搜索"];
    [PublicMethod removeObjectForKey:@"wantSearch"];
    [self refreshWeiKeView];
    return YES;
}

//请求列表数据
-(void)getInfoList{
   
    UITextField *textfield =(UITextField *)[self.view viewWithTag:30];
    
    //当数据为空的时候
    nilBgView.hidden = NO;
    self.tableView.hidden=YES;
    //当数据不为空的时候
    nilBgView.hidden = YES;
    self.tableView.hidden=NO;


}


#pragma mark - Standard TableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return infoArray.count ;
    return 5;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 510*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSInteger row =[indexPath row];
    static NSString *CellIdentifier = @"Cell";
    SearchCellTableViewCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SearchCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
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
    [self.tableView setFrame:CGRectMake(0,64, CXCWidth, CXCHeight-20)];
    
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




- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *textfield =(UITextField *)[self.view viewWithTag:30];
    [textfield resignFirstResponder];
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
