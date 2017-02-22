//
//  IJMyAttentionMsgCell.m
//  ijhealth
//
//  Created by xxb on 16/8/9.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import "OperableMsgCell.h"
#import "SDAutoLayout.h"

@implementation OperableMsgCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textColor = COLOR(153, 153, 153, 100);
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    
    _msgBodyView = [[UIView alloc] init];
    _msgBodyView.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = COLOR(34, 34, 34, 100);
    
    _photoImage = [[UIImageView alloc] init];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = COLOR(102, 102, 102, 100);
    
    _resultLabel = [[UILabel alloc] init];
    _resultLabel.font = [UIFont systemFontOfSize:15];
    _resultLabel.textColor = COLOR(153, 153, 153, 100);
    _resultLabel.textAlignment = NSTextAlignmentRight;
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = COLOR(204, 204, 204, 100);
    
    _buttonView = [[UIView alloc] init];
    _buttonView.backgroundColor = [UIColor whiteColor];
    
    _refuseBtn = [[UIButton alloc] init];
    _refuseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_refuseBtn setBackgroundColor:[UIColor clearColor]];
    [_refuseBtn setTitleColor:COLOR(153, 153, 153, 100) forState:UIControlStateNormal];
    _refuseBtn.layer.cornerRadius = 4;
    _refuseBtn.layer.borderWidth = 1;
    _refuseBtn.layer.borderUIColor = COLOR(204, 204, 204, 100);
    [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_refuseBtn addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];

    _agreeBtn = [[UIButton alloc] init];
    _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_agreeBtn setBackgroundColor:COLOR(0, 162, 255, 100)];
    [_agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _agreeBtn.layer.cornerRadius = 4;
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeBtn addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_buttonView sd_addSubviews:@[_agreeBtn,_refuseBtn]];
    [_msgBodyView sd_addSubviews:@[_photoImage, _titleLabel, _resultLabel, _contentLabel, _lineView, _buttonView]];
    [self.contentView sd_addSubviews:@[_dateLabel,_msgBodyView]];
    
    [self autoLayout];
}

-(void)autoLayout{
    _dateLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 17)
    .heightIs(_dateLabel.font.lineHeight);
    
    _photoImage.sd_layout
    .leftSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_msgBodyView, 15)
    .widthIs(45)
    .heightIs(45);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_photoImage, 10)
    .rightSpaceToView(_resultLabel, 0)
    .topSpaceToView(_msgBodyView, 17)
    .heightIs(_titleLabel.font.lineHeight);
    
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .rightSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_titleLabel, 17)
    .autoHeightRatio(0);//高度自适应
//    [_contentLabel setMaxNumberOfLinesToShow:2];
    
    _resultLabel.sd_layout
    .rightSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_msgBodyView, 18)
    .heightIs(_resultLabel.font.lineHeight);
    [_resultLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _lineView.sd_layout
    .leftEqualToView(_photoImage)
    .rightSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_contentLabel, 10)
    .heightIs(0.5);//top在下面设置
    
    _refuseBtn.sd_layout
    .heightRatioToView(_buttonView, 1);
    
    _agreeBtn.sd_layout
    .heightRatioToView(_buttonView, 1);
    
    _buttonView.sd_layout
    .rightSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_lineView, 10)
    .widthIs(165)
    .heightIs(30);//y在下面设置
    [_buttonView setupAutoWidthFlowItems:@[_refuseBtn, _agreeBtn] withPerRowItemsCount:2 verticalMargin:0 horizontalMargin:15 verticalEdgeInset:0 horizontalEdgeInset:0];
    
    _msgBodyView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(_dateLabel, 15);
    [_msgBodyView setSd_cornerRadius:@(5)];
    
    [_msgBodyView setupAutoHeightWithBottomView:_buttonView bottomMargin:15];
    [self setupAutoHeightWithBottomView:_msgBodyView bottomMargin:0];
}

- (void)setModel:(NSObject<MsgCellModelProtocol>*)model{
    _dateLabel.text = model.date;
//    [_photoImage sd_setImageWithURL:[NSURL URLWithString:model.portraitImageUrlStr] placeholderImage:LOADIMAGE(@"head_userDefault@2x", @"png")options:SDWebImageRefreshCached];
    _titleLabel.text = model.title;
//    //姓名&电话
//    NSString *namePhone = @"";
//    if(![NSString isBlankString:model.extendData[@"userName"]] &&
//       ![NSString isBlankString:model.extendData[@"telephone"]]){
//        namePhone = [NSString stringWithFormat:@"%@ (%@)",model.extendData[@"userName"], model.extendData[@"telephone"]];
//    }else if([NSString isBlankString:model.extendData[@"userName"]]){
//        namePhone = model.extendData[@"telephone"];
//    }else if([NSString isBlankString:model.extendData[@"telephone"]]){
//        namePhone = model.extendData[@"userName"];
//    }
//    //content设置值并且设置约束
//    _contentLabel.text = [NSString stringWithFormat:@"%@申请添加您成为他的关心的人。", namePhone];
//    
//    //理论上不用执行下面这三句的，时间紧迫，先这样
//    [_contentLabel updateLayout];
//    [_msgBodyView updateLayout];
//    [self updateLayout];
//    
//    //别人添加我为关心的人
//    if([model.remarkDict[RemarkOperation] integerValue] ==
//       OperationCellInit){
//        //初始状态
//        _resultLabel.text = @"待审批";
//        _buttonView.hidden = NO;
//        _lineView.hidden = NO;
//        [_msgBodyView setupAutoHeightWithBottomView:_buttonView bottomMargin:15];
//    }else{
//        //审核完成
//        _resultLabel.hidden = NO;
//        _buttonView.hidden = YES;
//        _lineView.hidden = YES;
//        if([model.remarkDict[RemarkOperation] integerValue] ==
//           OperationCellAgree){
//            _resultLabel.text = @"已同意";
//        }else if([model.remarkDict[RemarkOperation] integerValue] ==
//                 OperationCellRefuse){
//            _resultLabel.text = @"已拒绝";
//        }
//        [_msgBodyView setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
//    }
//    [self setupAutoHeightWithBottomView:_msgBodyView bottomMargin:0];
}

#pragma mark - event

- (void)agree {
    if([self.delegate respondsToSelector:@selector(auditApply:state:indexPath:)]){
//        [self.delegate auditApply:_model.extendData[@"applyId"] state:OperationCellAgree indexPath:_indexPath];
    }
}

- (void)refuse {
    if([self.delegate respondsToSelector:@selector(auditApply:state:indexPath:)]){
//        [self.delegate auditApply:_model.extendData[@"applyId"] state:OperationCellRefuse indexPath:_indexPath];
    }
}

@end
