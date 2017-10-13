//
//  XMNavbarView.h
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavigationBarAction)();

@interface XMNavbarView : UIView

@property (nonatomic, strong) NSString *rightImageName;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) NavigationBarAction rightAction;

@end
