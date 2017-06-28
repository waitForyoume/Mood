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

@property (nonatomic, strong) UITableView *moodTableView;
@property (nonatomic, strong) NSMutableArray<XMMoodModel *> *resourceArray;

@end

@implementation XMMoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self moodTableView];
    [self xl_requestWithSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

// MARK: - 网络请求
- (void)xl_requestWithSource {
    [kHTTPManager xl_getWithURL:kURL params:nil success:^(id response) {

        [self xl_sourceWithAnalysis:response];
    } failure:^(NSError *error) {
        
        NSLog(@"错误信息 : %@", error);
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMMoodCell *moodCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMMoodCell class]) forIndexPath:indexPath];

    XMMoodModel *moodModel = self.resourceArray[indexPath.row];
    moodCell.model = moodModel;
    
    return moodCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMMoodModel *model = (XMMoodModel *)self.resourceArray[indexPath.row];
    return [XMMoodCell xl_cellWithHeight:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UITableView *)moodTableView {
    if (!_moodTableView) {
        self.moodTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _moodTableView.delegate = self;
        _moodTableView.dataSource = self;
        _moodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_moodTableView registerClass:[XMMoodCell class] forCellReuseIdentifier:NSStringFromClass([XMMoodCell class])];
        
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

@end
