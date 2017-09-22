//
//  XMFMDBManager.h
//  XMMood
//
//  Created by panda on 17/7/4.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFMDBManager [XMFMDBManager fmdbmanager]

@class XMLoveModel;
@interface XMFMDBManager : NSObject

+ (XMFMDBManager *)fmdbmanager;

// 增
+ (BOOL)xl_insertIntoWithModel:(XMLoveModel *)model;

// 删 -- 通过行的唯一标识(主键)来删除一条数据
+ (BOOL)xl_deleteByRowId:(NSString *)moodId;

// 改
+ (BOOL)xl_updateWithModel:(XMLoveModel *)model;

// 查询某条数据是否存在
+ (XMLoveModel *)xl_queryWithByIdentifier:(NSString *)identifier;

// 查
+ (BOOL)xl_queryAllresource;

+ (NSMutableArray *)xl_resourceArray;

@end
