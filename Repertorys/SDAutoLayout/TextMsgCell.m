//
//  IJTextMsgCell.m
//  HealthyCity
//
//  Created by xxb on 16/10/24.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.

#import "TextMsgCell.h"
#import "SDAutoLayout.h"

@implementation TextMsgCell

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
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = COLOR(102, 102, 102, 100);
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont systemFontOfSize:15];
    _statusLabel.textColor = COLOR(153, 153, 153, 100);
    _statusLabel.textAlignment = NSTextAlignmentRight;
    
    _toDetailImage = [[UIImageView alloc] init];
    _toDetailImage.image = [UIImage imageNamed:@"Msg_Arrow_Right"];
    
    [_msgBodyView sd_addSubviews:@[_titleLabel,_statusLabel,_contentLabel,_toDetailImage]];
    
    [self.contentView sd_addSubviews:@[_dateLabel,_msgBodyView]];
    
    [self autoLayout];
}

-(void)autoLayout{
    _dateLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 17)
    .heightIs(_dateLabel.font.lineHeight);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_msgBodyView, 13)
    .rightSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_msgBodyView, 17)
    .heightIs(_titleLabel.font.lineHeight);
    
    _statusLabel.sd_layout
    .rightSpaceToView(_msgBodyView, 13)
    .topSpaceToView(_msgBodyView, 18)
    .heightIs(_statusLabel.font.lineHeight);
    [_statusLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _toDetailImage.sd_layout
    .rightSpaceToView(_msgBodyView, 13)
    .centerYEqualToView(_msgBodyView)
    .widthIs(8)
    .heightIs(15);
    
    _contentLabel.sd_layout
    .leftSpaceToView(_msgBodyView, 13)
    .rightSpaceToView(_toDetailImage, 10)
    .topSpaceToView(_titleLabel, 17)
    .autoHeightRatio(0);
    _contentLabel.isAttributedContent = YES;
    
    _msgBodyView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(_dateLabel, 15);
    [_msgBodyView setSd_cornerRadius:@(5)];
    [_msgBodyView setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
    
    [self setupAutoHeightWithBottomView:_msgBodyView bottomMargin:0];
}

- (void)setModel:(NSObject<MsgCellModelProtocol>*)model{
    self.dateLabel.text = model.date;
    //title
    if(model.titleAttr){
        self.titleLabel.attributedText = model.titleAttr;
    }else{
        self.titleLabel.text = model.title;
    }

    if(model.statusName.length > 0){
        _statusLabel.text = model.statusName;
    }else{
        _statusLabel.text = @"";
    }
    
    if(model.isRightTo){
        _toDetailImage.hidden = NO;
        _contentLabel.sd_layout
        .rightSpaceToView(_toDetailImage, 10);
    }else{
        _toDetailImage.hidden = YES;
        _contentLabel.sd_layout
        .rightSpaceToView(_msgBodyView, 13);
    }
    //缩略文/详情
    if(model.attributeContent){
        self.contentLabel.attributedText = model.attributeContent;
    }else{
        //默认用html来显示
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _contentLabel.attributedText = attrStr;
    }
    
//    [_msgBodyView setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
//    [self setupAutoHeightWithBottomView:_msgBodyView bottomMargin:0];
}

@end
