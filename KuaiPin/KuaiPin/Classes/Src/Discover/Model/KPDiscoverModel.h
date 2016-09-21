//
//  KPDiscoverModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseModel.h"

@interface KPDiscoverModel : KPBaseModel

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) UIImage *iconImg;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *timeStr;

@property (nonatomic, strong) NSNumber *addTime;

@end
