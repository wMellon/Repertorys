//
//  XBMsgCellModelProtocol.h
//  Repertorys
//
//  Created by xxb on 17/2/20.
//  Copyright © 2017年 xxb. All rights reserved.
//
@protocol MsgCellModelProtocol <NSObject>

@optional
@property (copy, nonatomic) NSString *date;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSAttributedString *titleAttr;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSAttributedString *attributeContent;

//TextMsgCell
@property (copy, nonatomic) NSString *statusName;
@property (assign, nonatomic) BOOL isRightTo;

//ImageTextMsgCell
@property (copy, nonatomic) NSString *imageUrlStr;

//OperableMsgCell
@property (copy, nonatomic) NSString *portraitImageUrlStr;

@end
