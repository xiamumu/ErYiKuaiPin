//
//  KPUploadParam.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/20.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPUploadParam.h"

@implementation KPUploadParam

- (NSString *)MIMEType {
    return @"application/octet-stream";
}

- (NSString *)name {
    return @"images";
}

@end
