//
//  XMLoveCell.h
//  XMMood
//
//  Created by panda on 17/9/22.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMLoveCell;
typedef void(^LoveSelectedBlock)(XMLoveCell *cell);

@class XMLoveModel;
@interface XMLoveCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *infomationL;
@property (nonatomic, strong) UIButton *collect;

@property (nonatomic, strong) XMLoveModel *model;
@property (nonatomic, copy) LoveSelectedBlock isSelected;

// 返回cell的高度
+ (CGFloat)xl_cellWithHeight:(XMLoveModel *)model;


@end
