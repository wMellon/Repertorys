//
//  IJTextMsgCell.h
//  HealthyCity
//
//  Created by xxb on 16/10/24.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCellModelProtocol.h"

@interface TextMsgCell : UITableViewCell

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *msgBodyView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIImageView *toDetailImage;

@property (nonatomic, strong) NSObject<MsgCellModelProtocol> *model;

@end
