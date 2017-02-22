//
//  IJAddAttentionTextFieldCell.m
//  ijhealth
//
//  Created by xxb on 16/8/4.
//  Copyright © 2016年 智业互联网络科技有限公司 艾嘉健康. All rights reserved.
//

#import "CommonTextFieldCell.h"
#import "SDAutoLayout.h"

@interface CommonTextFieldCell ()<UITextFieldDelegate>

@property (copy, nonatomic) NSString *key;

@end

@implementation CommonTextFieldCell

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
    _textField.delegate = self;
    [_textField addTarget:self  action:@selector(valueChanged)  forControlEvents:UIControlEventAllEditingEvents];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - UITextFieldDelegate

//控制长度，当按下的是删除键时，不会触发？
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //删除时会不会调??????
    if([self.delegate respondsToSelector:@selector(textFieldMaxLengthWithKey:)]){
        NSInteger maxLength = [self.delegate textFieldMaxLengthWithKey:_key];
        if(maxLength != 0){
            NSString *content = [NSString stringWithFormat:@"%@%@", textField.text, string];
            if(content.length > maxLength){
                return NO;
            }else{
                return YES;
            }
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

-(void)valueChanged{
    if([self.delegate respondsToSelector:@selector(textFieldChange:key:)]){
        [self.delegate textFieldChange:_textField.text key:_key];
    }
}

/**
 *  设置值
 *
 *  @param item 
 @param item 满足
 @"key" : @"telephone",
 @"title" : @"手机号码",
 @"placeholder": @"请输入手机号码"
 */
-(void)setupValue:(NSDictionary*)item{
    _titleLabel.text = item[@"title"];
    _key = item[@"key"];
    _textField.placeholder = item[@"placeholder"];
}

-(NSString*)getTextFieldValue{
    return _textField.text;
}

@end
