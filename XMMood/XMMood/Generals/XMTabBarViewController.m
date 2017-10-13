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
#import "XMMineViewController.h"
#import "XMMoodwallViewController.h"


@interface XMTabBarViewController ()

@end

@implementation XMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMMoodViewController *moodView = [[XMMoodViewController alloc] init];
    UINavigationController *moodNA = [[UINavigationController alloc] initWithRootViewController:moodView];
    moodNA.tabBarItem.image = [UIImage imageNamed:@"normal_1_select"];
    moodNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"normal_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    XMMoodwallViewController *moodwallView = [[XMMoodwallViewController alloc] init];
    UINavigationController *moodwallNA = [[UINavigationController alloc] initWithRootViewController:moodwallView];
    moodwallNA.tabBarItem.image = [UIImage imageNamed:@"moodwall"];
    moodwallNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"moodwall_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    XMMineViewController *mineView = [[XMMineViewController alloc] init];
    UINavigationController *mineNA = [[UINavigationController alloc] initWithRootViewController:mineView];
    mineNA.tabBarItem.image = [UIImage imageNamed:@"personal_3"];
    mineNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"personal_3_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[moodNA, moodwallNA, mineNA];
    
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
