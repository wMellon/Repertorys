//
//  IJNotifyTableViewCell.h
//  IJHealth
//
//  Created by xxb on 16/3/1.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCellModelProtocol.h"

@interface ImageTextMsgCell : UITableViewCell

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *msgBodyView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *contentLabel;

@property (nonatomic, strong) NSObject<MsgCellModelProtocol> *model;

@end
