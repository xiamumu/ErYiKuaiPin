//
//  UIControl+KPExtension.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "UIControl+KPExtension.h"
#import <objc/runtime.h>



@implementation UIControl (KPExtension)

static const char *UIControl_acceptEventinterval = "UIControl_acceptEventinterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

+ (void)load {
    
    Method oldMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method newMethod = class_getInstanceMethod(self, @selector(new_sendAction:to:forEvent:));
    method_exchangeImplementations(oldMethod, newMethod);

}

- (void)new_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.ignoreEvent) return;
//    WHYNSLog(@"%f", self.acceptEventInterval);
    if (self.acceptEventInterval > 0) {
        
        self.ignoreEvent = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.ignoreEvent = NO;
        });
        
    }
    
    [self new_sendAction:action to:target forEvent:event];
    
}

#pragma mark - set方法
- (void)setAcceptEventInterval:(NSTimeInterval)interval {
    objc_setAssociatedObject(self, UIControl_acceptEventinterval, @(interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIgnoreEvent:(BOOL)ignore {
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(ignore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - get方法
- (NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, UIControl_acceptEventinterval) doubleValue];
}

- (BOOL)ignoreEvent {
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

@end
