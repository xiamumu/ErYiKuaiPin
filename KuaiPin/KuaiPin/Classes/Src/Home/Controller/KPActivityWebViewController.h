//
//  KPActivityWebViewController.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/19.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface KPActivityWebViewController : UIViewController

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, copy) NSString *html;

@property (nonatomic, weak) WKWebView *webView;

@property (nonatomic, strong) UIImage *sharedImg;

@property (nonatomic, copy) NSString *sharedMessage;

@property (nonatomic, copy) NSString *sharedTitle;

@property (nonatomic, copy) NSString *sharedImgSrc;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, assign) BOOL hideSharedButton;

@property (nonatomic, strong) NSArray<NSString *> *jsStrs;

- (void)addBarRightButtonActionWithTitle:(NSString *)title action:(void(^)())action;

- (void)loadGoodDetailWithURLStr:(NSString *)urlStr completion:(void(^)(CGFloat webViewH))completion;

@end
