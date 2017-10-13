//
//  UIViewController+XMViewController.m
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "UIViewController+XMViewController.h"

@implementation UIViewController (XMViewController)

- (void)currentControllerPushNextController:(UIViewController *)controller {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
