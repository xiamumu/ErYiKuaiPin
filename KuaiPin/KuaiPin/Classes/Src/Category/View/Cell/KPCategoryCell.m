//
//  KPCategoryCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCategoryCell.h"
#import "KPCategoryModel.h"

@interface KPCategoryCell ()

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) KPCategoryModel *categoryModel;

@end

@implementation KPCategoryCell

- (NSString *)categoryTitle {
    return self.titleLB.text;
}

- (void)setModel:(__kindof KPBaseModel *)model {
    super.model = model;
    self.categoryModel = (KPCategoryModel *)model;
    
    self.titleLB.text = self.categoryModel.name;
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPCategoryCell";
    
    KPCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 65;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
-(void)setupUI {
    
    self.backgroundColor = WhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orderCommit_nextIcon"]];
    
    [self addSubview:self.titleLB];
    [self addSubview:indicator];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat leftRight = 9;
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.font = UIFont_17;
        _titleLB.textColor = OrangeColor;
    }
    return _titleLB;
}

@end
