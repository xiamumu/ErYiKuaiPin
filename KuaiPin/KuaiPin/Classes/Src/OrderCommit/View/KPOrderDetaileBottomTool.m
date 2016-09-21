//
//  KPOrderDetaileBottomTool.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderDetaileBottomTool.h"

const NSTimeInterval timeOut = 2 * 60 * 60;

@interface KPOrderDetaileBottomTool ()

@property (nonatomic, strong) KPButton *commitBtn;

@property (nonatomic, strong) KPButton *cancelBtn;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger minuteValue;

@property (nonatomic, assign) NSInteger hourValue;

@property (nonatomic, assign) NSInteger secondValue;

@end

@implementation KPOrderDetaileBottomTool

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;

}

- (void)setState:(NSNumber *)state {
    _state = state;
    NSInteger stateInt = state.integerValue;

    switch (stateInt) {
        case KPOrderStateCancel:
        case KPOrderStateUnSendOut:
        case KPOrderStateFinish:
        {
            self.hidden = YES;
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }
            break;
        case KPOrderStateUnPay:

            break;
        case KPOrderStateUnReceive:
        {
            self.cancelBtn.hidden = YES;
            self.timeLB.hidden = YES;
            self.titleLB.hidden = YES;
            [self.commitBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            self.commitBtn.titleLabel.font = UIFont_20;
            __weak typeof(self) weakSelf = self;
            [self.commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(weakSelf);
            }];
        }
            break;
        default:
            break;
    }

}

- (void)setAddTime:(NSNumber *)addTime {
    
    _addTime = addTime;

    NSTimeInterval time = addTime.doubleValue;
    
    NSDate *addDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *toDate = [addDate dateByAddingTimeInterval:(timeOut)];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *dateCom = [cal components:(NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitSecond) fromDate:nowDate toDate:toDate options:0];
    self.minuteValue = dateCom.minute;
    self.hourValue = dateCom.hour;
    self.secondValue = dateCom.second;
//    WHYNSLog(@"minute--%zd  hour--%zd second--%zd", dateCom.minute, dateCom.hour, dateCom.second);

    if (self.minuteValue <= 0 && self.hourValue <= 0 && self.secondValue <= 0) {
        self.minuteValue = 0;
        self.hourValue = 0;
        self.secondValue = 0;
        return;
    }
    
    [self.timer fire];
    
}

- (void)startCountDown {
    
    self.secondValue--;
    
    if (self.hourValue <= 0 && self.minuteValue <= 0 && self.secondValue <= 0) {
        [self stopTimer];
        NSPostNote(Noti_PayTimeOut, nil)
        return;
    }

    if (self.secondValue < 0) {
        self.secondValue = 59;

        self.minuteValue--;

        if (self.minuteValue < 0) {
            self.minuteValue = 59;

            self.hourValue--;

            if (self.hourValue < 0) {
                self.hourValue = 0;
            }
        }
    }

}

- (void)setMinuteValue:(NSInteger)minuteValue {
    _minuteValue = minuteValue;
    self.timeLB.text = [NSString stringWithFormat:@"%zd时%02zd分", self.hourValue, self.minuteValue];
}

- (void)setHourValue:(NSInteger)hourValue {
    _hourValue = hourValue;
    self.timeLB.text = [NSString stringWithFormat:@"%zd时%02zd分", self.hourValue, self.minuteValue];
}

#pragma mark - 点击事件
- (void)clickCommitButton {
    if (self.commitHandler) {
        self.commitHandler(self.state);
    }
}

- (void)clickCancelButton {
    if (self.cancelHandler) {
        self.cancelHandler();
    }
}

#pragma mark - 类方法
+(instancetype)orderDetailBottomToolWithCommitHandler:(CommitHandler)commitHandler cancelHandler:(CancelHandler)cancelHandler {
    
    KPOrderDetaileBottomTool *tool = [self new];
    tool.commitHandler = commitHandler;
    tool.cancelHandler = cancelHandler;
    
    return tool;
}

+(CGFloat)orderDetailBottomToolHeight {
    return 50;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.titleLB];
    [self addSubview:self.timeLB];
    [self addSubview:sep];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.commitBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat leftBtnW = ScaleWidth(100);
    CGFloat rightBtnW = self.cancelBtn.currentImage.size.width;;
    CGFloat leftMargin = 9;
    CGSize titleSize = [self.titleLB.text sizeWithAttributes:@{NSFontAttributeName : self.titleLB.font}];
    CGFloat timeH = 15;
    CGFloat sepH = 1;
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(titleSize);
    }];
    
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLB.mas_right);
        make.centerY.mas_equalTo(weakSelf.titleLB);
        make.height.mas_equalTo(timeH);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(leftBtnW);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.commitBtn.mas_left);
        make.width.mas_equalTo(rightBtnW);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
}

#pragma mark - 懒加载
- (KPButton *)commitBtn {
    if (_commitBtn == nil) {
        _commitBtn = [KPButton new];
        [_commitBtn addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
        [_commitBtn setBackgroundColor:OrangeColor];
        [_commitBtn setTitle:@"支付赢资产" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = UIFont_14;
        _commitBtn.adjustsImageWhenHighlighted = NO;
        _commitBtn.adjustsImageWhenDisabled = YES;
    }
    return _commitBtn;
}

- (KPButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [KPButton new];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        _cancelBtn.adjustsImageWhenHighlighted = NO;
    }
    return _cancelBtn;
}

- (UILabel *)timeLB {
    if (_timeLB == nil) {
        _timeLB = [UILabel new];
        _timeLB.font = UIFont_15;
        _timeLB.textColor = OrangeColor;
    }
    return _timeLB;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.font = UIFont_12;
        _titleLB.textColor = GrayColor;
        _titleLB.text = @"付款剩余时间：";
    }
    return _titleLB;
}


- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(startCountDown)
                                                userInfo:nil
                                                 repeats:YES];
        
        
    }
    return _timer;
}


@end
