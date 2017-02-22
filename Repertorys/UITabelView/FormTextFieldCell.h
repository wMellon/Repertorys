//
//  IJAddAttentionTextFieldCell.h
//  ijhealth
//
//  Created by xxb on 16/8/4.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormCellDelegate.h"
#import "FormCellModelProtocol.h"

@interface FormTextFieldCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) BOOL showRightArrow;//是否显示向右的箭头

@property (nonatomic, weak) id<FormCellDelegate> delegate;
/**
 *  设置值
 *
 *  @param item 字典，key至少带有：key,title,placeholder这些
 *  @param value 值
 */
-(void)setupByDict:(NSDictionary*)item value:(NSString*)value;
/**
 设置值
 
 @param model 实体
 */
-(void)setupModel:(NSObject<FormCellModelProtocol>*)model;

@end
