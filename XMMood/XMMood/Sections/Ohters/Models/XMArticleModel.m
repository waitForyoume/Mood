//
//  XMArticleModel.m
//  XMMood
//
//  Created by panda on 17/10/16.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMArticleModel.h"

@implementation XMArticleModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (id)articleModelWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSString *result = (NSString *)value;
    
    if (result != nil) {
        
        if ([key isEqualToString:@"id"]) {
            self.article_id = result;
        }
        else if ([key isEqualToString:@"title"]) {
            
            if ([result containsString:@"【"]) {
                
                result = [result stringByReplacingOccurrencesOfString:@"【" withString:@"["];
            }
            
            if ([result containsString:@"】"]) {
                result = [result stringByReplacingOccurrencesOfString:@"】" withString:@"]"];
            }
            
            if ([result containsString:@"《"]) {
                
                result = [result stringByReplacingOccurrencesOfString:@"《" withString:@"<<"];
            }

            if ([result containsString:@"》"]) {
                result = [result stringByReplacingOccurrencesOfString:@"》" withString:@">>"];
            }
            
            if ([result containsString:@"（"]) {
                result = [result stringByReplacingOccurrencesOfString:@"（" withString:@"("];
            }
            
            if ([result containsString:@"）"]) {
                result = [result stringByReplacingOccurrencesOfString:@"）" withString:@")"];
            }
            
//            if ([result containsString:@"，"]) {
//                result = [result stringByReplacingOccurrencesOfString:@"，" withString:@","];
//            }
//            
//            if ([result containsString:@"。"]) {
//                result = [result stringByReplacingOccurrencesOfString:@"。" withString:@"."];
//            }
            
            self.article_title = result;
        }
        else if ([key isEqualToString:@"artType"]) {
            self.article_artType = result;
        }
        else if ([key isEqualToString:@"v_typename"]) {
            self.article_v_typename = result;
        }
        else if ([key isEqualToString:@"createTime"]) {
            
            NSString *createTime = [[result componentsSeparatedByString:@"("].lastObject componentsSeparatedByString:@")"].firstObject;
            NSTimeInterval second = createTime.longLongValue / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            self.articleCreateTime = [formatter stringFromDate:date];
        }
        else if ([key isEqualToString:@"content"]) {
            self.articleContent = result;
        }

    }
}

@end
