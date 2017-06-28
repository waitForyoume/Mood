//
//  XMLoveViewController.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMLoveViewController.h"

@interface XMLoveViewController ()

@end

@implementation XMLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"收藏";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

@end
