//
//  CURFormTableViewController.m－－带有增改查的表单逻辑
//  Repertory
//
//  Created by xxb on 16/8/2.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "CURFormTableViewController.h"

@interface CURFormTableViewController (){
    NSArray    *_viewConfig;
    Model *_newModel;
    Model *_oldModel;
    ViewStatus _viewStatus;
}

@end

@implementation CURFormTableViewController

#pragma mark - life cycle

/**
 *  初始化
 *
 *  @param model      可传nil，那么将通过[IJHealthManageViewModel getInitModel:MonitorType_BloodSugar]来初始化
 *  @param viewStatus 两个状态，编辑或查看
 *
 *  @return
 */
-(id)initWithModel:(Model*)model type:(ViewStatus)viewStatus{
    self = [super init];
    if(self){
        _newModel = model;
        _viewStatus = viewStatus;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  寄放这里而已，注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:textFieldCellID];
    */
    /**
     *  暂时放在这里，cell的属性
    tableView.separatorStyle = NO;//分隔线隐藏：
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell点击后不让出现选中状态：
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//点击后选中状态取消：
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;////添加向右的箭头
     //打勾
     cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.tableView.indicatorStyle=UIScrollViewIndicatorStyleWhite;//修改滚动条颜色
    self.tableView.showsVerticalScrollIndicator = NO;////隐藏垂直滚动条
    */
    
    //如果没有正确调用init方法的处理
    _newModel = _newModel ? : [ViewModel getInitModel];
    if(_viewStatus == 0){
        if(_newModel.modelId.length == 0){
            _viewStatus = ViewStatusNew;
        }else{
            _viewStatus = ViewStatusRetrieve;
        }
    }
    //判断是编辑还是新增
    if(_newModel.modelId.length == 0){
        _viewStatus = ViewStatusNew;
    }
    //只有在编辑（非新增情况）才需要
    if(_viewStatus == ViewStatusEdit){
        _oldModel = [_newModel copy];
    }
    //页面设置
    if(_viewStatus == ViewStatusRetrieve){
        self.title = @"详细信息";
        self.navigationItem.rightBarButtonItem = nil;
        _viewConfig = [self viewConfigWithTag:NO];
    }else{
        //编辑状态
        if(_viewStatus == ViewStatusNew){
            self.title = @"录入";
            _viewConfig = [self viewConfigWithTag:YES];
            self.navigationItem.rightBarButtonItem.enabled = true;
        }else{
            self.title = @"修改";
            _viewConfig = [self viewConfigWithTag:NO];
            self.navigationItem.rightBarButtonItem.enabled = false;
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStyleBordered) target:self action:@selector(saveData)];
    }
    [self.tableView reloadData];
}

#pragma mark -获取页面显示菜单项

- (NSArray *) viewConfigWithTag:(BOOL)isNew{
    NSArray *viewConfig;
    if(!isNew){
        viewConfig = @[
                       @{
                           @"key" : @"dataSourceName",
                           @"title" : @"数据来源"
                           }
                       ];
    }else{
        viewConfig = @[
                       @{
                           @"key" : @"monitorDate",
                           @"title" : @"日期"
                           }
                       ];
    }
    return viewConfig;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - delegate

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_viewConfig count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *item = _viewConfig[indexPath.row];
    cell.textLabel.text = [item objectForKey:@"title"];
    NSString *icon = [item objectForKey:@"icon"];
    if(icon.length > 0){
//        cell.imageView.image = LOADIMAGE(icon, @"png");
    }
    cell.detailTextLabel.text = [_newModel valueForKey:[item objectForKey:@"key"]];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //控制cell的可编辑状态
    cell.userInteractionEnabled = [self isCellCanEdit:item];
    return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - event

#pragma mark -保存

-(void)saveData{
    [self.view endEditing:YES];
    //保存动作完成之前，不许再次操作
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //完成后再开启
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark - action

#pragma mark -cell是否可以编辑

-(BOOL)isCellCanEdit:(NSDictionary*)dict{
    //时间
    if([dict[@"key"] isEqualToString:@"monitorTime"]){
        if(_viewStatus == ViewStatusNew){
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

#pragma mark -页面是否可以提交，会改变按钮是否可以点击（可以在每个值改变之后都去调用）

-(void)viewCanSave{
//    if([[_newModel mj_JSONString] isEqualToString:[_oldModel mj_JSONString]]){
//        //证明没改过
//        self.navigationItem.rightBarButtonItem.enabled = false;
//    }else{
//        self.navigationItem.rightBarButtonItem.enabled = true;
//    }
}

#pragma mark -合法性验证－－－在保存之前调用即可
-(BOOL)isViewValid{
    if(_newModel.data>10){
        //这里可以用HUD给用户抛出提示
        return NO;
    }
    //其它的合法验证
    return YES;
}
@end
