//
//  KPBaseModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseModel.h"

@implementation KPBaseModel

+ (instancetype)readModleWithPath:(NSString *)path {
    return [self objectWithContentsOfFile:path];
}

- (BOOL)writeModelToPath:(NSString *)path {
    return [self writeToFile:path atomically:YES];
}

+ (NSString *)documentPathWithFileName:(NSString *)fileName {
    return [[self documentsDirectory] stringByAppendingPathComponent:fileName];
}

+ (NSString *)tempPathWithFileName:(NSString *)fileName {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    
    Class cls = [self class];
    id copy = [[cls allocWithZone:zone] init];
    return copy;
}

@end
