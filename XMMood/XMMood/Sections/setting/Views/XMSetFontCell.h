//
//  XMSetFontCell.h
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMSetFontCell;
typedef void(^SelectBlock)(XMSetFontCell *cell);

@interface XMSetFontCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftL;
@property (nonatomic, strong) UIButton *select;
@property (nonatomic, copy) SelectBlock isSelect;

@end
