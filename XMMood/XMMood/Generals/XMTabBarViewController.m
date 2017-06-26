//
//  XMTabBarViewController.m
//  XMMood
//
//  Created by panda on 17/6/26.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMTabBarViewController.h"
#import "XMMoodViewController.h"

@interface XMTabBarViewController ()

@end

@implementation XMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMMoodViewController *moodView = [[XMMoodViewController alloc] init];
    UINavigationController *moodNA = [[UINavigationController alloc] initWithRootViewController:moodView];
    
    self.viewControllers = @[moodNA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

@end
