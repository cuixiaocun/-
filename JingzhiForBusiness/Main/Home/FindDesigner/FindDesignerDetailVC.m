//
//  FindDesignerDetailVC.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FindDesignerDetailVC.h"
#import "FindDesignerOneCell.h"
#import "FindDesignerTwoCell.h"
#import "FindDesignerThreeCell.h"
#import "FindDesignerFourCell.h"
#import "TalkDesignerVC.h"
@interface FindDesignerDetailVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIScrollView *bgScrollView;//
    UIView *topview ;
    NSMutableArray *commentArr;//评论
    NSMutableArray *caseArr;//案例
    NSMutableArray *wzArr;//文章
    NSMutableDictionary *detailDic;
    float indexHeightAll;

}
@property (nonatomic,strong) UICollectionView *mainCMallCollectionView;//按钮视图
@property(nonatomic,strong)UIImageView *phoneImageV;
@property(nonatomic,strong)UILabel *nameLabel;


@end

@implementation FindDesignerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    detailDic =[[NSMutableDictionary alloc]init];
    commentArr =[[NSMutableArray alloc]init];
    caseArr =[[NSMutableArray alloc]init];
    wzArr =[[NSMutableArray alloc]init];
    indexHeightAll =0.0;
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
    [navTitle setText:@"找设计师"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    
    [self getInfor];
    [self getWZ];
    [self getAl];
    [self mainView];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus-49)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    
    topview =[[UIView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 330*Width)];
    topview.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:topview];
    //图片
    _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
    _phoneImageV.backgroundColor =BGColor;
    _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 190*Width, 190*Width);
    [bgScrollView addSubview:_phoneImageV];
    //名称
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_phoneImageV.top, 460*Width, 50*Width)];
    _nameLabel.text = @"王涛";
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.numberOfLines =0;
    _nameLabel.font =[UIFont systemFontOfSize:14];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:_nameLabel];
    NSArray *arr =@[@"关注数:100",@"预约数:909",@"案例:12",@"博文数:12"];
    for(int i=0;i<4;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width+i%2*200*Width,_nameLabel.bottom+i/2*60*Width, 220*Width, 50*Width)];
        label.text = [NSString stringWithFormat:@"%@",arr[i]];
        label.textColor=TextColor;
        label.numberOfLines =0;
        label.tag =4800+i;
        label.font =[UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:label];
    
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [bgScrollView addSubview:xian];
    xian.frame =CGRectMake(0,_phoneImageV.bottom+28.5*Width, CXCWidth, 1.5*Width);
    

    NSArray *arr2 =@[@"综合评价:5.0",@"设计:09",@"服务:12",@"贴心:12"];
    for(int i=0;i<4;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(187.5*i*Width,xian.bottom, 187.5*Width, 90*Width)];
        if (i==0) {
            label.frame =CGRectMake(20*Width, xian.bottom, 200*Width, 90*Width);
        }else
        {
            label.frame =CGRectMake(220*Width+170*Width*(i-1), xian.bottom, 170*Width, 90*Width);

        }
        label.text = [NSString stringWithFormat:@"%@",arr2[i]];
        label.textColor=TextGrayColor;
        label.numberOfLines =0;
        label.tag =1300+i;
        label.font =[UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:label];
        
    }
    

    
    
    //商品详情
    
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(CXCWidth, 100*Width);
    layout.footerReferenceSize = CGSizeMake(CXCWidth, 80*Width);
    
    //3\初始化collextionVIewCell
    _mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topview.bottom, CXCWidth,0*Width) collectionViewLayout:layout];
    [bgScrollView addSubview:_mainCMallCollectionView];
    [_mainCMallCollectionView setBackgroundColor:BGColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCMallCollectionView registerClass:[FindDesignerOneCell class] forCellWithReuseIdentifier:NSStringFromClass([FindDesignerOneCell class])];
    [_mainCMallCollectionView registerClass:[FindDesignerTwoCell class] forCellWithReuseIdentifier:NSStringFromClass([FindDesignerTwoCell class])];
    [_mainCMallCollectionView registerClass:[FindDesignerThreeCell class] forCellWithReuseIdentifier:NSStringFromClass([FindDesignerThreeCell class])];
    [_mainCMallCollectionView registerClass:[FindDesignerFourCell class] forCellWithReuseIdentifier:NSStringFromClass([FindDesignerFourCell class])];

    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [_mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _mainCMallCollectionView.backgroundColor =[UIColor whiteColor];
    
    //设置代理
    _mainCMallCollectionView.delegate = self;
    _mainCMallCollectionView.dataSource = self;
    _mainCMallCollectionView.scrollEnabled = NO;
    [_mainCMallCollectionView reloadData];
    


    //确认提交按钮
    UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartBtn setFrame:CGRectMake(0*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
    [shopCartBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:112/255.0 blue:48/255.0 alpha:1]];
    [shopCartBtn setTitle:@"关注" forState:UIControlStateNormal];
    [shopCartBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [shopCartBtn addTarget:self action:@selector(guanzhuBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCartBtn];
    
    //确认提交按钮
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(375*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
    [buyBtn setBackgroundColor:[UIColor colorWithRed:230/255.00 green:47/255.00 blue:44/255.00 alpha:1]];
    buyBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [buyBtn setTitle:@"委托设计" forState:UIControlStateNormal];
    [buyBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [buyBtn addTarget:self action:@selector(weituoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    


}
- (void)guanzhuBtnAction
{
    NSString* uid  = [NSString stringWithFormat:@"%@",_sjsUserId];

    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"uid":uid,
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-attention.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:@"关注成功" ToView:self.view];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (void)weituoBtnAction
{
    NSString* uid  = [NSString stringWithFormat:@"%@",_sjsUserId];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;

    }if(section==1)
    {
        return caseArr.count;

    }if(section==2)
    {
        return wzArr.count;
    }
    else
    return commentArr.count;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        header.backgroundColor =BGColor;
        UILabel *xianV =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth,80*Width)];
        xianV.backgroundColor =BGColor;
        [header addSubview:xianV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,20*Width,CXCWidth,80*Width)];
        botLabel.font =[UIFont systemFontOfSize:16];
        botLabel.textColor =BlackColor;
        botLabel.backgroundColor =[UIColor whiteColor];
        if (indexPath.section ==0) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    个人简介"];
            [header addSubview:botLabel];

        }else if(indexPath.section ==1) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    案例展示"];
            [header addSubview:botLabel];

        }else if(indexPath.section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    Ta的文章"];
            [header addSubview:botLabel];

        }else
        {
            botLabel.userInteractionEnabled =YES;
            [header addSubview:botLabel];

            botLabel.text =[NSString stringWithFormat:@"%@",@"    Ta的评价"];
            UIButton*   talkBtn = [[UIButton alloc]init];
            [talkBtn setBackgroundColor:NavColor];
            [talkBtn.layer setCornerRadius:2];
            [talkBtn.layer setMasksToBounds:YES];
            talkBtn.frame =CGRectMake(600*Width,30*Width , 130*Width, 60*Width);
            [talkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [talkBtn setTitle:@"评价" forState:UIControlStateNormal];
            talkBtn.tag=130;
            [talkBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [talkBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:talkBtn];

        }
        
        return header;
    }
    //    如果底部视图
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer=[collectionView    dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
//
//        UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
//        addressBtn.tag=440+indexPath.section;
//        [footer addSubview:addressBtn];
//        [addressBtn addTarget:self action:@selector(chooseMore:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *addLabel = [[UILabel alloc] init];
//        [addLabel setText:@"查看全部 >"];
//        addLabel.tag =30;
//        addLabel.textColor =BlackColor;
//        addLabel.textAlignment =NSTextAlignmentCenter;
//        [addLabel setFont:[UIFont systemFontOfSize:14]];
//        [addLabel setFrame:CGRectMake(0*Width,1.5*Width,CXCWidth , 78.5*Width)];
//        addLabel.backgroundColor =[UIColor whiteColor];
//        [addressBtn addSubview:addLabel];
//        [addressBtn setBackgroundColor:[UIColor whiteColor]];
//        UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 0*Width, 690*Width, 1.5*Width)];
//        addressBtn.backgroundColor =BGColor;
//        [addressBtn addSubview:addShowImgV];
//        
        return footer;
//
    }
    return nil;
}
- (void)btnAction:(UIButton *)btn
{
    TalkDesignerVC *talk =[[TalkDesignerVC alloc]init];
    talk.sjsUserId =_sjsUserId;
    [self.navigationController pushViewController:talk animated:YES];

}
- (void)chooseMore:(UIButton *)btn
{


}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexHeightAllindexHeightAllindexHeightAll%f",indexHeightAll);
    if (indexPath.section==0) {
        
     float aHeight=[self heightWithString:[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"about"]] withattributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} withSize:CGSizeMake(680*Width, MAXFLOAT)];
    float bHeight=[self heightWithString:[NSString stringWithFormat:@"设计理念：%@",[detailDic objectForKey:@"slogan"]] withattributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} withSize:CGSizeMake(680*Width, MAXFLOAT)];
        [self heightwithHeight:aHeight+bHeight+300*Width];

        return CGSizeMake(CXCWidth,aHeight+bHeight+300*Width);
    }else if (indexPath.section==1) {
        if (indexPath.row%2==0) {
            [self heightwithHeight:360*Width];

        }

        return CGSizeMake(340*Width,340*Width);
        
    }else if (indexPath.section==2) {
        
        float bHeight=[self heightWithString:[NSString stringWithFormat:@"%@",[wzArr[indexPath.row] objectForKey:@"content"]] withattributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} withSize:CGSizeMake(650*Width, MAXFLOAT)];
        [self heightwithHeight:150*Width+bHeight];

        return CGSizeMake(CXCWidth,150*Width+bHeight);

    }else{
        
        float bHeight=[self heightWithString:[NSString stringWithFormat:@"%@",[commentArr[indexPath.row] objectForKey:@"content"]] withattributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} withSize:CGSizeMake(560*Width, MAXFLOAT)];
        [self heightwithHeight:300*Width+bHeight];

        return CGSizeMake(CXCWidth,300*Width+bHeight);
    }
}
//两个cell之间的间距（同一行的cell的间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0*Width;
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0*Width;
    
    
}

////设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(10*Width, 20*Width,10*Width,20*Width);
        
    }else if (section==1) {
        return UIEdgeInsetsMake(10*Width, 23.33*Width,10*Width,23.33*Width);
        
    }else  {
        return UIEdgeInsetsZero;
        
    }
    
}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FindDesignerOneCell* onecell = (FindDesignerOneCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindDesignerOneCell class]) forIndexPath:indexPath];
        onecell.backgroundColor = [UIColor whiteColor];
        onecell.dic =detailDic;
        NSLog(@"detailDicdetailDicdetailDicdetailDicdetailDic=%@",detailDic);
        
        return onecell;
        
    }else  if (indexPath.section==1) {
        FindDesignerTwoCell*twocell = (FindDesignerTwoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindDesignerTwoCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =caseArr[indexPath.row];
        return twocell;
        
    }else  if (indexPath.section==2) {
        FindDesignerThreeCell*twocell = (FindDesignerThreeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindDesignerThreeCell class]) forIndexPath:indexPath];
        twocell.backgroundColor = [UIColor whiteColor];
        twocell.dic =wzArr[indexPath.row];
        return twocell;
        
    }else {
        
        FindDesignerFourCell*threecell = (FindDesignerFourCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindDesignerFourCell class]) forIndexPath:indexPath];
        threecell.backgroundColor = [UIColor whiteColor];
        threecell.dic =commentArr[indexPath.row];
        return threecell;
        
    }
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
       
    }else if (indexPath.section==1) {
        
    }else if (indexPath.section==2) {
        
    }else if (indexPath.section==3) {
        
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CXCWidth,100*Width);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeZero;
    }
    return CGSizeMake(CXCWidth,0.01*Width);
    
}
- (void)getInfor
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"uid":[NSString stringWithFormat:@"%@",_sjsUserId],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-detail.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            if (![[[dict objectForKey:@"data"] objectForKey:@"comment_list"]isEqual:[NSNull null]]) {
                commentArr  =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"comment_list"]];

            }
            
            detailDic =[[dict objectForKey:@"data"] objectForKey:@"designer"];
           
            NSLog(@"commentArr =%@",commentArr);
            NSLog(@"detailDic =%@",detailDic);

            
            
            NSString *company =[NSString stringWithFormat:@"%@", IsNilString([[[dict objectForKey:@"data"] objectForKey:@"company"] objectForKey:@"name"])?@"":[[[dict objectForKey:@"data"] objectForKey:@"company"] objectForKey:@"name"]];
            NSLog(@"companycompanycompany%@",company);
            [detailDic setObject:company forKey:@"company_name"];
//
            [_phoneImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[detailDic objectForKey:@"face"]]]];
            _nameLabel.text =[detailDic objectForKey:@"uname"];
            UILabel *gzLabel =[self.view viewWithTag:4800];
            gzLabel.text =[NSString stringWithFormat:@"关注数:%@", IsNilString([detailDic  objectForKey:@"attention_num"])?@"":[detailDic objectForKey:@"attention_num"]];
            UILabel *yysLabel =[self.view viewWithTag:4801];
            yysLabel.text =[NSString stringWithFormat:@"预约数:%@", IsNilString([detailDic  objectForKey:@"yuyue_num"])?@"":[detailDic objectForKey:@"yuyue_num"]];

            UILabel *alLabel =[self.view viewWithTag:4802];
            alLabel.text =[NSString stringWithFormat:@"案例:%@", IsNilString([detailDic  objectForKey:@"case_num"])?@"":[detailDic objectForKey:@"case_num"]];

            UILabel *bwLabel =[self.view viewWithTag:4803];
            bwLabel.text =[NSString stringWithFormat:@"博文数:%@", IsNilString([detailDic  objectForKey:@"blog_num"])?@"":[detailDic objectForKey:@"blog_num"]];

            UILabel *zhLabel =[self.view viewWithTag:1300];
            zhLabel.text =[NSString stringWithFormat:@"综合评价:%@", [[detailDic  objectForKey:@"avg_scores"] objectForKey:@"score"]];

            UILabel *sjLabel =[self.view viewWithTag:1301];
            sjLabel.text =[NSString stringWithFormat:@"设计:%@",[[detailDic  objectForKey:@"avg_scores"] objectForKey:@"score1"]];

            UILabel *fwLabel =[self.view viewWithTag:1302];
            fwLabel.text =[NSString stringWithFormat:@"服务:%@", [[detailDic  objectForKey:@"avg_scores"] objectForKey:@"score2"]];
            UILabel *txLabel =[self.view viewWithTag:1303];
            txLabel.text =[NSString stringWithFormat:@"贴心:%@", [[detailDic  objectForKey:@"avg_scores"] objectForKey:@"score3"]];
            indexHeightAll = 0.0;
            [self reloadCollectionViewData];

        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)getWZ{
    NSString* uid  = [NSString stringWithFormat:@"%@",_sjsUserId];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"uid":uid,
                          @"page":@"1"
                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-article.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            if (![[[dict objectForKey:@"data"] objectForKey:@"items"]isEqual:[NSNull null]]) {
                 wzArr =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"items"]];
                NSLog(@"%@",wzArr);
                indexHeightAll = 0.0;
                [self reloadCollectionViewData];


            }
            
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (void)getAl{
    NSString* uid  = [NSString stringWithFormat:@"%@",_sjsUserId];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"uid":uid,
                          @"page":@"1"

                          }];
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?designer-cases.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {

            if (![[[dict objectForKey:@"data"] objectForKey:@"items"]isEqual:[NSNull null]]) {
                caseArr  =[NSMutableArray arrayWithArray:[[dict objectForKey:@"data"] objectForKey:@"items"]];
                
                indexHeightAll = 0.0;
                [self reloadCollectionViewData];
            }
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)reloadCollectionViewData
{
   
    [_mainCMallCollectionView reloadData];
    NSLog(@"最近一次 %f",_mainCMallCollectionView.height);
    NSLog(@"%f",bgScrollView.height);

}
- (float)heightWithString:(NSString *)str withattributes:(NSDictionary*)attributes withSize:(CGSize)size {
    NSString *titleContent =str;
    CGSize titleSize;//通过文本得到高度
    titleSize = [titleContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return titleSize.height;
}

- (float)heightwithHeight:(float)height{

    indexHeightAll =indexHeightAll+height;
    _mainCMallCollectionView.height =indexHeightAll+450*Width;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, indexHeightAll+330*Width+450*Width)];
    return height;
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
