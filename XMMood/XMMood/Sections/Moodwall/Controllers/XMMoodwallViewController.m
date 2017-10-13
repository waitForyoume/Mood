//
//  XMMoodwallViewController.m
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMMoodwallViewController.h"
#import "XMMoodwallModel.h"
#import "XMMoodwallCell.h"
#import "XMAlertView.h"

#define kMoodwallURL @"http://www.wenzizhan.com/AppServiceNew/Feel.asmx/GetList_Page?pageIndex=%d&pageSize=20"

@interface XMMoodwallViewController ()<UITableViewDelegate, UITableViewDataSource, XMAlertViewDelegate>

{
    int _page;
}

@property (nonatomic, strong) UITableView *moodwallTableView;
@property (nonatomic, strong) NSMutableArray<XMMoodwallModel *> *resourceArray;

@end

@implementation XMMoodwallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"心情墙";
    _page = 1;
    
    [self moodwallTableView];
    [self moodwallViewRequestDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMMoodwallCell *moodwallCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMMoodwallCell class]) forIndexPath:indexPath];
    
    XMMoodwallModel *moodwallModel = self.resourceArray[indexPath.row];
    moodwallCell.moodwallModel = moodwallModel;
    
    return moodwallCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMMoodwallModel *moodwallModel = self.resourceArray[indexPath.row];
    
    XMAlertView *alertView = [[XMAlertView alloc] initWithMessage:moodwallModel.content name:moodwallModel.v_userNickName delegate:self];
    [alertView xl_show];
}

// MARK: - 心情墙 数据请求
- (void)moodwallViewRequestDataSource {
    NSString *moodwallURL = [NSString stringWithFormat:kMoodwallURL, _page];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [kHTTPManager moodwall_getWithURL:moodwallURL params:nil success:^(id response) {
            
            if (_page == 1) {
                
                [self.resourceArray removeAllObjects];
            }
            
            NSString *sourceString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            
            NSArray *array = [sourceString componentsSeparatedByString:@"<string xmlns=\"http://www.wenzizhan.com/\">"];
            NSString *lastString = array.lastObject;
            NSString *responseString = [lastString componentsSeparatedByString:@"</string>"].firstObject;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            [self moodwallAnalyze:dictionary[@"data"]];
            
        } failure:^(NSError *error) {
            
        }];
    });
}

- (void)moodwallAnalyze:(NSArray *)source {
    
    for (NSDictionary *dic in source) {
        XMMoodwallModel *moodwallModel = [XMMoodwallModel moodwallModelWithDictionary:dic];
        [self.resourceArray addObject:moodwallModel];
    }
    
    for (int i = 0; i < self.resourceArray.count; i++) {
        XMMoodwallModel *moodwallModel = self.resourceArray[i];
        if (i % 2 == 0) {
            moodwallModel.index = 0;
        }
        else {
            moodwallModel.index = 1;
        }
    }
    
    [self.moodwallTableView reloadData];
    [self.moodwallTableView.mj_footer endRefreshing];
    [self.moodwallTableView.mj_header endRefreshing];
}

// MARK: - 数据加载更多
- (void)moodwallLoadMoreData {
    _page++;
    [self moodwallViewRequestDataSource];
}

// MARK: - XMAlertViewDelegate
- (void)xlAlertView:(XMAlertView *)alertView {
    [alertView xl_dismiss];
}

- (UITableView *)moodwallTableView {
    if (!_moodwallTableView) {
        self.moodwallTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        
        _moodwallTableView.delegate = self;
        _moodwallTableView.dataSource = self;
        
        [_moodwallTableView registerClass:[XMMoodwallCell class] forCellReuseIdentifier:NSStringFromClass([XMMoodwallCell class])];
        
        // 隐藏分割线
        _moodwallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moodwallLoadMoreData)];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载更多数据" forState:MJRefreshStatePulling];
        
        _moodwallTableView.mj_footer = footer;
    
        [self.view addSubview:_moodwallTableView];
    }
    return _moodwallTableView;
}

- (NSMutableArray<XMMoodwallModel *> *)resourceArray {
    if (!_resourceArray) {
        self.resourceArray = [NSMutableArray array];
    }
    return _resourceArray;
}


@end
