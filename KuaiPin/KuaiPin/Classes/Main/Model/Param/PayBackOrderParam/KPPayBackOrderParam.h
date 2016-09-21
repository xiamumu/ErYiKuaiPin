//
//  KPPayBackOrderParam.h
//  KuaiPin
//
//  Created by 21_xm on 16/8/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPBaseParam.h"

@interface KPPayBackOrderParam :KPBaseParam


/**
 *  订单贴现状态
 */
@property (nonatomic, assign) NSInteger assetsState;


/**
 *  分页参数，不传就只显示一页
 */
//@property (nonatomic, assign) NSUInteger pageNumber;

@end
