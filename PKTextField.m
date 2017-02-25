//
//  PKTextField.m
//  HelpSell
//
//  Created by pk on 2017/1/19.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "PKTextField.h"

@implementation PKTextField

- (instancetype)init{
    self = [super init];
    if (self) {
        self.allowInputLength = CGFLOAT_MAX;
        [self addTarget:self action:@selector(textFieldEditChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.allowInputLength = CGFLOAT_MAX;
    [self addTarget:self action:@selector(textFieldEditChanged) forControlEvents:UIControlEventEditingChanged];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2.5;
    self.layer.borderWidth = 0.5;
    self.borderStyle = UITextBorderStyleNone;
}

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (enabled == YES) {
        self.layer.borderColor = [UIColor colorFromHexRGB:@"999999" alpha:1.0].CGColor;
        
        CGRect frame = self.frame;
        frame.size.width = 5.0;
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftview;

        CGRect rightFrame = CGRectMake(0,0,5, self.bounds.size.height);
        UIView * rightView = [[UIView alloc] initWithFrame:rightFrame];
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = rightView;
       
        
    }else{
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.leftView = nil;
        self.rightView = nil;
    }
}

-(void)textFieldEditChanged
{
    UITextField *textField = self;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > self.allowInputLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.allowInputLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:self.allowInputLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.allowInputLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


@end
