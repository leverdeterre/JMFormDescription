//
//  JMFormDelegate.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMTextfieldFormView;
@class JMSwitchFormView;
@class JMButtonFormView;
@class JMFormView;
@class JMListFormView;
@class JMTextViewFormView;

@protocol JMFormDelegate <NSObject>

@optional
- (void)textUpdatedFromCell:(JMTextfieldFormView *)formView textfield:(UITextField *)textfield toText:(NSString *)text;
- (void)textUpdatedFromCell:(JMTextViewFormView *)formView textView:(UITextView *)textView toText:(NSString *)text;
- (void)switchChangedFromCell:(JMSwitchFormView *)formView toValue:(BOOL)value;
- (void)buttonPressedFromCell:(JMButtonFormView *)formView withTitleValue:(NSString *)value;
- (void)listPressedFromCell:(JMListFormView *)formView withSelectedValue:(NSString *)value;
- (void)selectedChoice:(NSString *)choice forModelKey:(NSString *)modelKey;
- (void)scrollToFormView:(JMFormView *)formView;

#pragma mark - Keyboard Management

- (BOOL)nextFormViewAvailableAfterFormView:(JMFormView *)formView;
- (BOOL)previousFormViewAvailableBeforeFormView:(JMFormView *)formView;
- (void)presentNextFormViewAvailableAfterFormView:(JMFormView *)formView;
- (void)presentPreviousFormViewAvailableBeforeFormView:(JMFormView *)formView;

@end
