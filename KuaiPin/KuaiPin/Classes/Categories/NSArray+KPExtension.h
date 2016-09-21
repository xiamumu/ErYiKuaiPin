//
//  NSArray+KPExtension.h
//  KuaiPin
//
//  Created by 王洪运 on 16/6/28.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KPExtension)

- (instancetype)insertSearchKeyword:(NSString *)keyword inIndex:(NSUInteger *)index;

@end
