//
//  XMSettingCell.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSettingCell.h"

#define kSETTING_FONT [UIFont systemFontOfSize:16.0f]

@implementation XMSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.leftL];
        [self.contentView addSubview:self.rightL];
    }
    return self;
}

- (UILabel *)leftL {
    if (!_leftL) {
        self.leftL = [[UILabel alloc] init];
        
        _leftL.top = 0;
        _leftL.left = 15.0f;
        _leftL.height = 50.0f;
        _leftL.width = (kSCREEN_WIDTH - 30.0f) * 2 / 3;
        
        _leftL.textColor = kFONT_COLOR;
        _leftL.font = kSETTING_FONT;
    }
    return _leftL;
}

- (UILabel *)rightL {
    if (!_rightL) {
        self.rightL = [[UILabel alloc] init];
        
        _rightL.left = kSCREEN_WIDTH - (kSCREEN_WIDTH - 15.0f) / 3 - 15.0f;
        _rightL.width = (kSCREEN_WIDTH - 15.0f) / 3;
        _rightL.height = 50.0f;
        _rightL.top = 0;
        
        _rightL.textColor = kFONT_COLOR;
        _rightL.textAlignment = NSTextAlignmentRight;
        _rightL.font = kSETTING_FONT;
    }
    return _rightL;
}

@end
