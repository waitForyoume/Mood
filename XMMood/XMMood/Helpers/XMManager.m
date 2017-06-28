//
//  XMManager.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMManager.h"

@implementation XMManager

+ (XMManager *)xl_manager {
    static XMManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMManager alloc] init];
    });
    return manager;
}

@end
