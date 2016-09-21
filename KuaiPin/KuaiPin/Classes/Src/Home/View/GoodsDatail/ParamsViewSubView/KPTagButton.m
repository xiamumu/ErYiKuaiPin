//
//  KPTagButton.m
//  buttonTest
//
//  Created by 21_xm on 16/8/31.
//  Copyright © 2016年 sean.xia. All rights reserved.
//

#import "KPTagButton.h"
#import "UIImage+XM.h"

@implementation KPTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage resizedImage:@"sort_select"]forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage resizedImage:@"sort_unselect"]forState:UIControlStateNormal];
//        [self setBackgroundImage:[UIImage imageNamed:@"sort_select-no_specStorage"]forState:UIControlStateDisabled];
        [self setTitleColor:OrangeColor forState:UIControlStateSelected];
        [self setTitleColor:HexColor(8a8a8a) forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateSelected];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds = CGRectMake(0, 0, self.width, self.height);
    layer.masksToBounds = YES;
    layer.cornerRadius = 3;
    layer.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    layer.path = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    layer.lineWidth = 2. / [[UIScreen mainScreen] scale];
    //虚线边框
    layer.lineDashPattern = @[@5, @5];
    layer.fillColor = ClearColor.CGColor;
    layer.strokeColor = HexColor(8a8a8a).CGColor;
    [self.layer addSublayer:layer];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [super setBackgroundImage:image forState:state];
    if (state == UIControlStateSelected) {
        [self setTitleColor:[UIColor colorWithRed:255/255.0 green:109/255.0 blue:21/255.0 alpha:1] forState:state];
        
    } else if (state == UIControlStateNormal) {
        
        [self setTitleColor:[UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1] forState:state];
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    
    CGSize currentSize = CGSizeMake(size.width + 30, size.height + 10);
    
    [self setValue:[NSValue valueWithCGSize:currentSize] forKeyPath:@"size"];
    
    self.width = (currentSize.width > 65) ? currentSize.width : 65;
    
}

- (CGFloat)nextBtnWidthWithNextTitle:(NSString *)nextTitle
{
    return [nextTitle sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].width + 30;
}

- (void)setName:(NSString *)name
{
    _name = [name copy];
    [self setTitle:name forState:UIControlStateNormal];
}

- (void)setNameId:(NSString *)nameId
{
    _nameId = [nameId copy];
}
@end
