//
//  KPProgressHUD.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPProgressHUD.h"
#import <MBProgressHUD.h>
#import <SVIndefiniteAnimatedView.h>

static BOOL isShowLoading = NO;

const NSTimeInterval delay = 1.0;

@interface KPProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *loadingHUD;

@end

@implementation KPProgressHUD

+ (void)showLoading {

    if (!isShowLoading) [self setupLoadingView];

    isShowLoading = YES;

}

+ (void)hideLoading {

    if (isShowLoading) {
        KPProgressHUD *hud = [KPProgressHUD sharedHUD];
        [hud.loadingHUD hideAnimated:YES];
        hud.loadingHUD = nil;
    }

    isShowLoading = NO;
}

+ (BOOL)isShowLoading {
    return isShowLoading;
}

#pragma mark - 扩展类方法
+ (void)showErrorWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval{
    [self showErrorWithStatus:status timeInterval:delay completion:nil];
}

+ (void)showSuccessWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval{
    [self showSuccessWithStatus:status timeInterval:delay completion:nil];
}

+ (void)showErrorWithStatus:(NSString *)status completion:(void(^)())completion {
    [self showErrorWithStatus:status timeInterval:delay completion:completion];
}

+ (void)showSuccessWithStatus:(NSString *)status completion:(void(^)())completion {
    [self showSuccessWithStatus:status timeInterval:delay completion:completion];
}

+ (void)showSuccessWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval completion:(void (^)())completion {

    [self showSuccessWithStatus:status];

    [self setMinimumDismissTimeInterval:interval];

    void (^block)() = ^(){};
    if (completion) block = [completion copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        block();

    });

}

+ (void)showErrorWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval completion:(void (^)())completion {

    [self showErrorWithStatus:status];

    [self setMinimumDismissTimeInterval:interval];

    void (^block)() = ^(){};
    if (completion) block = [completion copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        block();

    });

}

#pragma mark - 私有方法
+ (void)setupLoadingView {

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    if (keyWindow == nil) return;

    KPProgressHUD *KPHUD = [KPProgressHUD sharedHUD];
    KPHUD.loadingHUD = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    KPHUD.loadingHUD.bezelView.color = [UIColor whiteColor];
    KPHUD.loadingHUD.mode = MBProgressHUDModeCustomView;

    SVIndefiniteAnimatedView *indefiniteAnimatedView = [SVIndefiniteAnimatedView new];
    indefiniteAnimatedView.strokeColor = BlackColor;
    indefiniteAnimatedView.strokeThickness = 2.0;
    indefiniteAnimatedView.radius = 12;
    if([indefiniteAnimatedView respondsToSelector:@selector(startAnimating)]) {
        [(id)indefiniteAnimatedView startAnimating];
    }
    indefiniteAnimatedView.center = CGPointMake(KPHUD.loadingHUD.width * 0.5, KPHUD.loadingHUD.height * 0.5);

    KPHUD.loadingHUD.customView = indefiniteAnimatedView;

}

#pragma mark - 重写父类方法
+ (void)showImage:(UIImage*)image status:(NSString*)status {
    [self setMinimumDismissTimeInterval:delay];
    [super showImage:image status:status];
}

- (SVProgressHUDMaskType)defaultMaskType {
    return SVProgressHUDMaskTypeBlack;
}

singleton_implementation(HUD)

@end
