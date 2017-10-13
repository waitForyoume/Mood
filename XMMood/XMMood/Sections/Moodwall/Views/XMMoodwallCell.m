//
//  XMMoodwallCell.m
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMMoodwallCell.h"
#import "XMMoodwallModel.h"

@interface XMMoodwallCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation XMMoodwallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.backgroudImageView];
        [self.backgroudImageView addSubview:self.contentLabel];
        [self.backgroudImageView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setMoodwallModel:(XMMoodwallModel *)moodwallModel {
    
//    CGFloat content_height = [moodwallModel.content sizeWithFont:[UIFont systemFontOfSize:16.0f] withMaxSize:CGSizeMake(220.0, MAXFLOAT)].height;
    
    // 内容
    self.contentLabel.text = moodwallModel.content;
    
    // 名字
    self.nameLabel.text = moodwallModel.v_userNickName;
    
    if (moodwallModel.index == 0) {
        self.backgroudImageView.image = [UIImage imageNamed:@"bg_9.24_1"];
        
    }
    else if (moodwallModel.index == 1) {
        self.backgroudImageView.image = [UIImage imageNamed:@"bg_9.24_2"];
    }
}

- (UIImageView *)backgroudImageView {
    if (!_backgroudImageView) {
        self.backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, kSCREEN_WIDTH - 30.0f, 130.0f)];
        
        _backgroudImageView.image = [UIImage imageNamed:@"bg_9.24_1"];
    }
    return _backgroudImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.0, 7.0, kSCREEN_WIDTH - 30.0f - 14.0f, 116.0f - 18.0f)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont boldSystemFontOfSize:15.5f];
    }
    return _contentLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - 30.0f) / 2, 105.0f, (kSCREEN_WIDTH - 30.0f) / 2 - 15.0f, 25.0f)];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _nameLabel.textColor = kCOLOR_RGBA(89, 142, 185, 1);
    }
    return _nameLabel;
}

@end
