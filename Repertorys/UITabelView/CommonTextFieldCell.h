//
//  IJAddAttentionTextFieldCell.h
//  ijhealth
//
//  Created by xxb on 16/8/4.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommonTextFieldCellDelegate <NSObject>

-(void)textFieldChange:(NSString*)text key:(NSString*)key;
@optional
/**
 *  根据key来判断是否控制textField的输入长度
 */
-(NSInteger)textFieldMaxLengthWithKey:(NSString*)key;

@end

@interface CommonTextFieldCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;

@property (nonatomic, weak) id<CommonTextFieldCellDelegate> delegate;
/**
 *  设置值
 *
 *  @param item 满足
 @"key" : @"telephone",
 @"title" : @"手机号码",
 @"placeholder": @"请输入手机号码"
 */
-(void)setupValue:(NSDictionary*)item;
-(NSString*)getTextFieldValue;

@end
