//
//  XMMoodViewController.m
//  XMMood
//
//  Created by panda on 17/6/26.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMMoodViewController.h"
#import "XMMoodCell.h"
#import "XMMoodModel.h"

@interface XMMoodViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    int _page;
    int _total;
}

@property (nonatomic, strong) UITableView *moodTableView;
@property (nonatomic, strong) NSMutableArray<XMMoodModel *> *resourceArray;

@end

@implementation XMMoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 标题
    self.navigationItem.title = @"心情";
    _page = 1;
    _total = 100;
    
    [self moodTableView];
    [self xl_requestWithSource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kChangeTextFont:) name:@"kXMChangeTextFont" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)kChangeTextFont:(NSNotification *)noti {
    
    NSDictionary *dic = noti.object;
    kManager.xLsize = [dic[@"font"] floatValue];
    [self.moodTableView reloadData];
}

// MARK: - 网络请求
- (void)xl_requestWithSource {
    NSString *url = [NSString stringWithFormat:kURL, _page];
    
    [kHTTPManager xl_getWithURL:url params:nil success:^(id response) {

        [self xl_sourceWithAnalysis:response];
    } failure:^(NSError *error) {
        
        NSLog(@"错误信息 : %@", error);
        
        if ([self.moodTableView.mj_footer isRefreshing]) {
            [self.moodTableView.mj_footer endRefreshing];
        }
    }];
}

- (void)xl_sourceWithAnalysis:(id)response {
    
    if (![response[@"msg"] isEqualToString:@"OK"]) {
        
        return;
    }
    
    for (NSDictionary *dic in (NSArray *)response[@"data"]) {
        
        XMMoodModel *moodModel = [XMMoodModel moodModelWithDictionary:dic];
        [self.resourceArray addObject:moodModel];
    }
    
    // 刷新数据
    [self.moodTableView reloadData];
    
    if ([self.moodTableView.mj_footer isRefreshing]) {
        [self.moodTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMMoodCell *moodCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMMoodCell class]) forIndexPath:indexPath];

    XMMoodModel *moodModel = self.resourceArray[indexPath.row];
    moodCell.model = moodModel;
    
    moodCell.isSelected = ^(XMMoodCell *cell) {
        
        moodModel.isSelected = cell.collect.selected;
        [self.moodTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        
        
    };
    
    return moodCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMMoodModel *model = (XMMoodModel *)self.resourceArray[indexPath.row];

    return [XMMoodCell xl_cellWithHeight:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableView *)moodTableView {
    if (!_moodTableView) {
        self.moodTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _moodTableView.delegate = self;
        _moodTableView.dataSource = self;
        _moodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_moodTableView registerClass:[XMMoodCell class] forCellReuseIdentifier:NSStringFromClass([XMMoodCell class])];
        
        // 下拉加载
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moodViewLoadMoreData)];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载更多数据" forState:MJRefreshStatePulling];
        
        _moodTableView.mj_footer = footer;
        
        [self.view addSubview:_moodTableView];
    }
    return _moodTableView;
}

- (NSMutableArray *)resourceArray {
    if (!_resourceArray) {
        self.resourceArray = [NSMutableArray array];
    }
    return _resourceArray;
}

// MARK: - 加载更多数据
- (void)moodViewLoadMoreData {
    _page++;
    if (_page <= _total) {
        
        [self xl_requestWithSource];
    }
    else {
        [self.moodTableView.mj_footer endRefreshing];
    }
}

@end
