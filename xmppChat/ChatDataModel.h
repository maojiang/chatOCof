//
//  ChatDataModel.h
//  xmppChat
//
//  Created by 邓茂江 on 16/9/11.
//  Copyright © 2016年 maojiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ChatDataModel : NSObject
@property(nonatomic,copy)NSString *chatTextString;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,strong)UIImage *image;

@end
