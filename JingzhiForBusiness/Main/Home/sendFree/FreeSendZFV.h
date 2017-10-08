//
//  FreeSendZFV.h
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBImgPickerViewController.h"
#import "AKGallery.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ZHPickView.h"
@interface FreeSendZFV : TPKeyboardAvoidingScrollView <UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZHPickViewDelegate>
{
    UITextField *titleTF;
    UILabel *xqlabel;
    UIButton *upLoadBtn;
    UIView *centerView;
    //    UIView *bottomView;
    UIView *topView;
    UIImage *imgToFWD;
    UITextField *numberTF;
    UIButton* isPushBtn;
    //    TPKeyboardAvoidingScrollView *bgScrollView;
    int timeCount;//上传图片请求
    UIView *bottomView;
    
    
}
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)UIViewController *viewController;
@property(nonatomic,retain)NSMutableArray *picUrlArr;
@property(nonatomic,retain)NSMutableArray *picIdArr;
@property(nonatomic,retain)NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray *uploadImageVArray;//上传图片数组
@property (nonatomic,strong) UITextView *contentTextView;//活动内容
- (void)resignFirstResponderAllTextFiled;

- (id)initWithFrame:(CGRect)frame withViewController:(UIViewController *)nav;
@end
