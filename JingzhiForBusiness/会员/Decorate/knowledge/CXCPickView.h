//
//  CXCPickView.h
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXCPickerViewDelegate <NSObject>
//-(void)tureBtnAction;
//-(void)cancelBtnActin;
-(void)tureBtnAction:(NSString *)componentstring forRow:(NSString *)rowString;
-(void)cancelBtnAction:(NSString *)componentstring forRow:(NSString *)rowString;
@end

@interface CXCPickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{    NSInteger indx;
    
}
@property(nonatomic,strong) UIView* blackBgView;//输入框背景透明黑
@property(strong, nonatomic) UIPickerView*myPickerView;
@property(strong, nonatomic) UIButton*tureBtn;
@property(strong, nonatomic) UIButton*cancleBtn;
@property(nonatomic,strong)NSArray*dataArray;

@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *nameId;


- (id)initWithFrame:(CGRect)frame withArr:(NSArray*)arr;
@property(assign,nonatomic)id<CXCPickerViewDelegate>delegate;

@end
