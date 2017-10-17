//
//  XMArticleViewController.m
//  XMMood
//
//  Created by panda on 17/10/16.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMArticleViewController.h"
#import "XMArticleModel.h"
#import "XMArticleTitleCell.h"
#import "XMArticleDetailViewController.h"

#define kArticleURL @"http://www.wenzizhan.com/AppServiceNew/Article.asmx/GetList_ByParentTypeAll?topNumber=5"

@interface XMArticleViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *articleTableView;
@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSMutableDictionary *articleDictionary;

@end

@implementation XMArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self articleTableView];
    [self articleViewRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.articleDictionary.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articleDictionary[self.sectionArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMArticleTitleCell *articleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMArticleTitleCell class]) forIndexPath:indexPath];
    
    XMArticleModel *articleModel = self.articleDictionary[self.sectionArray[indexPath.section]][indexPath.row];
    
    articleCell.articleModel = articleModel;
    
    return articleCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerInSectionView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, kSCREEN_WIDTH - 30.0f, 40.0f)];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0, headerInSectionView.width, headerInSectionView.height)];
    sectionLabel.font = [UIFont systemFontOfSize:18.5f weight:9.0f];
    sectionLabel.text = self.sectionArray[section];
    [headerInSectionView addSubview:sectionLabel];
    return headerInSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XMArticleDetailViewController *articleDetailView = [[XMArticleDetailViewController alloc] init];
    XMArticleModel *articleModel = self.articleDictionary[self.sectionArray[indexPath.section]][indexPath.row];
    articleDetailView.article_id = articleModel.article_id;
    articleDetailView.title = articleModel.article_title;
    [self currentControllerPushNextController:articleDetailView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30.0;
    if(scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)articleViewRequest {
    
    kWEAK_SELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [kHTTPManager article_getWithURL:kArticleURL params:nil success:^(id response) {
            
            NSDictionary *dictionary = [response isKindOfClass:[NSDictionary class]] ? response : nil;
            NSDictionary *sourceDictionary = dictionary[@"data"];
            
            if (dictionary != nil) {
                
                NSArray *allkeys = sourceDictionary.allKeys;
                for (NSString *key in allkeys) {
                    
                    if ([key isEqualToString:@"data1"]) {
                        
                        [weakSelf articleAnalyzeWithArray:sourceDictionary[@"data1"] index:0];
                    }
                    else if ([key isEqualToString:@"data2"]) {
                    
                        [weakSelf articleAnalyzeWithArray:sourceDictionary[@"data2"] index:1];
                    }
                    else if ([key isEqualToString:@"data3"]) {
                    
                        [weakSelf articleAnalyzeWithArray:sourceDictionary[@"data3"] index:2];
                    }
                    else if ([key isEqualToString:@"data4"]) {
                    
                        [weakSelf articleAnalyzeWithArray:sourceDictionary[@"data4"] index:3];
                    }
                    else if ([key isEqualToString:@"data5"]) {
                        
                        [weakSelf articleAnalyzeWithArray:sourceDictionary[@"data5"] index:4];
                    }
                    else if ([key isEqualToString:@"data6"]) {
                    
                        [weakSelf articleAnalyzeWithArray:sourceDictionary[@"data6"] index:5];
                    }
                }
                
            }
            
        } failure:^(NSError *error) {
            
        }];
    });
}

- (void)articleAnalyzeWithArray:(NSArray *)array index:(NSInteger)index {
    NSMutableArray *sources = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        XMArticleModel *model = [XMArticleModel articleModelWithDictionary:dic];
        [sources addObject:model];
    }
    [self.articleDictionary setValue:sources forKey:self.sectionArray[index]];
    
    kWEAK_SELF
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [weakSelf.articleTableView reloadData];
    });
}

- (UITableView *)articleTableView {
    if (!_articleTableView) {
        self.articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNAVIGATIONBAR_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT - kNAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
        
//        _articleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _articleTableView.tableFooterView = [UIView new];
        _articleTableView.dataSource = self;
        _articleTableView.delegate = self;
        
        [_articleTableView registerClass:[XMArticleTitleCell class] forCellReuseIdentifier:NSStringFromClass([XMArticleTitleCell class])];
        
        [self.view addSubview:_articleTableView];
        
    }
    return _articleTableView;
}

- (NSMutableDictionary *)articleDictionary {
    if (!_articleDictionary) {
        self.articleDictionary = [NSMutableDictionary dictionary];
    }
    return _articleDictionary;
}

- (NSArray *)sectionArray {
    if (!_sectionArray) {
        self.sectionArray = @[@"文章", @"散文", @"日记", @"诗词", @"小说", @"其他"];
    }
    return _sectionArray;
}

@end
