//
//  XMSentenceCell.h
//  XMMood
//
//  Created by panda on 17/10/17.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMSentenceCell : UITableViewCell

@property (nonatomic, strong) UILabel *sentenceContentLabel;
@property (nonatomic, copy) NSString *content;

+ (CGSize)sentenceWithContent:(NSString *)content;

@end
