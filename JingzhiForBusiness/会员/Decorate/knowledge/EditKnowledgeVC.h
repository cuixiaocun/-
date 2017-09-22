//
//  EditKnowledgeVC.h
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPickView.h"

@interface EditKnowledgeVC :  UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZHPickViewDelegate>
@property(nonatomic,retain)NSMutableArray *picUrlArr;
@property(nonatomic,retain)NSMutableArray *picIdArr;
@property(nonatomic,retain)NSMutableArray *picArr;

@property(nonatomic,strong)ZHPickView *pickview;

@property (nonatomic,strong) UITextField *titleTextField;//标题
@property (nonatomic,strong) UILabel *stageBtn;//活动地点
@property (nonatomic,strong) UITextView *contentTextView;//活动内容
@property (nonatomic,strong) NSMutableArray *uploadImageVArray;//上传图片数组

@end
