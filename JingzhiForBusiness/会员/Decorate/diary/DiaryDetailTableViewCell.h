//
//  DiaryDetailTableViewCell.h
//  家装
//
//  Created by Admin on 2017/9/13.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLLabel/MLLabel.h>
#import <MLLabel/MLLinkLabel.h>
#import <MLLabel/NSString+MLExpression.h>
#import <MLLabel/NSAttributedString+MLExpression.h>
#import "WBImageView.h"

#import "DiaryDetailTableViewCell.h"
@class DiaryDetailTableViewCell;
@protocol DiaryDetailCellDelegate <NSObject>
- (void)webViewDidLoad:(DiaryDetailTableViewCell *)cell height:(CGFloat)height;
@end

@interface DiaryDetailTableViewCell : UITableViewCell<DiaryDetailCellDelegate,UIWebViewDelegate>
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, strong) MLLinkLabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (weak, nonatomic) id<DiaryDetailCellDelegate>delegate;

@property (nonatomic, strong) WBImageView *webImage;
@property(nonatomic,retain)NSDictionary *dic;

@end

