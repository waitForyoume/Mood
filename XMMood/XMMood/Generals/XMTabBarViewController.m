//
//  XMTabBarViewController.m
//  XMMood
//
//  Created by panda on 17/6/26.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMTabBarViewController.h"
#import "XMMoodViewController.h"
#import "XMLoveViewController.h"
#import "XMSettingViewController.h"

@interface XMTabBarViewController ()

@end

@implementation XMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMMoodViewController *moodView = [[XMMoodViewController alloc] init];
    UINavigationController *moodNA = [[UINavigationController alloc] initWithRootViewController:moodView];
    moodNA.tabBarItem.image = [UIImage imageNamed:@"normal_1_select"];
    moodNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"normal_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    XMLoveViewController *loveView = [[XMLoveViewController alloc] init];
    UINavigationController *loveNA = [[UINavigationController alloc] initWithRootViewController:loveView];
    loveNA.tabBarItem.image = [UIImage imageNamed:@"normal_2_select"];
    loveNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"normal_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    XMSettingViewController *settingView = [[XMSettingViewController alloc] init];
    UINavigationController *settingNA = [[UINavigationController alloc] initWithRootViewController:settingView];
    settingNA.tabBarItem.image = [UIImage imageNamed:@"normal_3_select"];
    settingNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"normal_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[moodNA, loveNA, settingNA];
    
    [UINavigationBar appearance].tintColor = kCOLOR_RGBA(16, 16, 16, 1);
    [UINavigationBar appearance].titleTextAttributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSFontAttributeName, [UIFont systemFontOfSize:17.5f], NSForegroundColorAttributeName, kCOLOR_RGBA(16, 16, 16, 1), nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

@end
