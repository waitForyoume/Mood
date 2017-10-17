//
//  XMArticleDetailViewController.m
//  XMMood
//
//  Created by panda on 17/10/17.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "XMArticleDetailViewController.h"
#import "XMArticleModel.h"

#define kArticleURL @"http://www.wenzizhan.com/AppServiceNew/Article.asmx/GetModel?id=%@"

@interface XMArticleDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation XMArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self articleDetailViewRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)articleDetailViewRequest {
    NSString *detailURL = [NSString stringWithFormat:kArticleURL, self.article_id];
    
//    NSLog(@"%@", detailURL);
    
    kWEAK_SELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [kHTTPManager articledetail_getWithURL:detailURL params:nil success:^(id response) {
            
            XMArticleModel *articleModel = [XMArticleModel articleModelWithDictionary:response[@"data"]];
            [weakSelf detailViewLayoutView:articleModel];
            
        } failure:^(NSError *error) {
            
        }];
    });
}

- (void)detailViewLayoutView:(XMArticleModel *)articleModel {
    
    kWEAK_SELF
    dispatch_async(dispatch_get_main_queue(), ^{
       
        // 标题
        weakSelf.titleLabel.left = 10.0f;
        weakSelf.titleLabel.top = 15.0f;
        CGFloat titleHeight = [articleModel.article_title sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] withMaxSize:CGSizeMake(kSCREEN_WIDTH - 20.0f, MAXFLOAT)].height;
        weakSelf.titleLabel.height = titleHeight;
        weakSelf.titleLabel.width = kSCREEN_WIDTH - 20.0f;
        weakSelf.titleLabel.text = articleModel.article_title;
        
        // 创建时间
        weakSelf.createTimeLabel.left = weakSelf.titleLabel.left;
        weakSelf.createTimeLabel.top = weakSelf.titleLabel.bottom + 5.0f;
        weakSelf.createTimeLabel.width = weakSelf.titleLabel.width;
        weakSelf.createTimeLabel.height = 20.0f;
        weakSelf.createTimeLabel.text = [NSString stringWithFormat:@"由 %@ 发表于 %@", articleModel.v_userNickName, articleModel.articleCreateTime];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[articleModel.articleContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        // 设置 文本的 字体大小
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f weight:5.0f] range:NSMakeRange(0, attrStr.length)];
        // 动态计算 文本高度
        CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH - 20.0f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        weakSelf.contentLabel.attributedText = attrStr;
        
        NSNumber *lineNumber = @((rect.size.height) / weakSelf.contentLabel.font.lineHeight);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:weakSelf.contentLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0f; // 设置行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, weakSelf.contentLabel.text.length)];
        weakSelf.contentLabel.attributedText = attributedString;
        
        weakSelf.contentLabel.left = weakSelf.createTimeLabel.left;
        weakSelf.contentLabel.top = weakSelf.createTimeLabel.bottom + 5.0f;
        weakSelf.contentLabel.width = kSCREEN_WIDTH - 20.0f;
        weakSelf.contentLabel.height = rect.size.height + [lineNumber intValue] * 5.0f;
        
        weakSelf.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, weakSelf.contentLabel.bottom + 15.0f);
    });
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNAVIGATIONBAR_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT - kNAVIGATIONBAR_HEIGHT)];
        
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [self.scrollView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)createTimeLabel {
    if (!_createTimeLabel) {
        self.createTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _createTimeLabel.font = [UIFont systemFontOfSize:14.0f];
        _createTimeLabel.textColor = kCOLOR_RGBA(127, 127, 127, 1);
        [self.scrollView addSubview:_createTimeLabel];
    }
    return _createTimeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _contentLabel.font = [UIFont systemFontOfSize:16.0f weight:5.0f];
        _contentLabel.textColor = kCOLOR_RGBA(77, 77, 77, 1);
        _contentLabel.numberOfLines = 0;
        [self.scrollView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
