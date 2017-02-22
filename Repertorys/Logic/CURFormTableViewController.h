//
//  CURFormTableViewController.h－－带有增改查的表单逻辑
//  Repertory
//
//  Created by xxb on 16/8/2.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

//为实现逻辑而生的类

/**
 *  Model类
 */
@interface Model : NSObject<NSCopying>

@property(nonatomic, copy) NSString *modelId;
@property (assign, nonatomic) float data;

@end

@implementation Model

- (id)copyWithZone:(nullable NSZone *)zone{
    Model *copy = [[[self class] allocWithZone:zone] init];
    //这里用深拷贝，以防：父类的字符串被赋值成可变字符串类型，然后加以修改
    copy.modelId = [self.modelId copyWithZone:zone];
    copy.data = self.data;
    return copy;
}

@end


/**
 *  viewModel类－－－－负责初始化
 */
@interface ViewModel : NSObject

+(Model*)getInitModel;

@end

@implementation ViewModel

+(Model*)getInitModel{
    Model *model = [[Model alloc] init];
    model.data = 5.0;
    return model;
}

@end

//定义表单当前的状态：编辑or查看
typedef enum{
    ViewStatusEdit = 1,
    ViewStatusRetrieve = 2,
    ViewStatusNew = 3   //外面调用的时候，可以只设置edit就行
}ViewStatus;

@interface CURFormTableViewController : UITableViewController

/**
 *  初始化
 *
 *  @param model      可传nil，那么将通过[IJHealthManageViewModel getInitModel:MonitorType_BloodSugar]来初始化
 *  @param viewStatus 两个状态，编辑或查看
 *
 *  @return
 */
-(id)initWithModel:(Model*)model type:(ViewStatus)viewStatus;

@end
