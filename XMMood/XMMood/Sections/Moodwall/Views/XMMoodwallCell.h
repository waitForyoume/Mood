//
//  XMMoodwallCell.h
//  XMMood
//
//  Created by panda on 17/9/30.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMMoodwallModel;
@interface XMMoodwallCell : UITableViewCell

@property (nonatomic, strong) UIImageView *backgroudImageView;
@property (nonatomic, strong) XMMoodwallModel *moodwallModel;

@end
