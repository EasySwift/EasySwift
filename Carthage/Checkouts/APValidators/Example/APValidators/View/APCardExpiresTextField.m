//
// Created by Nickolay Sheika on 4/12/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APCardExpiresTextField.h"



@interface APCardExpiresTextField ()


@property(nonatomic, assign) BOOL hasDivider;
@end



@implementation APCardExpiresTextField


- (void)awakeFromNib
{
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange:(NSNotification *)notification
{
    NSString *currentText = self.text;
    NSUInteger currentTextLength = [currentText length];

    if (currentTextLength == 3 && ! self.hasDivider) {
        NSString *firstTwo = [currentText substringToIndex:2];
        NSString *lastOne = [currentText substringFromIndex:2];
        self.text = [NSString stringWithFormat:@"%@/%@", firstTwo, lastOne];
        self.hasDivider = YES;
    }
    else if (currentTextLength == 3 && self.hasDivider) {
        self.text = [currentText substringToIndex:2];
        self.hasDivider = NO;
    }
    else if (currentTextLength > 5) {
        self.text = [currentText substringWithRange:NSMakeRange(0, 5)];
    }
}


@end