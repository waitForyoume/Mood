//
//  XMSentenceViewController.m
//  XMMood
//
//  Created by panda on 17/10/17.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSentenceViewController.h"
#import "XMSentenceModel.h"
#import "XMSentenceCell.h"

#define kSentenceURL @"http://www.wenzizhan.com/AppServiceNew/Juzi.asmx/GetList_NewAndRand?topNumber1=10&topnumber2=10"

@interface XMSentenceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *sentenceTableView;
@property (nonatomic, strong) NSMutableDictionary *sentenceDictionary;
@property (nonatomic, strong) NSArray *sectionArray;

@end

@implementation XMSentenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self sentenceTableView];
    [self sentenceViewRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sentenceDictionary[self.sectionArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMSentenceCell *sentenceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMSentenceCell class]) forIndexPath:indexPath];
    
    XMSentenceModel *sentenceModel = self.sentenceDictionary[self.sectionArray[indexPath.section]][indexPath.row];
    sentenceCell.content = sentenceModel.sentence_content;
    
    return sentenceCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMSentenceModel *sentenceModel = self.sentenceDictionary[self.sectionArray[indexPath.section]][indexPath.row];
    return [XMSentenceCell sentenceWithContent:sentenceModel.sentence_content].height + 24.0f;
}

- (void)sentenceViewRequest {
    
    kWEAK_SELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [kHTTPManager sentence_getWithURL:kSentenceURL params:nil success:^(id response) {
            
            NSDictionary *dictionary = [response[@"data"] isKindOfClass:[NSDictionary class]] ? (NSDictionary *)response[@"data"] : nil;
                        
            if (dictionary != nil) {
                
                NSArray *allkeys = dictionary.allKeys;
                
                for (NSString *key in allkeys) {
                    
                    if ([key isEqualToString:@"data1"]) {
                        
                        [weakSelf sentenceWithAnalysis:dictionary[@"data1"] index:0];
                    }
                    else if ([key isEqualToString:@"data2"]) {
                        
                        [weakSelf sentenceWithAnalysis:dictionary[@"data2"] index:1];
                    }
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.sentenceTableView reloadData];
            });
            
        } failure:^(NSError *error) {
            
        }];
        
    });
}

- (void)sentenceWithAnalysis:(NSArray *)array index:(NSInteger)index {
    
    NSMutableArray *sources = [NSMutableArray array];
    for (NSDictionary *dic in array) {
     
        XMSentenceModel *sentenceModel = [XMSentenceModel sentenceWithDictionary:dic];
        [sources addObject:sentenceModel];
    }
    
    [self.sentenceDictionary setValue:sources forKey:self.sectionArray[index]];
}

- (UITableView *)sentenceTableView {
    if (!_sentenceTableView) {
        self.sentenceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        
        [_sentenceTableView registerClass:[XMSentenceCell class] forCellReuseIdentifier:NSStringFromClass([XMSentenceCell class])];
        
        _sentenceTableView.tableFooterView = [UIView new];
//        _sentenceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _sentenceTableView.delegate = self;
        _sentenceTableView.dataSource = self;
        
        [self.view addSubview:_sentenceTableView];
    }
    return _sentenceTableView;
}

- (NSMutableDictionary *)sentenceDictionary {
    if (!_sentenceDictionary) {
        self.sentenceDictionary = [NSMutableDictionary dictionary];
    }
    return _sentenceDictionary;
}

- (NSArray *)sectionArray {
    if (!_sectionArray) {
        self.sectionArray = @[@"佳偶佳句", @"最新句子"];
    }
    return _sectionArray;
}

@end
