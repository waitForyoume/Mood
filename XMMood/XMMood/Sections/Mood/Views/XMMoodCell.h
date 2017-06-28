//
//  XMMoodCell.h
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMMoodCell;
typedef void(^SelectedBlock)(XMMoodCell *cell);

@class XMMoodModel;
@interface XMMoodCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *infomationL;
@property (nonatomic, strong) UIButton *collect;

@property (nonatomic, strong) XMMoodModel *model;
@property (nonatomic, copy) SelectedBlock isSelected;

// 返回cell的高度
+ (CGFloat)xl_cellWithHeight:(XMMoodModel *)model;

@end
