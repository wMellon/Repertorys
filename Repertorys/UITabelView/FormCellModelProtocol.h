//
//  FormCellModelProtocol.h
//  HealthyCity
//
//  Created by zoenet on 2017/2/17.
//  Copyright © 2017年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

@protocol FormCellModelProtocol <NSObject>

@optional
@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *placeholder;
@property (copy, nonatomic) NSString *value; //textField的值
@property (copy, nonatomic) NSString *unit;//单位

@end
