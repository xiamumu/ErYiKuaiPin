//
//  KPBrandTableViewCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBrandTableViewCellContentView.h"
#import "KPBrand.h"
#import "KPCollectStoreParam.h"

@interface KPBrandTableViewCellContentView ()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *likeLab;
@property (nonatomic, weak) KPButton *likeBtn;
@property (nonatomic, weak) UIImageView *arrowImg;
@property (nonatomic, weak) UIView *line;
@end

@implementation KPBrandTableViewCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *title = [UILabel addLabelWithTitle:@"" textColor:HexColor(#191919) font:UIFont_12];
        [self addSubview:title];
        self.title = title;
        
        UILabel *likeLab = [UILabel addLabelWithTitle:@"" textColor:HexColor(#8a8a8a) font:UIFont_10];
        [self addSubview:likeLab];
        self.likeLab = likeLab;
        
        KPButton *likeBtn = [[KPButton alloc] init];
        [likeBtn setTitle:@"加关注" forState:UIControlStateNormal];
        likeBtn.titleLabel.font = UIFont_12;
        [likeBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"brand_favorit_normal"] forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"brand_favorit_selected"] forState:UIControlStateSelected];
        likeBtn.contentMode = UIViewContentModeLeft;
        likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -22, 0, 0);
        [likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeBtn];
        self.likeBtn = likeBtn;
        
        UIImageView *arrowImg = [[UIImageView alloc] init];
        arrowImg.image = [UIImage imageNamed:@"brand_nexticon"];
        [self addSubview:arrowImg];
        self.arrowImg = arrowImg;
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
        
    }
    return self;
}
- (void)setBrand:(KPBrand *)brand
{
    _brand = brand;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:brand.storeAvatar] placeholderImage:[UIImage imageNamed:@"brandList_Placeholder"]];
    
    self.title.text = brand.storeName;
    self.likeLab.text = [NSString stringWithFormat:@"已有%@人关注", brand.followCount];
    self.likeBtn.selected = brand.isCollection.boolValue;
}

- (void)likeBtnAction:(KPButton *)likeBtn
{
    
        KPCollectStoreParam *param = [[KPCollectStoreParam alloc] init];
        param.storeId = self.brand.brandId;
    
        [KPNetworkingTool CollectStore:param Success:^(id result) {
            
            if (likeBtn.selected == NO && [result[@"data"][@"collect"] integerValue] == 1) {
                    
                [KPProgressHUD showSuccessWithStatus:@"关注成功"];
                likeBtn.selected = YES;
            }
            else if (likeBtn.selected == YES && [result[@"data"][@"collect"] integerValue] == 0) {
                    
                [KPProgressHUD showSuccessWithStatus:@"取消关注"];
                likeBtn.selected = NO;
            }
        } failure:^(NSError *error) { WHYNSLog(@"-------商店关注失败%@", error); }];
    
}
- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;
    CGFloat imgViewW = 83;
    CGFloat imgViewH = 65;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(7);
        make.size.mas_equalTo(CGSizeMake(imgViewW, imgViewH));
    }];
    
    CGFloat title_H = [self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].height;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imgView.mas_right).offset(12);
        make.top.mas_equalTo(weakSelf).offset(14);
        make.right.mas_equalTo(weakSelf).offset(-50);
        make.height.mas_equalTo(title_H);
    }];

    CGFloat likeLab_H = [self.likeLab.text sizeWithAttributes:@{NSFontAttributeName: self.likeLab.font}].height;
    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.title);
        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(7);
        make.right.mas_equalTo(weakSelf.title);
        make.height.mas_equalTo(likeLab_H);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.title);
        make.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.likeLab.mas_bottom);
        make.width.mas_equalTo(80);
    }];

    CGSize arrowSize = self.arrowImg.image.size;
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-9);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(arrowSize);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}
@end
