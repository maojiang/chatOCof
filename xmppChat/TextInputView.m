//
//  TextInputView.m
//  xmppChat
//
//  Created by 邓茂江 on 16/9/11.
//  Copyright © 2016年 maojiang. All rights reserved.
//

#import "TextInputView.h"

@implementation TextInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.willTextField=[[UITextField alloc]initWithFrame:CGRectMake(5, 0, frame.size.width-130, frame.size.height)];
        self.willTextField.borderStyle=UITextBorderStyleRoundedRect;
        self.willTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [self addSubview:self.willTextField];
        //发送按钮设置
        self.senderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.senderButton.frame = CGRectMake(frame.size.width - 80, 0, 50, frame.size.height);
        [self.senderButton setTitle:@"发送" forState:UIControlStateNormal];
        [self.senderButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.senderButton.layer.borderWidth = 1.0f;
        self.senderButton.layer.borderColor = [UIColor grayColor].CGColor;
        self.senderButton.layer.cornerRadius = 8;
        [self addSubview:self.senderButton];
       //功能按钮
        self.addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        self.addButton.frame=CGRectMake(frame.size.width-125,0,30,frame.size.height);
        
        [self addSubview:self.addButton];
        
        
        self.cameraButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.cameraButton.frame=CGRectMake(5,50,40,30);
        [self.cameraButton setBackgroundImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
        self.cameraButton.layer.borderWidth=1.0f;
        self.cameraButton.layer.borderColor=[UIColor grayColor].CGColor;
        [self addSubview:self.cameraButton];
        self.photoButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.photoButton.frame=CGRectMake(50,50,40,30);
        [self.photoButton setBackgroundImage:[UIImage imageNamed:@"photoBack"] forState:UIControlStateNormal];
        self.photoButton.layer.borderWidth=1.0f;
        self.photoButton.layer.borderColor=[UIColor grayColor].CGColor;
        [self addSubview:self.photoButton];

        
    }
    return self;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
