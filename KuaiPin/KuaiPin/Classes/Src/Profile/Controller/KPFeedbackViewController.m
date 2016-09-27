//
//  KPFeedbackViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPFeedbackViewController.h"
#import "UIBarButtonItem+XM.h"
#import "KPFeedbackParam.h"

@interface KPFeedbackViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *alertTextLab;
@property (nonatomic, weak) NSString *textViewText;


@end

@implementation KPFeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BaseColor;
    
    
    self.textView.contentOffset = CGPointZero;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"提交" titleColor:OrangeColor hightLightColor:GrayColor targe:self action:@selector(submitAction:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0)  return YES;
    NSInteger length = textView.text.length;
    if (length > 200) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger length = textView.text.length;
    if (length > 200) {
        length = 200;
        textView.text = [textView.text substringWithRange:NSMakeRange(0, length)];
    }
    self.alertTextLab.text = [NSString stringWithFormat:@"还可以输入%zd个字", 200 - length];
}


- (void)submitAction:(KPButton *)submit
{
    NSLog(@"提交");
    if (self.textView.text.length == 0) {
        [KPProgressHUD showSuccessWithStatus:@"您还没有输入任何意见"];
        return;
    }
    
    [self commit];
}

- (void)commit
{
    __weak typeof (self) weakSelf = self;
    KPFeedbackParam *param = [KPFeedbackParam param];
    param.content = self.textView.text;
    [KPNetworkingTool commitFeedback:param Success:^(id result) {
        
        if (CODE == 0) {
        
            [KPProgressHUD showSuccessWithStatus:@"意见提交成功，我们会尽快处理" completion:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [KPProgressHUD showErrorWithStatus:@"意见提交失败，请稍后重试"];
        }
        
    } failure:^(NSError *error) {
        
        [KPProgressHUD showErrorWithStatus:@"意见提交失败，请稍后重试"];
        
    }];
}

@end
