//
//  XMMoodwallModel.h
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMMoodwallModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *v_userNickName;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) NSInteger index;

- (id)initWithDictionary:(NSDictionary *)dic;
+ (id)moodwallModelWithDictionary:(NSDictionary *)dic;

@end
