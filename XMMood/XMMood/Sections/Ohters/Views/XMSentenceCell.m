//
//  XMSentenceCell.m
//  XMMood
//
//  Created by panda on 17/10/17.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMSentenceCell.h"

@implementation XMSentenceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.sentenceContentLabel];
    }
    return self;
}

- (UILabel *)sentenceContentLabel {
    if (!_sentenceContentLabel) {
        self.sentenceContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sentenceContentLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _sentenceContentLabel.numberOfLines = 0;
    }
    return _sentenceContentLabel;
}

- (void)setContent:(NSString *)content {
    
    CGFloat contentHeight = [XMSentenceCell sentenceWithContent:content].height;
    
    self.sentenceContentLabel.top = 12.0f;
    self.sentenceContentLabel.left = 10.0f;
    self.sentenceContentLabel.width = kSCREEN_WIDTH - 20.0f;
    self.sentenceContentLabel.height = contentHeight;
    
    self.sentenceContentLabel.text = content;
}

+ (CGSize)sentenceWithContent:(NSString *)content {
    
    CGSize size = [content sizeWithFont:[UIFont boldSystemFontOfSize:16.0f] withMaxSize:CGSizeMake(kSCREEN_WIDTH - 20.0f, MAXFLOAT)];
    return size;
}

@end
