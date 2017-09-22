//
//  XMLoveModel.h
//  XMMood
//
//  Created by panda on 17/7/4.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLoveModel : NSObject

@property (nonatomic, copy) NSString *infomation; // description
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *mood_id;
@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, assign) BOOL isSelected;


- (id)initWithInfomation:(NSString *)info
                     url:(NSString *)url
                   image:(UIImage *)image
              isSelected:(BOOL)isSelected
                  moodId:(NSString *)moodId;


+ (id)loveModelWithInfomation:(NSString *)info
                          url:(NSString *)url
                        image:(UIImage *)image
                   isSelected:(BOOL)isSelected
                       moodId:(NSString *)moodId;

@end
