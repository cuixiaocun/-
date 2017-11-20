//
//  CXCPickView.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "CXCPickView.h"
@implementation CXCPickView

- (id)initWithFrame:(CGRect)frame withArr:(NSArray*)arr
{
    NSLog(@"城市---%@",arr);
    if ( self= [super initWithFrame:frame]) {
        _dataArray =[[NSArray alloc]init];
        _bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
        _bgview.backgroundColor =[UIColor blackColor];
        _bgview.alpha=0.3;
        [self addSubview:_bgview];
        _myPickerView =[[UIPickerView alloc ]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
        _myPickerView.delegate=self;
        _myPickerView.backgroundColor =[UIColor whiteColor];
        _myPickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定                                                                                                                           义高度了，一般默认是无法修改其216像素的高度
        _myPickerView.frame =CGRectMake(0, CXCHeight-216, CXCWidth, 216);
        [self addSubview:_myPickerView];
        indx =0;
        UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-216-80*Width, CXCWidth, 80*Width)];
        topView.backgroundColor =[UIColor whiteColor];
        [self addSubview:topView];
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [topView addSubview:xian];
        xian.frame =CGRectMake(0,78.5*Width, CXCWidth, 1.5*Width);
        _dataArray =arr;

        //删除
        UIButton* _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [_deleteBtn.layer setCornerRadius:2];
        [_deleteBtn.layer setMasksToBounds:YES];
        [_deleteBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
        _deleteBtn.tag=131;
        
        [_deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_deleteBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.layer.borderColor =NavColor.CGColor;
        [topView addSubview:_deleteBtn];

        
        //修改
        UIButton* _changeBtn = [[UIButton alloc]init];
        [_changeBtn setBackgroundColor:[UIColor whiteColor]];
        [_changeBtn.layer setCornerRadius:2];
        [_changeBtn.layer setMasksToBounds:YES];
        [_changeBtn setTitleColor:NavColor  forState:UIControlStateNormal];
        [_changeBtn setTitle:@"完成" forState:UIControlStateNormal];
        _changeBtn.tag=130;
        [_changeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:_changeBtn];

        [_deleteBtn setFrame:CGRectMake(0*Width,13.5*Width , 150*Width, 55*Width)];
        [_changeBtn setFrame:CGRectMake(600*Width,13.5*Width , 150*Width, 55*Width)];
        if ([_type isEqualToString:@"cityList"]) {//城市列表
            NSArray *arr =[_dataArray[0] objectForKey:@"city"];
            _name  =[arr[0] objectForKey:@"city_name"];
            _nameId =[arr[0] objectForKey:@"city_id"];
        }else
        {

            _name =[_dataArray[0] objectForKey:@"name"];
            _nameId =[NSString stringWithFormat:@"%@",[_dataArray[0] objectForKey:@"zipcode"]];
        }
      
        isFrist =NO;
        
    }
    return self;
}
- (void)btnAction:(UIButton *)btn
{
    NSLog(@"%@,,,,,,,,,%@",_name,_nameId);
    if (btn.tag==131) {
        [self.delegate cancelBtnAction:_name forRow:_nameId];

    }else
    {
        [self.delegate tureBtnAction:_name forRow:_nameId];
        

    }
    [self removeFromSuperview];
}
//设置UIPickerView的列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}
//设置UIPickerView的hang

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([_type isEqualToString:@"cityList"]) {//城市列表
        if (component==0) {
            return _dataArray.count;
        }else
        {
            NSArray *arr =[[NSArray alloc]init];
            long Index = [self.myPickerView selectedRowInComponent:0];
            arr =[_dataArray[Index] objectForKey:@"city"];
            NSLog(@"省=%@市=%ld",arr,(long)indx);
            
            return arr.count;
        }
        
    }else
    {
        //装修
        if (component==0) {
            return _dataArray.count;
        }else
        {
            long Index = [self.myPickerView selectedRowInComponent:0];

            NSArray *arr =[[NSArray alloc]init];
            arr =[_dataArray[Index] objectForKey:@"detailArr"];
            return arr.count;
            
        }
    }
   
    
}
//设置UIPickerView的行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([_type isEqualToString:@"cityList"]) {//城市列表
        if (component==0) {
            indx=row;
            return [NSString stringWithFormat:@"%@",[_dataArray[row] objectForKey:@"province_name"]];
            
        }else
        {
            if (isFrist==NO) {
                isFrist=YES;
                NSArray *arr =[[NSArray alloc]init];
                arr =[_dataArray[0] objectForKey:@"city"];
                return [NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"city_name"]];
            }else
            {
                long Index = [self.myPickerView selectedRowInComponent:0];
                isFrist=YES;
                NSArray *arr =[[NSArray alloc]init];
                arr =[_dataArray[Index] objectForKey:@"city"];
                NSLog(@"-------%@----%ld------%d",arr,(long)indx,row);
                return [NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"city_name"]];
                
            }
           
            
        }
        
    }else
    {
        
        if (component==0) {
            indx=row;
            return [NSString stringWithFormat:@"%@",[_dataArray[row] objectForKey:@"name"]];
            
        }else
        {
            long Index = [self.myPickerView selectedRowInComponent:0];
            NSArray *arr =[[NSArray alloc]init];
            arr =[_dataArray[Index] objectForKey:@"detailArr"];
            return [NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"name" ] ];
            
        }
        
    }

    
    
}
//5、UIPickerView的点击事件

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([_type isEqualToString:@"cityList"]) {//城市列表
        if (component==0) {
            long Index = [self.myPickerView selectedRowInComponent:0];

            indx =row;
            NSArray *arr =[[NSArray alloc]init];
            
            arr =[_dataArray[Index] objectForKey:@"city"];
            NSLog(@"%@",arr[0]);

            _name =[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"city_name"]];
            _nameId =[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"city_id"]];

            NSLog(@"00000000000000%@",_name);
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated: YES];
            
        }else
        {
            long Index = [self.myPickerView selectedRowInComponent:0];

            NSArray *arr =[[NSArray alloc]init];
            arr =[_dataArray[Index] objectForKey:@"city"];
            _name =[NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"city_name"]];
            NSLog(@"00000000000000%@",_name);
            _nameId =[NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"city_id"]];
        }
        
        NSLog(@"%@,,,,,,,,,%@",_name,_nameId);

    }else
    {
       
        
        if (component==0) {
            long Index = [self.myPickerView selectedRowInComponent:0];

            indx =row;
            _name =[_dataArray[Index]objectForKey:@"name"];
            _nameId =[NSString stringWithFormat:@"%@",[_dataArray[Index] objectForKey:@"zipcode"]];

            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated: YES];
            
        }else
        {
            if (row==0) {
                
            }else
            {
                NSArray *arr =[[NSArray alloc]init];
                long Index = [self.myPickerView selectedRowInComponent:0];

                arr =[_dataArray[Index] objectForKey:@"detailArr"];
                _name =[NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"name" ] ];
                _nameId =[NSString stringWithFormat:@"%@",[arr[row] objectForKey:@"zipcode"]];

                
            }
        }
        
        
        
    }
    
    
    
}

@end
