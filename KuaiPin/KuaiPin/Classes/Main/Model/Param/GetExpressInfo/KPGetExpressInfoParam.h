//
//  KPGetExpressInfoParam.h
//  KuaiPin
//
//  Created by 21_xm on 16/7/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"

@interface KPGetExpressInfoParam : KPBaseParam

/**
 *  快递公司编号
 */
@property (nonatomic, copy) NSString *expresscode;

/**
 *  运单号
 */
@property (nonatomic, copy) NSString *expresssn;



@end
