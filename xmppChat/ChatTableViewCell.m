//
//  ChatTableViewCell.m
//  xmppChat
//
//  Created by 邓茂江 on 16/9/11.
//  Copyright © 2016年 maojiang. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView=[[UIImageView alloc]init];
        self.iconImageView.layer.cornerRadius=21.0f;
        self.iconImageView.layer.borderWidth=1.0f;
        self.iconImageView.clipsToBounds=YES;
        [self.contentView addSubview:self.iconImageView];
        
        self.backgroundImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:self.backgroundImageView];
        
        self.contentTextLabel=[[UILabel alloc]init];
        self.contentTextLabel.numberOfLines = 0;
        self.contentTextLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:self.contentTextLabel];
        
    }
    
    return self;
}

-(void)refreshCell:(ChatDataModel *)model passBounds:(CGRect)bounds{
    //定200是宽最大，高也是1500是极限了。
    CGRect textFrame=[model.chatTextString boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    if (!model.flag) {
        self.iconImageView.frame=CGRectMake(5,textFrame.size.height-18,42,42);
        //background和label的重合协调没什么技巧，一点点移，调过来
        self.backgroundImageView.frame=CGRectMake(55, 10, textFrame.size.width+40, textFrame.size.height+20);
        //加载图片，忘了加.JPG调了好久。
        self.iconImage=[UIImage imageNamed:@"001.jpg"];
        
        
        self.backgroundImage=[UIImage imageNamed:@"leftBuble"];
        
        
            self.contentTextLabel.text = model.chatTextString;
            self.contentTextLabel.frame = CGRectMake(75, 15, textFrame.size.width, textFrame.size.height);
        
        
    }
    else{
        self.iconImageView.frame=CGRectMake(bounds.size.width-60, textFrame.size.height-20, 42, 42);
        //
        self.backgroundImageView.frame=CGRectMake(bounds.size.width-60-textFrame.size.width-30, 10, textFrame.size.width+35, textFrame.size.height+20);
        
        self.iconImage=[UIImage imageNamed:@"002.jpg"];
        self.backgroundImage=[UIImage imageNamed:@"rightBuble"];
        
        self.contentTextLabel.frame = CGRectMake(bounds.size.width-60-textFrame.size.width-20, 15, textFrame.size.width, textFrame.size.height);
       
            self.contentTextLabel.text = model.chatTextString;
        
       // self.contentTextLabel.text = model.chatTextString;
        
        
    }
    //拉伸图片，是技术重点。
    self.backgroundImage=[self.backgroundImage stretchableImageWithLeftCapWidth:self.backgroundImage.size.width/2 topCapHeight:self.backgroundImage.size.height/2];
    
    self.iconImageView.image=self.iconImage;
    self.backgroundImageView.image=self.backgroundImage;
    
}
-(void)refreshCellWithImage:(ChatDataModel *)model getBounds:(CGRect)bounds{
    //在发送图片时没有用到UIlabel,所以移除。
    [self.contentTextLabel removeFromSuperview];
    if (model.flag) {
        //60的宽度留给头像和边距
        self.iconImageView.frame=CGRectMake(bounds.size.width-60, 60, 42, 42);
        //在发送图像时backgroundImageView是图像的容器，由IOS坐标是从左上角开始的，屏宽-250就是留250的宽给将发送图像加头像限定图像的sie为180，120。
        self.backgroundImageView.frame=CGRectMake(bounds.size.width-250, 10, 180, 120);
        
        self.iconImage=[UIImage imageNamed:@"002.jpg"];
        self.backgroundImageView.image=model.image;
        self.iconImageView.image=self.iconImage;
        
    }
    else{
        self.iconImageView.frame=CGRectMake(5,60,42,42);
        self.backgroundImageView.frame=CGRectMake(60,10,180,120);
        self.iconImage=[UIImage imageNamed:@"001.jpg"];
        self.backgroundImageView.image=model.image;
        self.iconImageView.image=self.iconImage;
    }
    
    
}





@end
