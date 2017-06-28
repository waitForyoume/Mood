//
//  XMSetFontViewController.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSetFontViewController.h"
#import "XMSetFontCell.h"

@interface XMSetFontViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *fontTableView;
@property (nonatomic, strong) NSMutableArray *settingArray;

@end

@implementation XMSetFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"修改字体大小";
    
    [self fontTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMSetFontCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMSetFontCell class]) forIndexPath:indexPath];
    NSMutableDictionary *dic = self.settingArray[indexPath.row];
    
    cell.leftL.font = [UIFont systemFontOfSize:[dic[@"kFont"] intValue]];
    cell.leftL.text = dic[@"text"];
    cell.select.hidden = [dic[@"isSelect"] boolValue];
    
    cell.isSelect = ^(XMSetFontCell *cell) {
        
        for (int i = 0; i < self.settingArray.count; i++) {
            NSMutableDictionary *temp = self.settingArray[i];
            if (i == indexPath.row) {
                temp[@"isSelect"] = @NO;
            }
            else {
                temp[@"isSelect"] = @YES;
            }
        }
        
        [kUSER_DEFAULTS setValue:dic[@"kFont"] forKey:@"kNormalFont"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kXMChangeTextFont" object:@{@"font":[kUSER_DEFAULTS objectForKey:@"kNormalFont"]}];
        
        [self.fontTableView reloadData];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableView *)fontTableView {
    if (!_fontTableView) {
        self.fontTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _fontTableView.dataSource = self;
        _fontTableView.delegate = self;
        _fontTableView.tableFooterView = [UIView new];
        _fontTableView.backgroundColor = kCOLOR;
        _fontTableView.rowHeight = 50.0f;
        
        [_fontTableView registerClass:[XMSetFontCell class] forCellReuseIdentifier:NSStringFromClass([XMSetFontCell class])];
        
        [self.view addSubview:_fontTableView];
    }
    return _fontTableView;
}

- (NSMutableArray *)settingArray {
    if (!_settingArray) {
        self.settingArray = [NSMutableArray array];
        
        NSMutableDictionary *fine = @{}.mutableCopy;
        [fine setValue:@"13.0f" forKey:@"kFont"];
        [fine setValue:@"小号字体" forKey:@"text"];
        [fine setValue:@YES forKey:@"isSelect"];
        
        [_settingArray addObject:fine];
        
        NSMutableDictionary *medium = @{}.mutableCopy;
        [medium setValue:@"16.0f" forKey:@"kFont"];
        [medium setValue:@"中号字体" forKey:@"text"];
        [medium setValue:@YES forKey:@"isSelect"];
        
        [_settingArray addObject:medium];
        
        NSMutableDictionary *large = @{}.mutableCopy;
        [large setValue:@"19.0f" forKey:@"kFont"];
        [large setValue:@"大号字体" forKey:@"text"];
        [large setValue:@YES forKey:@"isSelect"];
        
        [_settingArray addObject:large];
        
        NSMutableDictionary *extra = @{}.mutableCopy;
        [extra setValue:@"20.0f" forKey:@"kFont"];
        [extra setValue:@"特大号字体" forKey:@"text"];
        [extra setValue:@YES forKey:@"isSelect"];
        
        [_settingArray addObject:extra];
        
        for (NSMutableDictionary *dic in _settingArray) {
            if (kManager.xLsize == [dic[@"kFont"] floatValue]) {
                dic[@"isSelect"] = @NO;
            }
        }
    }
    return _settingArray;
}


@end
