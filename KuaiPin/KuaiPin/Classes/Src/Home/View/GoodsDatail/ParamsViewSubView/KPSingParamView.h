//
//  KPSingParamView.h
//  KuaiPin
//
//  Created by 21_xm on 16/8/31.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPTagButton.h"
@class KPProductSpec;



@interface KPSingParamView : UIView

@property (nonatomic, assign) int specSign;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *subTitles;

@property (nonatomic, strong) NSArray *subTitlesId;

@property (nonatomic, weak) KPTagButton *selectedSpec;


//**************************************************************//
// 设置存储的参数
/**
 *  已选中的商品的规格参数
 */
@property (nonatomic, copy) NSString *selectedTagSpec;

//**************************************************************//
// 设置存储的参数
/**
 *  无库存的商品的规格参数
 */
@property (nonatomic, copy) NSString *noStorageSpec;

//**************************************************************//


/***  不同类别下所有可能的商品组合 */
@property (nonatomic, strong) NSArray <KPProductSpec *> *productSpecList;

+ (instancetype)singParamView;

@end
