//
//  XMFMDBManager.m
//  XMMood
//
//  Created by panda on 17/7/4.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMFMDBManager.h"
#import "XMLoveModel.h"
#import "FMDatabase.h"

@interface XMFMDBManager ()

@property (nonatomic, strong) FMDatabase *fmdb;
@property (nonatomic, strong) NSMutableArray<XMLoveModel *> *resourceArray;

@end

@implementation XMFMDBManager

static XMFMDBManager *manager = nil;
+ (XMFMDBManager *)fmdbmanager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMFMDBManager alloc] init];
        [manager xl_createWithFMDB];
    });
    return manager;
}

// 创建数据库
- (void)xl_createWithFMDB {
    self.fmdb = [FMDatabase databaseWithPath:[self xl_fmdbFilePath]];
    
    [self xl_createWithTable];
}

// 创建表
- (void)xl_createWithTable {
    // 打开数据库
    if (![self.fmdb open]) {
        return;
    }
    
    // 创建表
    [self.fmdb executeUpdate:@"create table if not exists Love(item_id integer primary key autoincrement, item_info text, item_url text, itme_image blob, item_isSelected bool, item_moodId text)"]; // item_image blob
    
    // 关闭数据库
    [self.fmdb close];
}

// 增加
+ (BOOL)xl_insertIntoWithModel:(XMLoveModel *)model {
    
    [self fmdbmanager];
    // 打开数据库
    if (![manager.fmdb open]) {
        
        return NO;
    }
    
    BOOL isSuccess = [manager.fmdb executeUpdate:@"insert into Love(item_info, item_url, itme_image, item_isSelected, item_moodId) values(?, ?, ?, ?, ?)", model.infomation, model.img_url, model.imageData, @(model.isSelected), model.mood_id];

    return isSuccess;
}

// 删
+ (BOOL)xl_deleteByRowId:(NSString *)moodId {
    // 打开数据库
    if (![manager.fmdb open]) {
        
        return NO;
    }
    
    BOOL isSuccess = [manager.fmdb executeUpdate:@"delete from Love where item_moodId = ?", moodId];
    return isSuccess;
}

// 改
+ (BOOL)xl_updateWithModel:(XMLoveModel *)model {
    return YES;
}

// 查
+ (BOOL)xl_queryAllresource {
    [self fmdbmanager];
    
    if (![manager.fmdb open]) {
        
        return NO;
    }
    
    manager.resourceArray = nil;
    // 操作数据库
    FMResultSet *result = [manager.fmdb executeQuery:@"select *from Love"];
    while ([result next]) {
        
        NSString *info = [result stringForColumn:@"item_info"];
        NSString *url = [result stringForColumn:@"item_url"];
        BOOL isSelected = [result boolForColumn:@"item_isSelected"];
        NSString *moodId = [result stringForColumn:@"item_moodId"];
        NSData *imageData = [result dataForColumn:@"itme_image"];
        
        XMLoveModel *model = [XMLoveModel loveModelWithInfomation:info url:url image:[UIImage imageWithData: imageData] isSelected:isSelected moodId:moodId];
        [manager.resourceArray addObject:model];
    }

    [manager.fmdb close];
    return YES;
}

+ (XMLoveModel *)xl_queryWithByIdentifier:(NSString *)identifier {
    [self fmdbmanager];
    
    if (![manager.fmdb open]) {
        return nil;
    }
    
    // 操作数据库 -- 查询一条数据
    FMResultSet *result = [manager.fmdb executeQuery:@"select * from Love where item_moodId = ?", identifier];
    XMLoveModel *model = nil;
    while ([result next]) {
        
        NSString *info = [result stringForColumn:@"item_info"];
        NSString *url = [result stringForColumn:@"item_url"];
        BOOL isSelected = [result boolForColumn:@"item_isSelected"];
        NSString *moodId = [result stringForColumn:@"item_moodId"];
        NSData *imageData = [result dataForColumn:@"itme_image"];
        
        model = [XMLoveModel loveModelWithInfomation:info url:url image:[UIImage imageWithData: imageData] isSelected:isSelected moodId:moodId];
    }
    
    // 关闭数据库
    [manager.fmdb close];
    return model;
}

+ (NSMutableArray *)xl_resourceArray {
    
    [XMFMDBManager xl_queryAllresource];
    return manager.resourceArray;
}

- (NSMutableArray<XMLoveModel *> *)resourceArray {
    if (!_resourceArray) {
        self.resourceArray = [NSMutableArray array];
    }
    return _resourceArray;
}

- (NSString *)xl_fmdbFilePath {
    // 获取Documents文件夹路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 拼接上数据库文件路径
    NSLog(@"fmdb 路径 %@", [docPath stringByAppendingPathComponent:@"love.sqlite"]);
    return [docPath stringByAppendingPathComponent:@"love.sqlite"];
}

@end
