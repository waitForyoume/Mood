//
//  XMHttpManager.h
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHTTPManager [XMHttpManager httpManager]

@interface XMHttpManager : NSObject

+ (XMHttpManager *)httpManager;

- (void)xl_getWithURL:(NSString *)url
               params:(id)params
              success:(void(^)(id response))success
              failure:(void(^)(NSError *error))failure;

@end
