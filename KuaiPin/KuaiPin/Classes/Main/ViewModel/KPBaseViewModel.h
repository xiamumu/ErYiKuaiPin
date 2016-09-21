//
//  KPBaseViewModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPBaseViewModelCommonProtocol.h"
#import "Singleton.h"

@interface KPBaseViewModel : NSObject<KPBaseViewModelCommonProtocol>

@property (nonatomic, strong) id data;

/// ViewModel的单例方法
///
/// @return ViewModel的单例
singleton_interface(ViewModel)

@end
