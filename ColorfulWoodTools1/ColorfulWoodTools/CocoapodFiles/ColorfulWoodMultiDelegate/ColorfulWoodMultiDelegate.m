//
//  ColorfulWoodMultiDelegate.m
//  ColorfulWoodTools
//
//  Created by 大新 on 2018/6/6.
//  Copyright © 2018年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodMultiDelegate.h"

@implementation ColorfulWoodMultiDelegate

- (instancetype)init {

    if (self = [super init]) {
        _delegates = [NSPointerArray weakObjectsPointerArray];
    }

    return self;
}

- (void)interface_addDelegate:(id)delegate {

    [_delegates addPointer:(__bridge void*)delegate];
}

- (void)interface_removeDelegate:(id)delegate {

    NSUInteger index = [self func_indexOfDelegate:delegate];
    if (index != NSNotFound) {
        [_delegates removePointerAtIndex:index];
    }
    [_delegates compact];
}

- (NSUInteger)func_indexOfDelegate:(id)delegate {

    for (NSUInteger i = 0; i < _delegates.count; i += 1) {
        if ([_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}


@end
