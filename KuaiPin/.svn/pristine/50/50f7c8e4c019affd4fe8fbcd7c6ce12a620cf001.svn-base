//
//  KPOrderMessageCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderMessageCell.h"

NSInteger maxLength = 45;

@interface KPOrderMessageCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *messageTF;

@end

@implementation KPOrderMessageCell

- (void)changeText {
    if (self.messageTF.text.length > maxLength) {
        [KPProgressHUD showErrorWithStatus:@"留言最多只能输入45个字"];
        self.messageTF.text = [self.messageTF.text substringToIndex:maxLength];
    }
    
    if (self.changedOrderMessage) {
        self.changedOrderMessage(self.messageTF.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (string.length == 0) return YES;

    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    }

    if(textField.text.length > maxLength) {

        if ([textField isEqual:self.messageTF]) {
            //输入的字符个数大于maxLength，则无法继续输入，返回NO表示禁止输入
            WHYNSLog(@"输入的字符个数大于%zd，忽略输入", maxLength);
            [KPProgressHUD showErrorWithStatus:@"留言最多只能输入45个字"];
            return NO;
        }

        return YES;
    }

    return YES;
}

+(instancetype)cellWithTableView:(UITableView *)tableView {

    static NSString *ID = @"KPOrderMessageCell";

    KPOrderMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[KPOrderMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}

+ (CGFloat)cellHeight {
    return 40;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];

        NSAddObserver(changeText, UITextFieldTextDidChangeNotification)
    }
    return self;
}

- (void)setupUI {

    [self addSubview:self.messageTF];

    __weak typeof(self) weakSelf = self;
    CGFloat leftRightMargin = 9;
    [self.messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf).offset(-leftRightMargin);
    }];

}

#pragma mark - 懒加载
- (UITextField *)messageTF {
    if (_messageTF == nil) {
        _messageTF = [UITextField new];
        _messageTF.placeholder = @"选填：给商家留言（45字以内）";
        _messageTF.clearButtonMode = UITextFieldViewModeAlways;
        _messageTF.font = UIFont_14;
        _messageTF.delegate = self;
//        [_messageTF addTarget:self action:@selector(changeText) forControlEvents:UIControlEventValueChanged];
    }
    return _messageTF;
}

@end
