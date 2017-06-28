//
//  XMManager.h
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kManager [XMManager xl_manager]

@interface XMManager : NSObject

@property (nonatomic, assign) CGFloat xLsize; // 字体大小

+ (XMManager *)xl_manager;

@end
