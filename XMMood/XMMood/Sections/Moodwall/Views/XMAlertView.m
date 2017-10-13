//
//  XMAlertView.m
//  XMMood
//
//  Created by panda on 17/10/13.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMAlertView.h"

#define kAlertViewWidth kScaleH(960)

@interface XMAlertView ()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation XMAlertView

- (instancetype)initWithMessage:(NSString *)message name:(NSString *)name delegate:(id)delegate {
    self = [super init];
    if (self) {
        
        _message = message;
        _delegate = delegate;
        _name = name;
        
        self.backgroundColor = [UIColor whiteColor];
        [self alertViewAddBackgroudView];
        
        [self alertViewAddMessage];
        
        self.alpha = 0;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0f;
        
        self.center = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 2);
        self.bounds = CGRectMake(0, 0, kAlertViewWidth, CGRectGetMaxY(self.nameLabel.frame) + kScaleH(36.0f));
    }
    return self;
}

// 添加内容信息
- (void)alertViewAddMessage {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, kScaleH(40.0f) /* 15.0f */, kAlertViewWidth - 40.0f, kScaleH(50.0f))];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = kCOLOR_RGBA(89, 142, 185, 1);
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _titleLabel.text = @"心情详情";
    [self addSubview:_titleLabel];
    
    self.messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont boldSystemFontOfSize:15.5f];
    _messageLabel.numberOfLines = 0;
    _messageLabel.text = _message;
    CGSize messageSize = [_message sizeWithFont:[UIFont boldSystemFontOfSize:15.5f] withMaxSize:CGSizeMake(kAlertViewWidth - kScaleH(120), MAXFLOAT)];
    _messageLabel.frame = CGRectMake(kScaleH(60.0f), CGRectGetMaxY(self.titleLabel.frame) + kScaleH(50.0f), kAlertViewWidth - kScaleH(120.0f), messageSize.height);
    [self addSubview:_messageLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.messageLabel.frame) + kScaleH(40.0f), CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame))];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.textColor = kCOLOR_RGBA(89, 142, 185, 1);
    _nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _nameLabel.text = _name;
    [self addSubview:_nameLabel];
}

// MARK: - 背景
- (void)alertViewAddBackgroudView {
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.backButton.backgroundColor = [UIColor blackColor];
    [self.backButton addTarget:self action:@selector(alertViewGotoBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.alpha = 0;
}

- (void)alertViewGotoBackBtnClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(xlAlertView:)]) {
        [_delegate xlAlertView:self];
    }
}

// MARK: - 弹出
- (void)xl_show {
    [[UIApplication sharedApplication].keyWindow addSubview:self.backButton];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backButton.alpha = 0.4;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

// MARK: - 消失
- (void)xl_dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.backButton.alpha = 0;
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self.backButton removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
