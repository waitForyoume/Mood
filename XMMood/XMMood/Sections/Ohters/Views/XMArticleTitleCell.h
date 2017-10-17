//
//  XMArticleTitleCell.h
//  XMMood
//
//  Created by panda on 17/10/16.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMArticleModel;
@interface XMArticleTitleCell : UITableViewCell

@property (nonatomic, strong) UILabel *aritcleTypeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) XMArticleModel *articleModel;

@end
