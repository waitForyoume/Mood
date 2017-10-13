//
//  XMMineViewController.m
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMMineViewController.h"
#import "XMNavbarView.h"
#import "XMSettingViewController.h"
#import "XMLoveViewController.h"

@interface XMMineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) XMNavbarView *navbarView;
@property (nonatomic, strong) UITableView *mineTableView;
@property (nonatomic, strong) NSArray *resourceArray;

@end

@implementation XMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navbarView];
    [self.view addSubview:self.mineTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = kCOLOR_RGBA(16, 16, 16, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.text = self.resourceArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        XMLoveViewController *loveView = [[XMLoveViewController alloc] init];
        [self currentControllerPushNextController:loveView];
    }
    else if (indexPath.section == 1) {
    
        XMSettingViewController *settingView = [[XMSettingViewController alloc] init];
        [self currentControllerPushNextController:settingView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UITableView *)mineTableView {
    if (!_mineTableView) {
        self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNAVIGATIONBAR_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT - kNAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        
        _mineTableView.dataSource = self;
        _mineTableView.delegate = self;
        
        [_mineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _mineTableView;
}

- (XMNavbarView *)navbarView {
    if (!_navbarView) {
        self.navbarView = [[XMNavbarView alloc] init];
        _navbarView.backgroundColor = kCOLOR_RGBA(249, 249, 249, 1);
        _navbarView.title = @"个人中心";
    }
    return _navbarView;
}

- (NSArray *)resourceArray {
    if (!_resourceArray) {
        self.resourceArray = @[@[@"我的收藏"], @[@"设置"]];
    }
    return _resourceArray;
}

@end
