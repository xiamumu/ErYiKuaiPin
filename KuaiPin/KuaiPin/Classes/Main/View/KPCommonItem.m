//
//  KPCommonItem.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCommonItem.h"

@implementation KPCommonItem

+ (KPCommonItem *)initWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    KPCommonItem *btn = [[KPCommonItem alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    return btn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:HexColor(#8a8a8a) forState:UIControlStateNormal];
        self.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = UIFont_10;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((self.width - self.currentImage.size.width) * 0.5, 0, self.currentImage.size.width, self.currentImage.size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.currentImage.size.height, self.width, self.height - self.currentImage.size.height);
}

@end
