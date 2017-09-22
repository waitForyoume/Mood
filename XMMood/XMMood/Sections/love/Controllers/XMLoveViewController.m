//
//  XMLoveViewController.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMLoveViewController.h"
#import "XMMoodCell.h"
#import "XMLoveCell.h"

@interface XMLoveViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *loveTableView;
@property (nonatomic, strong) NSMutableArray<XMLoveModel *> *loveArray;

@end

@implementation XMLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"收藏";
    [self loveTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.loveArray = [XMFMDBManager xl_resourceArray];
    
    [self.loveTableView reloadData];
}

// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLoveCell *loveCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMLoveCell class]) forIndexPath:indexPath];
    
    XMLoveModel *loveModel = self.loveArray[indexPath.row];
    loveCell.model = loveModel;
    
    return loveCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMLoveModel *model = (XMLoveModel *)self.loveArray[indexPath.row];
    
    return [XMLoveCell xl_cellWithHeight:model];
}

// MARK: - Lazy
- (UITableView *)loveTableView {
    if (!_loveTableView) {
        self.loveTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _loveTableView.delegate = self;
        _loveTableView.dataSource = self;
        _loveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_loveTableView registerClass:[XMLoveCell class] forCellReuseIdentifier:NSStringFromClass([XMLoveCell class])];
        
        [self.view addSubview:_loveTableView];
    }
    return _loveTableView;
}

- (NSMutableArray<XMLoveModel *> *)loveArray {
    if (!_loveArray) {
        self.loveArray = [NSMutableArray array];
    }
    return _loveArray;
}

@end
