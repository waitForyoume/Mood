//
//  XMLoveCell.m
//  XMMood
//
//  Created by panda on 17/9/22.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMLoveCell.h"
#import "XMLoveModel.h"

#define lWIDTH (kSCREEN_WIDTH - 15 * 2)

@interface XMLoveCell ()

@property (nonatomic, strong) UIView *normalView;
@property (nonatomic, strong) UIImage *xlImage;

@end


@implementation XMLoveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:238.0f / 255.0f green:238.0f / 255.0f blue:238.0f / 255.0f alpha:1];
        
        [self.contentView addSubview:self.normalView];
        [self.normalView addSubview:self.imgView];
        [self.normalView addSubview:self.infomationL];
        
//        [self.normalView addSubview:self.collect]; // 收藏
    }
    return self;
}

- (void)setModel:(XMLoveModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    
    // 重新布局
    _normalView.left = 0;
    _normalView.top = 0;
    _normalView.width = kSCREEN_WIDTH;
    _normalView.height = self.height - 13.0f;
    
    _imgView.top = 0;
    _imgView.left = 0;
    _imgView.width = kSCREEN_WIDTH;
    
    if (_model.image == NULL) {
        
        _collect.hidden = YES;
        _imgView.height = 5.0f;
    }
    else {
        
        _collect.hidden = NO;
        CGFloat height = (_model.image.size.height * kSCREEN_WIDTH) / _model.image.size.width;
        _imgView.height = height;
        _imgView.image = _model.image;
    }
    
    _infomationL.left = 15.0f;
    _infomationL.top = _imgView.bottom + 10.0f;
    _infomationL.width = lWIDTH;
    
    CGFloat lHeight = [_model.infomation sizeWithFont:[UIFont systemFontOfSize:kManager.xLsize] withMaxSize:CGSizeMake(lWIDTH, MAXFLOAT)].height;
    int numberLine = lHeight / _infomationL.font.lineHeight;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_model.infomation];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.5f;
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.infomation.length)];
    _infomationL.attributedText = attrString;
    _infomationL.height = lHeight + numberLine * 3.5;
    _infomationL.font = [UIFont systemFontOfSize:kManager.xLsize];
    
    _collect.left = kSCREEN_WIDTH - 40.0f;
    _collect.top = _infomationL.bottom + 5.0f;
    _collect.width = 25.0f;
    _collect.height = 25.0f;
    
//    _collect.selected = _model.isSelected;
}

+ (CGFloat)xl_cellWithHeight:(XMLoveModel *)model {
    
    CGFloat lHeight = [model.infomation sizeWithFont:[UIFont systemFontOfSize:kManager.xLsize] withMaxSize:CGSizeMake(lWIDTH, MAXFLOAT)].height;
    int numberLine = lHeight / [UIFont systemFontOfSize:16].lineHeight;
    
    if (model.image == NULL) { // 258.0
        return 1.0 + lHeight + numberLine * 3.5 + 20.0f + 10.0f + 30.0f - 25.0f/* 减去收藏的高度 */; // lHeight + numberLine * 3.5 + 8 + 10;
    }
    else {
        CGFloat height = (model.image.size.height * kSCREEN_WIDTH) / model.image.size.width;
        return height + lHeight + numberLine * 3.5 + 20.0f + 10.0f + 30.0f - 25.0f/* 减去收藏的高度 */; // lHeight + numberLine * 3.5 + 8 + 10;
    }
}

- (UIView *)normalView {
    if (!_normalView) {
        self.normalView = [[UIView alloc] init];
        
        _normalView.backgroundColor = kCOLOR_RGBA(255, 255, 255, 1);
    }
    return _normalView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        self.imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        //        _imgView.image = [self scaleToSize:[UIImage imageNamed:@"Normal"] size:CGSizeMake(kSCREEN_WIDTH, 258.0f)];
    }
    return _imgView;
}

- (UILabel *)infomationL {
    if (!_infomationL) {
        self.infomationL = [[UILabel alloc] init];
        _infomationL.textColor = kFONT_COLOR;
        _infomationL.font = [UIFont systemFontOfSize:kManager.xLsize];
        _infomationL.numberOfLines = 0;
    }
    return _infomationL;
}

- (UIButton *)collect {
    if (!_collect) {
        self.collect = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_collect setImage:[UIImage imageNamed:@"normal_collect"] forState:UIControlStateNormal];
        [_collect setImage:[UIImage imageNamed:@"selete_collect"] forState:UIControlStateSelected];
        _collect.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_collect addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventAllEvents];
        
        _collect.hidden = YES;
    }
    return _collect;
}

- (void)collectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.isSelected) {
        self.isSelected(self);
    }
}

@end
