//
//  XMSettingViewController.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSettingViewController.h"
#import "XMSettingCell.h"
#import "XMSetFontViewController.h"

@interface XMSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTableView;

@end

@implementation XMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"设置";
    
    [self settingTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.settingTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMSettingCell class]) forIndexPath:indexPath];
    
    cell.leftL.text = @"修改字体大小";
    
    if (kManager.xLsize == 13.0f) {
        cell.rightL.text = @"小号";
    }
    else if (kManager.xLsize == 16.0f) {
        cell.rightL.text = @"中号";
    }
    else if (kManager.xLsize == 19.0f) {
        cell.rightL.text = @"大号";
    }
    else if (kManager.xLsize == 20.0f) {
        cell.rightL.text = @"特大号";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        XMSetFontViewController *setFontView = [[XMSetFontViewController alloc] init];
        [self.navigationController pushViewController:setFontView animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableView *)settingTableView {
    if (!_settingTableView) {
        self.settingTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.tableFooterView = [UIView new];
        _settingTableView.rowHeight = 50.0f;
        _settingTableView.backgroundColor = kCOLOR;
        
        [_settingTableView registerClass:[XMSettingCell class] forCellReuseIdentifier:NSStringFromClass([XMSettingCell class])];
        
        [self.view addSubview:_settingTableView];
    }
    return _settingTableView;
}

@end
