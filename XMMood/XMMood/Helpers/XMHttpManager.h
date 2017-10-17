//
//  XMHttpManager.h
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHTTPManager [XMHttpManager httpManager]

typedef void(^XMSuccess)(id response);
typedef void(^XMFailure)(NSError *error);

@interface XMHttpManager : NSObject

+ (XMHttpManager *)httpManager;

- (void)xl_getWithURL:(NSString *)url
               params:(id)params
              success:(void(^)(id response))success
              failure:(void(^)(NSError *error))failure;

- (void)moodwall_getWithURL:(NSString *)url
                     params:(id)params
                    success:(void(^)(id response))success
                    failure:(void(^)(NSError *error))failure;

- (void)article_getWithURL:(NSString *)url
                    params:(id)params
                   success:(void(^)(id response))success
                   failure:(void(^)(NSError *error))failure;

- (void)articledetail_getWithURL:(NSString *)url
                   params:(id)params
                  success:(void(^)(id response))success
                  failure:(void(^)(NSError *error))failure;

- (void)sentence_getWithURL:(NSString *)url
                     params:(id)params
                    success:(void(^)(id response))success
                    failure:(void(^)(NSError *error))failure;



@end
