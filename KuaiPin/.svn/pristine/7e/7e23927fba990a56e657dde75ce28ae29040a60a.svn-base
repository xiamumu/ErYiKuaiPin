//
//  KPHoomeRowData.h
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, KPHomeRowDataType) {
    KPHomeRowDataTypeDefault,
    KPHomeRowDataTypeGoods,
    KPHomeRowDataTypeBrand,
};


@interface KPHomeRowData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *headerImageName;
@property (nonatomic, strong) NSArray *scrollImages;
@property (nonatomic, strong) NSArray *goods;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, assign) KPHomeRowDataType rowDataType;

@property (nonatomic, assign) CGFloat cellHeight;


+ (instancetype)initWithTitle:(NSString *)title headerImageName:(NSString *)imageNmae type:(KPHomeRowDataType)homeRowDataType;
+ (instancetype)initWithTitle:(NSString *)title type:(KPHomeRowDataType)homeRowDataType;

@end
