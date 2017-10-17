//
//  XMHttpManager.m
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMHttpManager.h"

@implementation XMHttpManager

+ (XMHttpManager *)httpManager {
    static XMHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMHttpManager alloc] init];
    });
    return manager;
}

- (void)xl_getWithURL:(NSString *)url
               params:(id)params
              success:(void (^)(id))success
              failure:(void (^)(NSError *))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求错误 %@", error);
        
        failure(error);
    }];
}

- (void)article_getWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [self getWithURL:url params:params success:success failure:failure];
}

- (void)articledetail_getWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self getWithURL:url params:params success:success failure:failure];
}

- (void)moodwall_getWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [self getWithURL:url params:params success:success failure:failure];
}

- (void)sentence_getWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [self getWithURL:url params:params success:success failure:failure];
}

- (void)getWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            
            NSString *sourceString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSArray *array = [sourceString componentsSeparatedByString:@"<string xmlns=\"http://www.wenzizhan.com/\">"];
            NSString *lastString = array.lastObject;
            NSString *responseString = [lastString componentsSeparatedByString:@"</string>"].firstObject;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            success(dictionary);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求错误 %@", error);
        
        failure(error);
    }];

}

@end
