//
//  KPOrderCommitBottomTool.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommitHandler)();

@interface KPOrderCommitBottomTool : UIView

@property (nonatomic, copy) void (^commitHandler)();

@property (nonatomic, assign) CGFloat actualPrice;

+ (instancetype)orderCommitBottomToolWithCommitHandler:(CommitHandler)commitHandler;

+ (CGFloat)orderCommitBottomToolHeight;



@end
