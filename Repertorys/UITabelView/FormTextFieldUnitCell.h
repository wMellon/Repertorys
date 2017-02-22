//
//  IJTextFieldUnitCell.h
//  HealthyCity
//
//  Created by xxb on 16/11/26.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import "FormCellDelegate.h"
#import "FormCellModelProtocol.h"

@interface FormTextFieldUnitCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UILabel *unitLabel;

@property (nonatomic, weak) id<FormCellDelegate> delegate;


/**
 设置值

 @param model 实体
 */
-(void)setupModel:(NSObject<FormCellModelProtocol>*)model;

/**
 设置值

 @param dict 字典，key至少带有：key,title,placeholder,value,unit这些
 @param value 值
 */
-(void)setupDict:(NSDictionary*)dict value:(NSString*)value;
@end
