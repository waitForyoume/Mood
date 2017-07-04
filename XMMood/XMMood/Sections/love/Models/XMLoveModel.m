//
//  XMLoveModel.m
//  XMMood
//
//  Created by panda on 17/7/4.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMLoveModel.h"

@implementation XMLoveModel

- (id)initWithInfomation:(NSString *)info
                     url:(NSString *)url
              isSelected:(BOOL)isSelected
                  moodId:(NSString *)moodId {
    self = [super init];
    if (self) {
        
        _infomation = info;
        _img = url;
        _isSelected = isSelected;
        _mood_id = moodId;
    }
    return self;
}

+ (id)loveModelWithInfomation:(NSString *)info
                          url:(NSString *)url
                   isSelected:(BOOL)isSelected
                       moodId:(NSString *)moodId {
    
    return [[self alloc] initWithInfomation:info url:url isSelected:isSelected moodId:moodId];
}


@end
