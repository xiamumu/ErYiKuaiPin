//
//  KPBrandList.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPBrand : NSObject

/** 商家展示图 */
@property (nonatomic, copy) NSString *brandImage;

/** 商家文字介绍（标记） */
@property (nonatomic, copy) NSString *remark;

/** 商家头像 */
@property (nonatomic, copy) NSString *storeAvatar;

/** 商家名称 */
@property (nonatomic, copy) NSString *storeName;

/** 商家id */
@property (nonatomic, strong) NSNumber *storeId;

/** 关注人数 */
@property (nonatomic, strong) NSNumber *followCount;

/** 是否收藏 */
@property (nonatomic, strong) NSNumber *isCollection;

/** brandId */
@property (nonatomic, strong) NSNumber *brandId;

@end
