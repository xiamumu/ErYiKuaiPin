//
//  NSArray+KPExtension.m
//  KuaiPin
//
//  Created by 王洪运 on 16/6/28.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "NSArray+KPExtension.h"

@implementation NSArray (KPExtension)

- (instancetype)insertSearchKeyword:(NSString *)keyword inIndex:(NSUInteger *)index {

    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([keyword isEqualToString:obj]) {
            [arr removeObject:obj];
        }
    }];

    [arr insertObject:keyword atIndex:0];

    return [arr copy];
}

@end
