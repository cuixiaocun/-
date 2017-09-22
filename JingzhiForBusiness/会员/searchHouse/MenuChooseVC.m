//
//  MenuChooseVC.m
//  家装
//
//  Created by Admin on 2017/9/9.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MenuChooseVC.h"
@implementation MenuChooseVC

- (id)initWithFrame:(CGRect)frame buttonArr:(NSArray *)btnArr{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUPwithButtonArr:btnArr];
    }
    
    return self;
    
    
}

-(void)setUPwithButtonArr:(NSArray *)btnarr{
    // 创建标签容器
    sdTagsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, 85*Width)];
    [self addSubview:sdTagsView];
    sdTagsView.backgroundColor =[UIColor whiteColor];
    sdTagsView.showsVerticalScrollIndicator = FALSE;
    sdTagsView.showsHorizontalScrollIndicator = FALSE;
    
    NSArray *btnArr =[[NSArray alloc]init];
    btnArr=btnarr;
    allArr =btnarr;
    for (int i=0; i<btnArr.count; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (btnarr.count<4) {
            statuBtn.frame = CGRectMake(CXCWidth/btnarr.count*i, 0,CXCWidth/btnarr.count-2*Width ,85*Width);

        }else if (btnarr.count>4)
        {
            statuBtn.frame = CGRectMake(CXCWidth/4*i, 0,CXCWidth/4-2*Width ,85*Width);
            [sdTagsView setContentSize:CGSizeMake(CXCWidth/4*btnarr.count, 85*Width)];
        }
        [statuBtn addTarget:self action:@selector(changeStatuBtnOut:) forControlEvents:UIControlEventTouchUpInside];
        [sdTagsView addSubview:statuBtn];
        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
        [statuBtn setImage:[UIImage imageNamed:@"sf_icon_down"]forState:UIControlStateNormal];
        
        statuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//juzhong对齐
        [statuBtn setImageEdgeInsets:UIEdgeInsetsMake(0, statuBtn.titleLabel.bounds.size.width, 0, -statuBtn.titleLabel.bounds.size.width)];
        statuBtn.tag =230+i;
        
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [sdTagsView addSubview:xian];
    xian.frame =CGRectMake(0,83*Width, CXCWidth, 2*Width);

}

- (void)changeStatuBtnOut:(UIButton *)btn
{
    for (int i=0; i<10; i++) {
        UIButton *normalBtn =[self viewWithTag:230+i];
        [normalBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [normalBtn setImage:[UIImage imageNamed:@"sf_icon_down"]forState:UIControlStateNormal];
    }
    
    [btn setImage:[UIImage imageNamed:@"sf_icon_up_pre"]forState:UIControlStateNormal];
    [btn setTitleColor:NavColor forState:UIControlStateNormal];

    [self.oneLinkageDropMenu removeFromSuperview];
    [self.delegate btnClickBtn:btn];
    currTag =btn.tag;
    NSLog(@"currTag = %ld",(long)currTag);
    self.oneLinkageDropMenu = [[DropMenuView alloc] init];
    self.oneLinkageDropMenu.delegate = self;
    self.oneLinkageDropMenu.typeString =self.typeString;
    [self.oneLinkageDropMenu creatDropView:self withShowTableNum:_level withData:self.addressArr];


}
-(NSArray *)addressArr{
    
    if (_addressArr == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil]];
        _addressArr = [dic objectForKey:@"address"];
        NSLog(@"address=%@",_addressArr);
    }
    return _addressArr;
}


-(void)dropMenuView:(DropMenuView *)view didSelectName:(NSString *)str
{
    UIButton *btn =[self viewWithTag:currTag];
    
    [btn setTitleColor:TextGrayColor forState:UIControlStateNormal];
    NSLog(@"currTag = %ld=======%@",(long)currTag,str);
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"sf_icon_down"]forState:UIControlStateNormal];

}
-(void)dissMissLoad
{
    UIButton *btn =[self viewWithTag:currTag];
    [btn setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"sf_icon_down"]forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
