//
//  XMSentenceModel.h
//  XMMood
//
//  Created by panda on 17/10/17.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMSentenceModel : NSObject

@property (nonatomic, copy) NSString *sentence_id;
@property (nonatomic, copy) NSString *sentence_content;
@property (nonatomic, copy) NSString *juziType;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)sentenceWithDictionary:(NSDictionary *)dictionary;

@end
