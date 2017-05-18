//
//  IJAddAttentionTextFieldCell.m
//  ijhealth
//
//  Created by xxb on 16/8/4.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import "FormTextFieldCell.h"

@interface FormTextFieldCell ()<UITextFieldDelegate>

@property (copy, nonatomic) NSString *key;
@property (assign, nonatomic) NSInteger oldLength;

@end

@implementation FormTextFieldCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont systemFontOfSize:14];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged) name:@"UITextFieldTextDidChangeNotification" object:nil];
    [self.contentView addSubview:_textField];
}

-(void)autoLayout{
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(_titleLabel.font.lineHeight)
    .widthIs(120);
    
    _textField.sd_layout
    .leftSpaceToView(_titleLabel, 0)
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(_textField.font.lineHeight);
}

-(void)setShowRightArrow:(BOOL)show{
    if(show){
        //右边间距不设置
        _textField.sd_layout
        .rightSpaceToView(self.contentView, 0);
    }else{
        _textField.sd_layout
        .rightSpaceToView(self.contentView, 15);
    }
    [_textField updateLayout];
}

-(void)valueChanged{
    //控制长度
    NSInteger errorCode = 0;
    if([self.delegate respondsToSelector:@selector(textFieldMaxLengthWithKey:)]){
        NSInteger maxLength = [self.delegate textFieldMaxLengthWithKey:_key];
        if(maxLength != 0){
            NSString *content = _textField.text;
            NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
            if ([lang isEqualToString:@"zh-Hans"]) {
                // 简体中文输入，包括简体拼音，健体五笔，简体手写
                //获取高亮部分
                UITextRange *selectedRange = [_textField markedTextRange];
                UITextPosition *position = [_textField positionFromPosition:selectedRange.start offset:0];
                if(!position){
                    if([_textField.text dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)].length > maxLength){
                        _textField.text = [_textField.text substringToIndex:self.oldLength];
                        errorCode = FormCellLengthError;
                    }else{
                        self.oldLength = _textField.text.length;
                    }
                }
            }else{
                if([_textField.text dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)].length > maxLength){
                    _textField.text = [_textField.text substringToIndex:self.oldLength];
                    errorCode = FormCellLengthError;
                }else{
                    self.oldLength = _textField.text.length;
                }
            }
        }
    }
    if([self.delegate respondsToSelector:@selector(textFieldChange:key:textField:errorCode:)]){
        [self.delegate textFieldChange:_textField.text key:_key textField:self.textField errorCode:errorCode];
    }else if([self.delegate respondsToSelector:@selector(textFieldChange:key:textField:)]){
        [self.delegate textFieldChange:_textField.text key:_key textField:self.textField];
    }
}

-(void)setupModel:(NSObject<FormCellModelProtocol>*)model{
    _key = model.key;
    _titleLabel.text = model.title;
    _textField.placeholder = model.placeholder;
    _textField.text = model.value;
}


-(void)setupByDict:(NSDictionary*)item value:(NSString*)value{
    _key = item[@"key"];
    _titleLabel.text = item[@"title"];
    _textField.placeholder = item[@"placeholder"];
    _textField.text = value;
}

@end
