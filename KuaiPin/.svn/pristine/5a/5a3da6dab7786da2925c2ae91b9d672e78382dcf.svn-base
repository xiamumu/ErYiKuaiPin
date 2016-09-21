//
//  KPTimeDownView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTimeDownView.h"

#define DayNumCount 3
#define HourNumCount 2
#define MinuteNumCount 2

#pragma mark - KPSingleTimeLabel
@interface KPSingleNumLabel : KPButton

@property (nonatomic, copy) NSString *time;

@end

@implementation KPSingleNumLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"timeLabel_bg"] forState:UIControlStateNormal];
        self.size = self.currentBackgroundImage.size;
        self.titleLabel.font = UIFont_30;
        [self setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setTime:(NSString *)time
{
    _time = [time copy];
    [self setTitle:time forState:UIControlStateNormal];
}

@end
#pragma mark - KPTimeDownView
@interface KPTimeDownView ()

@property (nonatomic, strong) NSMutableArray *dayNumLabs;
@property (nonatomic, strong) NSMutableArray *hourNumLabs;
@property (nonatomic, strong) NSMutableArray *minuteNumLabs;

@property (nonatomic, strong) NSMutableArray *dayCharS;
@property (nonatomic, strong) NSMutableArray *hourCharS;
@property (nonatomic, strong) NSMutableArray *minuteCharS;

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;

@property (nonatomic, weak) UILabel *dayLab;
@property (nonatomic, weak) UILabel *hourLab;
@property (nonatomic, weak) UILabel *minuteLab;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation KPTimeDownView
#pragma mark - 懒加载
- (NSMutableArray *)dayNumLabs
{
    if (_dayNumLabs == nil) {
        _dayNumLabs = [NSMutableArray array];
    }
    return _dayNumLabs;
}
- (NSMutableArray *)hourNumLabs
{
    if (_hourNumLabs == nil) {
        _hourNumLabs = [NSMutableArray array];
    }
    return _hourNumLabs;
}
- (NSMutableArray *)minuteNumLabs
{
    if (_minuteNumLabs == nil) {
        _minuteNumLabs = [NSMutableArray array];
    }
    return _minuteNumLabs;
}
- (NSMutableArray *)dayCharS
{
    if (_dayCharS == nil) {
        _dayCharS = [[NSMutableArray alloc] init];
    }
    return _dayCharS;
}
- (NSMutableArray *)hourCharS
{
    if (_hourCharS == nil) {
        _hourCharS = [[NSMutableArray alloc] init];
    }
    return _hourCharS;
}
- (NSMutableArray *)minuteCharS
{
    if (_minuteCharS == nil) {
        _minuteCharS = [[NSMutableArray alloc] init];
    }
    return _minuteCharS;
}
#pragma mark - UI
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < DayNumCount ; i++) {
            KPSingleNumLabel *numLab = [[KPSingleNumLabel alloc] init];
            [self addSubview:numLab];
            [self.dayNumLabs addObject:numLab];
        }
        for (int i = 0; i < HourNumCount ; i++) {
            KPSingleNumLabel *numLab = [[KPSingleNumLabel alloc] init];
            [self addSubview:numLab];
            [self.hourNumLabs addObject:numLab];
        }
        
        for (int i = 0; i < MinuteNumCount ; i++) {
            KPSingleNumLabel *numLab = [[KPSingleNumLabel alloc] init];
            [self addSubview:numLab];
            [self.minuteNumLabs addObject:numLab];
        }
        
        
        UILabel *dayLab = [UILabel addLabelWithTitle:@"天" textColor:HexColor(#8a8a8a) font:UIFont_17];
        [self addSubview:dayLab];
        self.dayLab = dayLab;
        UILabel *hourLab = [UILabel addLabelWithTitle:@"时" textColor:HexColor(#8a8a8a) font:UIFont_17];
        [self addSubview:hourLab];
        self.hourLab = hourLab;
        UILabel *minuteLab = [UILabel addLabelWithTitle:@"分" textColor:HexColor(#8a8a8a) font:UIFont_17];
        [self addSubview:minuteLab];
        self.minuteLab = minuteLab;
    }
    return self;
}

// 根据时间戳实现倒计时
- (void)setCountDownTime:(NSString *)countDownTime
{
    _countDownTime = countDownTime;
    
    
    if (countDownTime.length == 0) {
        
        [self setTimeToNumLabWithDay:365 hour:0 minute:0];
        return;
        
    }
    
    // 假定时间
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *endDay = [formatter dateFromString:@"2016-05-12 18:00:00"];
    
    NSDate *endDay = [NSDate dateWithTimeIntervalSince1970:countDownTime.integerValue/1000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date] toDate:endDay options:0];
    self.day = [components day];
    self.hour = [components hour];
    self.minute = [components minute];
    
    [self setTimeToNumLabWithDay:self.day hour:self.hour minute:self.minute];
    
    // 添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(countDownTimeAction:) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)setTimeToNumLabWithDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute
{
    [self.dayCharS removeAllObjects];
    [self.hourCharS removeAllObjects];
    [self.minuteCharS removeAllObjects];
    NSString *dayChar = [NSString stringWithFormat:@"%03zd", day];
    NSString *hourChar = [NSString stringWithFormat:@"%02zd", hour];
    NSString *minuteChar = [NSString stringWithFormat:@"%02zd", minute];
    
    NSString *dayFirstChar = [dayChar substringWithRange:NSMakeRange(0, 1)];
    NSString *daySecondChar = [dayChar substringWithRange:NSMakeRange(1, 1)];
    NSString *dayThirdChar = [dayChar substringWithRange:NSMakeRange(2, 1)];
    [self.dayCharS addObject:dayFirstChar];
    [self.dayCharS addObject:daySecondChar];
    [self.dayCharS addObject:dayThirdChar];
    
    NSString *hourFirstChar = [hourChar substringWithRange:NSMakeRange(0, 1)];
    NSString *hourSecondChar = [hourChar substringWithRange:NSMakeRange(1, 1)];
    [self.hourCharS addObject:hourFirstChar];
    [self.hourCharS addObject:hourSecondChar];
    
    NSString *minuteFirstChar = [minuteChar substringWithRange:NSMakeRange(0, 1)];
    NSString *minuteSecondChar = [minuteChar substringWithRange:NSMakeRange(1, 1)];
    [self.minuteCharS addObject:minuteFirstChar];
    [self.minuteCharS addObject:minuteSecondChar];
    
    
    for (int i = 0; i < DayNumCount ; i++) {
        KPSingleNumLabel *numLab = self.dayNumLabs[i];
        numLab.time = self.dayCharS[i];
    }
    for (int i = 0; i < HourNumCount ; i++) {
        KPSingleNumLabel *numLab = self.hourNumLabs[i];
        numLab.time = self.hourCharS[i];
    }
    for (int i = 0; i < MinuteNumCount ; i++) {
        KPSingleNumLabel *numLab = self.minuteNumLabs[i];
        numLab.time = self.minuteCharS[i];
    }
}

- (void)countDownTimeAction:(NSTimeInterval *)timeInterval
{
    self.minute--;
    if (self.minute == 0) {
        
        self.minute = 59;
        self.hour--;
        
        if (self.hour == 0) {
            
            self.hour = 23;
            self.day--;
        }
    }
    if (self.day < 0 || self.hour < 0 || self.minute < 0) {
        
        [self.timer invalidate];
        self.timer = nil;
        [self setTimeToNumLabWithDay:0 hour:0 minute:0];
        
    }else {
        
        [self setTimeToNumLabWithDay:self.day hour:self.hour minute:self.minute];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImage *numImage = [UIImage imageNamed:@"timeLabel_bg"];
    CGFloat margin = 3;
    CGFloat numLabW = numImage.size.width;
    CGFloat numLabH = numImage.size.height;
    CGFloat timeW = 17;
    CGFloat timeH = numLabH;
    
    CGFloat MaxX = 0;
    for (int i = 0; i < DayNumCount ; i++) {
        KPSingleNumLabel *numLab = self.dayNumLabs[i];
        numLab.frame = CGRectMake(MaxX, 0, numLabW, numLabH);
        MaxX = CGRectGetMaxX(numLab.frame) + margin;
    }
    
    self.dayLab.frame = CGRectMake(MaxX, 0, timeW, timeH);
    MaxX = CGRectGetMaxX(self.dayLab.frame) + margin;
    
    for (int i = 0; i < HourNumCount ; i++) {
        KPSingleNumLabel *numLab = self.hourNumLabs[i];
        numLab.frame = CGRectMake(MaxX, 0, numLabW, numLabH);
        MaxX = CGRectGetMaxX(numLab.frame) + margin;
    }
    
    self.hourLab.frame = CGRectMake(MaxX, 0, timeW, timeH);
    MaxX = CGRectGetMaxX(self.hourLab.frame) + margin;
    
    for (int i = 0; i < MinuteNumCount ; i++) {
        KPSingleNumLabel *numLab = self.minuteNumLabs[i];
        numLab.frame = CGRectMake(MaxX, 0, numLabW, numLabH);
        MaxX = CGRectGetMaxX(numLab.frame) + margin;
    }
    
    self.minuteLab.frame = CGRectMake(MaxX, 0, timeW, timeH);
    MaxX = CGRectGetMaxX(self.minuteLab.frame);
    
    self.width = MaxX;
    self.height = numLabH;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
@end




