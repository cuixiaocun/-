//
//  KnowledgeCell.h
//  
//
//  Created by Admin on 2017/9/13.
//
//

#import <UIKit/UIKit.h>

@interface KnowledgeCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@property(nonatomic,retain)NSDictionary *dic;
@property (nonatomic,strong)EGOImageView  *topMCImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *seeLabel;
@property (nonatomic,strong) UILabel *talkLabel;

@end
