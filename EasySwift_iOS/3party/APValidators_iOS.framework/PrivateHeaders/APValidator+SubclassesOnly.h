//
// Created by Nickolay Sheika on 4/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APValidator.h"



@interface APValidator (SubclassesOnly)

@property(nonatomic, assign, getter=isValid, readwrite) BOOL valid;
@end