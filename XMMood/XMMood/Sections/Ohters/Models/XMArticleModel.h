//
//  XMArticleModel.h
//  XMMood
//
//  Created by panda on 17/10/16.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMArticleModel : NSObject

@property (nonatomic, copy) NSString *articleCreateTime; // 创建时间
@property (nonatomic, copy) NSString *articleContent; // 文章内容
@property (nonatomic, copy) NSString *v_userNickName; // 作者

@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_artType;
@property (nonatomic, copy) NSString *article_v_typename;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)articleModelWithDictionary:(NSDictionary *)dictionary;

@end
