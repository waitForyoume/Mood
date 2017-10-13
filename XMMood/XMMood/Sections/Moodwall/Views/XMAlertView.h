//
//  XMAlertView.h
//  XMMood
//
//  Created by panda on 17/10/13.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMAlertView;
@protocol XMAlertViewDelegate <NSObject>

- (void)xlAlertView:(XMAlertView *)alertView;

@end

@interface XMAlertView : UIView

@property (nonatomic, weak) id<XMAlertViewDelegate> delegate;

- (id)initWithMessage:(NSString *)message name:(NSString *)name delegate:(id)delegate;
- (void)xl_show;
- (void)xl_dismiss;

@end
