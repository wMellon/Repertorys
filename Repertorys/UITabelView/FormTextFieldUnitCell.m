//
//  IJTextFieldUnitCell.m
//  HealthyCity
//
//  Created by xxb on 16/11/26.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import "FormTextFieldUnitCell.h"

@interface FormTextFieldUnitCell()<UITextFieldDelegate>

@property (copy, nonatomic) NSString *key;

@end

@implementation FormTextFieldUnitCell

-(id)init{
    self = [super init];
    if(self){
        [self addElements];
        [self autoLayout];
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self addElements];
        [self autoLayout];
    }
    return self;
}

-(void)addElements{
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.textField = [[UITextField alloc] init];
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [self.contentView addSubview:self.textField];
    
    _unitLabel = [[UILabel alloc] init];
    _unitLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_unitLabel];
}

-(void)autoLayout{
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(self.titleLabel.font.lineHeight)
    .widthIs(120);
    
    self.textField.sd_layout
    .leftSpaceToView(self.titleLabel, 0)
    .widthIs(44)
    .centerYEqualToView(self.contentView)
    .heightIs(self.textField.font.lineHeight);
    
    _unitLabel.sd_layout
    .leftSpaceToView(self.titleLabel, 49)
    .centerYEqualToView(self.contentView)
    .heightIs(_unitLabel.font.lineHeight)
    .widthIs(21);
}

-(void)valueChanged:(id)sender{
    if([self.delegate respondsToSelector:@selector(textFieldChange:key:textField:)]){
        [self.delegate textFieldChange:_textField.text key:_key textField:self.textField];
        if(_textField.text.length <= 0){
            self.textField.sd_layout.widthIs(100);
            _unitLabel.hidden = YES;
        }else{
            self.textField.sd_layout.widthIs(44);
            _unitLabel.hidden = NO;
        }
    }
    
}

-(void)setupModel:(NSObject<FormCellModelProtocol>*)model{
    _key = model.key;
    _titleLabel.text = model.title;
    _textField.placeholder = model.placeholder;
    _textField.text = model.value;
    _unitLabel.text = model.unit;
    if(model.value.length <= 0){
        _textField.sd_layout.widthIs(100);
        _textField.text = @"";
        _unitLabel.hidden = YES;
    }else{
        _textField.sd_layout.widthIs(44);
        _textField.text = model.value;
        _unitLabel.hidden = NO;
    }
}

-(void)setupDict:(NSDictionary*)dict value:(NSString*)value{
    NSObject<FormCellModelProtocol> *obj = [NSObject<FormCellModelProtocol> yy_modelWithJSON:dict];
    obj.value = value;
    [self setupModel:obj];
}

@end
