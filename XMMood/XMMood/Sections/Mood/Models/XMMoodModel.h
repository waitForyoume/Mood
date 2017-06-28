//
//  XMMoodModel.h
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMMoodModel : NSObject

@property (nonatomic, copy) NSString *mood_id;
@property (nonatomic, copy) NSString *infomation; // description
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL isSelected;

- (id)initWithDictionary:(NSDictionary *)dic;
+ (id)moodModelWithDictionary:(NSDictionary *)dic;

@end
