//
//  CXCThreeLabelSheet.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "CXCThreeLabelSheet.h"

@interface CXCThreeLabelSheet ()

@end

@implementation CXCThreeLabelSheet
- (id)initWithFrame:(CGRect)frame with:(NSArray *)arr
{
    
    if ( self= [super initWithFrame:frame]) {
        
        _bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
        _bgview.backgroundColor =[UIColor blackColor];
        _bgview.alpha=0.3;
        [self addSubview:_bgview];
        _leftArr=arr;
        //        _leftArr = @[@"全部",@"短时间",@"长时间",@"其他"];
        if (_leftArr.count*80+50>CXCHeight-64) {
            _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth,CXCHeight-64)];
            _leftTableView.showsVerticalScrollIndicator =
            NO;
        }else
        {
            _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CXCHeight-_leftArr.count*80-50, CXCWidth,_leftArr.count*80+50)];
            
        }
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [self addSubview:_leftTableView];
        _leftTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _leftTableView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}
- (void)createTableView
{
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identy];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy ];
        
        UILabel*label =[[UILabel alloc]initWithFrame:CGRectMake(30*Width, 8, 200*Width, 25)];
        label.text =[_leftArr[indexPath.row] objectAtIndex:0];
        label.textColor =TextGrayColor;
//        label.textAlignment =NSTextAlignmentCenter;
        label.font =[UIFont systemFontOfSize:16];
        [cell addSubview:label];
        UILabel*label2 =[[UILabel alloc]initWithFrame:CGRectMake(230*Width, 8, 400*Width, 25)];
        label2.text =[_leftArr[indexPath.row] objectAtIndex:1];
        label2.textColor =TextGrayColor;
        label2.font =[UIFont systemFontOfSize:14];
//        label2.textAlignment =NSTextAlignmentCenter;
        [cell addSubview:label2];
        

        UILabel*label3 =[[UILabel alloc]initWithFrame:CGRectMake(30*Width, 35, 690*Width,45 )];
        label3.text =[_leftArr[indexPath.row] objectAtIndex:2];
        label3.textColor =TextGrayColor;
        label3.font =[UIFont systemFontOfSize:14];
        [cell addSubview:label3];
        label3.numberOfLines=0;
        
        UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(0, 79, CXCWidth, 1)];
        xian.backgroundColor =BGColor;
        [cell addSubview:xian];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
    }
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nameName = [_leftArr objectAtIndex:indexPath.row];
    [self.delegate btnClickName:nameName[0] andPhone:nameName[1]  andAdress:nameName[2] ];
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 50)];
    view.backgroundColor =BGColor;
    
    UIButton*label2 =[[UIButton alloc]initWithFrame:CGRectMake(0*Width, 10, CXCWidth, 40)];
    label2.backgroundColor =[UIColor whiteColor];
    [label2 setTitle:@"取消" forState:UIControlStateNormal];
    [label2 setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [view addSubview:label2];
    [label2 addTarget:self action:@selector(hideTheTable) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
    
}
-(void)hideTheTable
{
    [self.delegate hiddenCXCActionSheet];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
    
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
