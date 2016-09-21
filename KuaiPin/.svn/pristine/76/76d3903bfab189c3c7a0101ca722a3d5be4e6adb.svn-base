//
//  KPDiscoverModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPDiscoverModel.h"

const CGFloat kIconH = 141;
const CGFloat kIconW = 340;

@implementation KPDiscoverModel
{
    UIImage *_iconImg;
}

- (void)setAddTime:(NSNumber *)addTime {
    
    _addTime = addTime;
    
    NSTimeInterval time = addTime.integerValue / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd-HH-mm";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString *tempStr = [formatter stringFromDate:date];
    
    NSArray *arr = [tempStr componentsSeparatedByString:@"-"];
    
    self.timeStr = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@", arr[0], arr[1], arr[2], arr[3], arr[4]];
    
}

- (void)setIconImg:(UIImage *)iconImg {

    CGFloat iconH = kIconH;
    CGFloat iconW = kIconW;

    if (iconImg.size.height > kIconH) {
        iconW = iconImg.size.width * kIconH / iconImg.size.height;
    }

    if (iconW > kIconW) {
        iconH = iconImg.size.height * kIconW / iconImg.size.width;
        iconW = kIconW;
    }

    iconH = ScaleHeight(iconH);
    iconW = ScaleWidth(iconW);

    _iconImg = [UIImage OriginImage:iconImg scaleToSize:CGSizeMake(iconW, iconH)];

}

- (UIImage *)iconImg {
    if (_iconImg == nil) {
        _iconImg = [UIImage imageNamed:@"find_Placeholder"];
    }
    return _iconImg;
}

@end
