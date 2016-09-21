//
//  KPOrderCommitViewController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPSubsidizeViewController.h"

@interface KPOrderCommitViewController : UIViewController

@property (nonatomic, strong) NSArray *dataModels;

@property (nonatomic, strong) id defaultReceiverModel;

@property (nonatomic, assign) CGFloat totalPrice;

@property (nonatomic, weak) KPSubsidizeViewController *popToSubsidizeVc;

@end
