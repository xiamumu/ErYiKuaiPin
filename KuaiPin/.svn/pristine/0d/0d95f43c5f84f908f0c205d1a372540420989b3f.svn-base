//
//  KPBaseModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AutoCoding.h>
#import <MJExtension.h>

@interface KPBaseModel : NSObject<NSCopying>

// 通过文件名创建一个文档路径
+ (NSString *)documentPathWithFileName:(NSString *)fileName;

// 通过文件名创建一个临时文档路径
+ (NSString *)tempPathWithFileName:(NSString *)fileName;

// 将模型写入指定的路径下
- (BOOL)writeModelToPath:(NSString *)path;

// 从指定的路径下读取模型
+ (instancetype)readModleWithPath:(NSString *)path;

@end
