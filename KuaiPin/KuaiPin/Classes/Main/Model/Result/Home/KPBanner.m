//
//  KPBannerList.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBanner.h"

@implementation KPBanner

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"productId": @"id", @"image": @"src", @"goodsId": @"productId"};
}

- (void)setShareSrc:(NSString *)shareSrc {
    _shareUrl = [shareSrc copy];

    if (self.icon) return;

    NSURL *url = [NSURL URLWithString:shareSrc];
    SDWebImageOptions options = SDWebImageRefreshCached | SDWebImageRetryFailed;

    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:url
                                                    options:options
                                                   progress:nil
                                                  completed:^(UIImage *image,
                                                              NSError *error,
                                                              SDImageCacheType cacheType,
                                                              BOOL finished,
                                                              NSURL *imageURL) {
                                                      weakSelf.icon = image;
                                                  }];
}

@end
