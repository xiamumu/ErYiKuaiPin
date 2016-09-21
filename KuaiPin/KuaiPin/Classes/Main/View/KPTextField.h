//
//  KPTextField.h
//  KuaiPin
//
//  Created by 王洪运 on 16/8/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPKeybordType) {

    KPKeyboardTypeDefault = UIKeyboardTypeDefault,
    KPKeyboardTypeASCIICapable = UIKeyboardTypeASCIICapable,
    KPKeyboardTypeNumbersAndPunctuation = UIKeyboardTypeNumbersAndPunctuation,
    KPKeyboardTypeURL = UIKeyboardTypeURL,
    KPKeyboardTypeNumberPad = UIKeyboardTypeNumberPad,
    KPKeyboardTypePhonePad = UIKeyboardTypePhonePad,
    KPKeyboardTypeNamePhonePad = UIKeyboardTypeNamePhonePad,
    KPKeyboardTypeEmailAddress = UIKeyboardTypeEmailAddress,
    KPKeyboardTypeDecimalPad = UIKeyboardTypeDecimalPad,
    KPKeyboardTypeTwitter = UIKeyboardTypeTwitter,
    KPKeyboardTypeWebSearch = UIKeyboardTypeWebSearch,
    KPKeyboardTypeAlphabet = UIKeyboardTypeAlphabet,

    KPKeyboardTypeIDCard,
};

@class KPTextField;

@protocol KPTextFieldDelegate <NSObject>

@optional

- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface KPTextField : UIView

@property (nonatomic, weak) id<KPTextFieldDelegate> delegate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) KPKeybordType keyboardType;

@property (nonatomic, copy) NSString *imgName;

@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

@property (nonatomic, assign) CGFloat midMargin;

@property (nonatomic, assign) BOOL editing;

@property (nonatomic, assign) UITextFieldViewMode  clearButtonMode;

@property (nonatomic, strong) __kindof UIView *inputView;

+ (instancetype)textFieldWithImgName:(NSString *)imgName title:(NSString *)title placeHolder:(NSString *)placeHolder;

+ (instancetype)textFieldWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder;

@end
