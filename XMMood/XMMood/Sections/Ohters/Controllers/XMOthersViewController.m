//
//  XMOthersViewController.m
//  XMMood
//
//  Created by panda on 17/10/16.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMOthersViewController.h"
#import "XMArticleViewController.h"
#import "XMSentenceViewController.h"

@interface XMOthersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *otherTableView;
@property (nonatomic, strong) NSArray *sourceArray;

@end

@implementation XMOthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"其他";
    
    [self otherTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    otherCell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];

    if (indexPath.section == 0) {
        otherCell.textLabel.text = self.sourceArray[0];
    }
    else if (indexPath.section == 1) {
        otherCell.textLabel.text = self.sourceArray[1];
    }
    
    return otherCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        XMArticleViewController *articleView = [[XMArticleViewController alloc] init];
        articleView.title = self.sourceArray[0];
        [self currentControllerPushNextController:articleView];
    }
    else if (indexPath.section == 1) {
        XMSentenceViewController *sentenceView = [[XMSentenceViewController alloc] init];
        sentenceView.title = self.sourceArray[1];
        [self currentControllerPushNextController:sentenceView];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UITableView *)otherTableView {
    if (!_otherTableView) {
        self.otherTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        [_otherTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        _otherTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _otherTableView.delegate = self;
        _otherTableView.dataSource = self;
        
        [self.view addSubview:_otherTableView];
    }
    return _otherTableView;
}

- (NSArray *)sourceArray {
    if (!_sourceArray) {
        self.sourceArray = @[@"文章", @"句子汇"];
    }
    return _sourceArray;
}

@end
