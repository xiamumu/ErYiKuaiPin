//
//  KPGoodsListTopView.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPGoodsListTopView;

@protocol KPGoodsListTopViewDelegate <NSObject>

- (void)goodsListTopView:(KPGoodsListTopView *)topView didSelectLeftBtn:(KPButton *)leftBtn;

- (void)goodsListTopView:(KPGoodsListTopView *)topView didSelectRightBtn:(KPButton *)rightBtn leftBtn:(KPButton *)leftBtn;

@end

@interface KPGoodsListTopView : UIView
@property (nonatomic, assign) id <KPGoodsListTopViewDelegate> delegate;
@end