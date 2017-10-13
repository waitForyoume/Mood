//
//  XMNavbarView.m
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMNavbarView.h"

@interface XMNavbarView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *rightView;

@end

@implementation XMNavbarView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kNAVIGATIONBAR_HEIGHT);
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightView];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (void)setRightImageName:(NSString *)rightImageName {
    _rightImageName = rightImageName;
    [_rightView setImage:[UIImage imageNamed:_rightImageName] forState:UIControlStateNormal];
}

- (void)navigationBarRightAction {
    if (self.rightAction) {
        self.rightAction();
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 28.0f, kSCREEN_WIDTH - 130.0f, 27.0f)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16.5f weight:1];
        _titleLabel.textColor = kCOLOR_RGBA(16, 16, 16, 1);
    }
    return _titleLabel;
}

- (UIButton *)rightView {
    if (!_rightView) {
        self.rightView = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 5.0f - 50.0f, 20.0f + 6.0f, 50.0f, 30.0f)];
        _rightView.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_rightView addTarget:self action:@selector(navigationBarRightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightView;
}

@end
