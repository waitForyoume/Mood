//
//  XMMoodCell.m
//  XMMood
//
//  Created by panda on 17/6/27.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMMoodCell.h"
#import "XMMoodModel.h"

#define lWIDTH (kSCREEN_WIDTH - 15 * 2)

@interface XMMoodCell ()

@property (nonatomic, strong) UIView *normalView;

@end


@implementation XMMoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:238.0f / 255.0f green:238.0f / 255.0f blue:238.0f / 255.0f alpha:1];
        
        [self.contentView addSubview:self.normalView];
        [self.normalView addSubview:self.imgView];
        [self.normalView addSubview:self.infomationL];
        [self.normalView addSubview:self.collect]; // 收藏
    }
    return self;
}

- (void)setModel:(XMMoodModel *)model {

    // 重新布局
    _normalView.left = 0;
    _normalView.top = 0;
    _normalView.width = kSCREEN_WIDTH;
    _normalView.height = self.height - 13.0f;
    
    _imgView.top = 0;
    _imgView.left = 0;
    _imgView.width = kSCREEN_WIDTH;
    _imgView.height = 255.0f;
    
    _infomationL.left = 15.0f;
    _infomationL.top = _imgView.bottom + 5.0f;
    _infomationL.width = lWIDTH;
    
    CGFloat lHeight = [model.infomation sizeWithFont:[UIFont systemFontOfSize:16] withMaxSize:CGSizeMake(lWIDTH, MAXFLOAT)].height;
    int numberLine = lHeight / _infomationL.font.lineHeight;
    _infomationL.height = lHeight + numberLine * 3.5;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:model.infomation];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.5f;
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.infomation.length)];
    _infomationL.attributedText = attrString;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
        CGFloat height = (image.size.height * kSCREEN_WIDTH) / image.size.width;
    }];

}

+ (CGFloat)xl_cellWithHeight:(XMMoodModel *)model {
    
    CGFloat lHeight = [model.infomation sizeWithFont:[UIFont systemFontOfSize:16] withMaxSize:CGSizeMake(lWIDTH, MAXFLOAT)].height;
    int numberLine = lHeight / [UIFont systemFontOfSize:16].lineHeight;
    return 278.0 + lHeight + numberLine * 3.5 + 8 + 10;
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
    }
    return _imgView;
}

- (UILabel *)infomationL {
    if (!_infomationL) {
        self.infomationL = [[UILabel alloc] init];
        _infomationL.textColor = kCOLOR_RGBA(16, 16, 16, 1);
        _infomationL.font = [UIFont systemFontOfSize:16.0f];
        _infomationL.numberOfLines = 0;
    }
    return _infomationL;
}

@end
