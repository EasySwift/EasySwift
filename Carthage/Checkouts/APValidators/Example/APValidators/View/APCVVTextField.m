//
// Created by Nickolay Sheika on 4/13/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APCVVTextField.h"



@implementation APCVVTextField

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
    if ([self.text length] > 3) {
        self.text = [self.text substringWithRange:NSMakeRange(0, 3)];
    }
}

@end