//
//  FormCellProtocol.h
//  HealthyCity
//
//  Created by zoenet on 2017/2/16.
//  Copyright © 2017年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

@protocol FormCellDelegate <NSObject>

/**
 文本改变后触发的事件
 
 @param text 改变后的文本
 @param key key
 */
-(void)textFieldChange:(NSString*)text key:(NSString*)key;

/**
 文本改变后触发的事件，带textField实体版本

 @param text 改变后的文本
 @param key key
 @param textField textField
 */
-(void)textFieldChange:(NSString*)text key:(NSString*)key textField:(UITextField*)textField;
/**
 *  根据key来判断是否控制textField的输入长度
 *
 *  @param key
 *
 *  @return
 */
-(NSInteger)textFieldMaxLengthWithKey:(NSString*)key;

@end
