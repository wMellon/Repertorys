//
//  IJMyAttentionMsgCell.h
//  ijhealth
//
//  Created by xxb on 16/8/9.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCellModelProtocol.h"

@protocol OperableMsgDelegate <NSObject>

-(void)auditApply:(NSString*)applyId state:(NSInteger)state indexPath:(NSIndexPath *)indexPath;

@end

@interface OperableMsgCell : UITableViewCell

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *msgBodyView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *photoImage;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *resultLabel;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UIButton *agreeBtn;
@property (strong, nonatomic) UIButton *refuseBtn;
@property (strong, nonatomic) UIView *lineView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSObject<MsgCellModelProtocol> *model;
@property (nonatomic, weak) id<OperableMsgDelegate> delegate;


@end
