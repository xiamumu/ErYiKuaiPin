//
//  KPResultModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/19.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseModel.h"

@class KPDataModel;

@interface KPResultModel : KPBaseModel

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) __kindof KPDataModel *data;

@end
