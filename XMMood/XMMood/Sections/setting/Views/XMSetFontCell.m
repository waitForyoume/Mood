//
//  XMSetFontCell.m
//  XMMood
//
//  Created by panda on 17/6/28.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSetFontCell.h"

@implementation XMSetFontCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        
        [self.contentView addSubview:self.leftL];
        [self.contentView addSubview:self.select];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)selectAction:(UITapGestureRecognizer *)gesture {
    if (self.isSelect) {
        self.isSelect(self);
    }
}

- (UILabel *)leftL {
    if (!_leftL) {
        self.leftL = [[UILabel alloc] init];
        
        _leftL.left = 15.0f;
        _leftL.top = 0;
        _leftL.height = 50.0f;
        _leftL.width = (kSCREEN_WIDTH - 30.0f) * 2 / 3;
        
        _leftL.textColor = kFONT_COLOR;
    }
    return _leftL;
}

- (UIButton *)select {
    if (!_select) {
        self.select = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_select setImage:[UIImage imageNamed:@"font_select"] forState:UIControlStateNormal];
        
        _select.left = kSCREEN_WIDTH - 35.0f;
        _select.top = 30.0f / 2;
        _select.width = 20.0f;
        _select.height = 20.0f;
        
        _select.hidden = YES;
        _select.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _select;
}

@end
