//
//  XMSentenceModel.m
//  XMMood
//
//  Created by panda on 17/10/17.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSentenceModel.h"

@implementation XMSentenceModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (id)sentenceWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.sentence_id = value;
    }
    else if ([key isEqualToString:@"content"]) {
        self.sentence_content = value;
    }
}

@end
