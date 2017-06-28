//
//  XMMoodModel.m
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMMoodModel.h"

@implementation XMMoodModel

- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (id)moodModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        
        self.mood_id = (NSString *)value;
    }
    else if ([key isEqualToString:@"description"]) {
        
        self.infomation = (NSString *)value;
    }
}

@end
