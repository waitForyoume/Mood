//
//  XMArticleTitleCell.m
//  XMMood
//
//  Created by panda on 17/10/16.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMArticleTitleCell.h"
#import "XMArticleModel.h"

@implementation XMArticleTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.aritcleTypeLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _titleLabel;
}

- (UILabel *)aritcleTypeLabel {
    if (!_aritcleTypeLabel) {
        self.aritcleTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _aritcleTypeLabel.textColor = kCOLOR_RGBA(223, 100, 49, 1);
        _aritcleTypeLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _aritcleTypeLabel;
}

- (void)setArticleModel:(XMArticleModel *)articleModel {
    
    NSString *articleType = [NSString stringWithFormat:@"[%@]", articleModel.article_v_typename];
    
    CGFloat articleTypeWidth = [articleType sizeWithFont:[UIFont boldSystemFontOfSize:16.0f] withMaxSize:CGSizeMake(MAXFLOAT, 30.0f)].width;
    self.aritcleTypeLabel.left = 10.0f;
    self.aritcleTypeLabel.height = 30.0f;
    self.aritcleTypeLabel.top = 5.0f;
    self.aritcleTypeLabel.width = articleTypeWidth;
    self.aritcleTypeLabel.text = articleType;
    
    self.titleLabel.left = self.aritcleTypeLabel.right + 10.0f;
    self.titleLabel.width = kSCREEN_WIDTH - self.aritcleTypeLabel.right - 25.0f;
    self.titleLabel.height = 30.0f;
    self.titleLabel.top = self.aritcleTypeLabel.top;
    
    self.titleLabel.text = articleModel.article_title;
}

@end
