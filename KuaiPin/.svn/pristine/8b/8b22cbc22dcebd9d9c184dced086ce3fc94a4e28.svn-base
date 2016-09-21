//
//  KPSearchController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/16.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSearchController.h"
#import "KPSearchTextField.h"

@interface KPSearchController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) KPSearchTextField *searchTF;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *searchHistoryList;

@property (nonatomic, strong) KPButton *cleanBtn;

@property (nonatomic, assign) KPSearchType type;

@end

@interface KPSectionView : UIView
@end

@interface KPSearchCell : UITableViewCell
@property (nonatomic, strong) UILabel *searchLB;
@property (nonatomic, copy) NSString *searchText;
@end

#pragma mark - KPSearchController
@implementation KPSearchController

+ (void)startSearchWithType:(KPSearchType)type {
    
    KPSearchController *searchVc = [self sharedSearchController];
    searchVc.type = type;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:searchVc.view];
    
}

#pragma mark - 重写set方法
- (void)setType:(KPSearchType)type {
    _type = type;
    
    if (type == KPSearchTypeALL) {
        self.searchTF.placeholder = @"搜索商品名";
    }else {
        self.searchTF.placeholder = @"搜索本店铺商品";
    }
}

#pragma mark - 点击事件
- (void)clickCleanButton {

    __weak typeof(self) weakSelf = self;
    KPAlertController *alert = [KPAlertController alertControllerWithTitle:@"确定要清空搜索历史记录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清空" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.searchHistoryList = [NSArray array];
        [weakSelf.tableView reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.tableFooterView.hidden = !!!self.searchHistoryList.count;
    return self.searchHistoryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"KPSearchCell";
    
    KPSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.searchText = self.searchHistoryList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [KPSectionView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.searchHistoryList.count == 0) {
        UILabel *label = [UILabel new];
        label.text = @"还没有搜索记录";
        label.font = UIFont_14;
        label.textColor = GrayColor;
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.searchHistoryList.count ? 45 : 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KPSearchCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.searchHistoryList = [self.searchHistoryList insertSearchKeyword:cell.searchText inIndex:0];
    NSPostNote(Noti_SearchGoods, cell.searchText);
    [self.view removeFromSuperview];
}

#pragma mark - 控制器生命周期
- (void)loadView {
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
    [self.searchTF becomeFirstResponder];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
    [self.searchHistoryList writeToFile:DocumentPathWithFileName(@"searchHistoryList.data") atomically:YES];
}

#pragma mark - 私有方法
- (void)addSearchHistoryWithKeyword:(NSString *)keyword {

    if (keyword.length == 0) {
        [KPProgressHUD showErrorWithStatus:@"请输入搜索关键字"];
        return;
    }

    self.searchHistoryList = [self.searchHistoryList insertSearchKeyword:keyword inIndex:0];

    NSPostNote(Noti_SearchGoods, keyword);
    [self.view removeFromSuperview];
}


- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.searchTF];
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    CGFloat top = 20;
    CGFloat searchH = 44;
    
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).offset(top);
        make.height.mas_equalTo(searchH);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.searchTF.mas_bottom);
    }];
    
}

#pragma mark - 懒加载
- (KPSearchTextField *)searchTF {
    if (_searchTF == nil) {
        _searchTF = [KPSearchTextField new];
        _searchTF.placeholder = @"搜索商品名";
        
        __weak typeof(self) weakSelf = self;
        [_searchTF setCancelHandler:^{
            [weakSelf.view removeFromSuperview];
        }];
        
        [_searchTF setSearchHandler:^(NSString *searchText) {
            [weakSelf addSearchHistoryWithKeyword:searchText];
            [weakSelf.tableView reloadData];
        }];
    }
    return _searchTF;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ViewBgColor;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        [view addSubview:self.cleanBtn];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (NSArray<NSString *> *)searchHistoryList {
    if (_searchHistoryList == nil) {
        _searchHistoryList = [NSArray objectWithContentsOfFile:DocumentPathWithFileName(@"searchHistoryList.data")];
        if (_searchHistoryList == nil) _searchHistoryList = [NSArray array];
    }
    return _searchHistoryList;
}

- (KPButton *)cleanBtn {
    if (_cleanBtn == nil) {
        _cleanBtn = [[KPButton alloc] initWithFrame:CGRectMake(0, 0, ScaleWidth(281), 44)];
        _cleanBtn.backgroundColor = WhiteColor;
        _cleanBtn.centerX = SCREEN_W * 0.5;
        _cleanBtn.layer.cornerRadius = 6;
        _cleanBtn.layer.borderWidth = 1;
        _cleanBtn.layer.borderColor = SeperatorColor.CGColor;
        _cleanBtn.titleLabel.font = UIFont_18;
        [_cleanBtn setTitle:@"清空搜索历史" forState:UIControlStateNormal];
        [_cleanBtn setTitleColor:HexColor(#ff6d15) forState:UIControlStateNormal];
        [_cleanBtn addTarget:self action:@selector(clickCleanButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanBtn;
}

singleton_implementation(SearchController)

@end


#pragma mark - KPSectionView
@implementation KPSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    UIView *topView = [UIView new];
    topView.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sepTop = [KPSeparatorView new];
    KPSeparatorView *sepBottom = [KPSeparatorView new];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock"]];
    
    UILabel *label = [UILabel new];
    label.text = @"最近搜索";
    label.font = UIFont_14;
    label.textColor = GrayColor;
    
    [self addSubview:topView];
    [self addSubview:sepTop];
    [self addSubview:iconView];
    [self addSubview:label];
    [self addSubview:sepBottom];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat topH = 10;
    CGFloat sepH = 1;
    CGFloat left = 9;
    CGFloat iconTop = 14;
    CGFloat iconWH = 17;
    CGFloat labelLeft = 7;
    CGFloat labelH = 14;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(topH);
    }];
    
    [sepTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(topView);
        make.height.mas_equalTo(sepH);
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.top.mas_equalTo(topView.mas_bottom).offset(iconTop);
        make.width.height.mas_equalTo(iconWH);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(labelLeft);
        make.centerY.mas_equalTo(iconView);
        make.height.mas_equalTo(labelH);
    }];
    
    [sepBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
    
}

@end


#pragma mark - KPSearchCell
@implementation KPSearchCell

- (void)setSearchText:(NSString *)searchText {
    _searchText = [searchText copy];
    self.searchLB.text = searchText;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.searchLB = [UILabel new];
    self.searchLB.font = UIFont_15;
    self.searchLB.textColor = BlackColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.searchLB];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat leftRight = 9;
    CGFloat sepH = 1;
    
    [self.searchLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
}

@end
