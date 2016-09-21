//
//  KPSelecteGoodButton.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPSelecteGoodButtonType) {
    KPSelecteGoodButtonTypeSelectedAll,
    KPSelecteGoodButtonTypeVendorSelectedAll,
    KPSelecteGoodButtonTypeSelectedGood,
};

@interface KPSelecteGoodButton : KPButton

@property (nonatomic, assign) KPSelecteGoodButtonType selecteType;

+ (instancetype)selecteGoodButtonWithType:(KPSelecteGoodButtonType)selecteType;


@end
