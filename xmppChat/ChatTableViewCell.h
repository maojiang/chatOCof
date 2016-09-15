//
//  ChatTableViewCell.h
//  xmppChat
//
//  Created by 邓茂江 on 16/9/11.
//  Copyright © 2016年 maojiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatDataModel.h"
@interface ChatTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UILabel *contentTextLabel;
@property(nonatomic,strong)UIImage *iconImage;
@property(nonatomic,strong)UIImage *backgroundImage;
-(void)refreshCell:(ChatDataModel *)model passBounds:(CGRect)bounds;
-(void)refreshCellWithImage:(ChatDataModel *)model getBounds:(CGRect)bounds;
@end
