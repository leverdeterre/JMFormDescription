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

typedef void (^JMFormViewCompltionBlock)(id modifiedValue);

@protocol JMFormDelegate <NSObject>

@optional
//textfield
- (void)textUpdatedFromFormView:(JMTextfieldFormView *)formView textfield:(UITextField *)textfield toText:(NSString *)text;

//textView
- (void)textUpdatedFromFormView:(JMTextViewFormView *)formView textView:(UITextView *)textView toText:(NSString *)text;

//Switch
- (void)switchChangedFromFormView:(JMSwitchFormView *)formView toValue:(BOOL)value;

//Button
- (void)buttonPressedFromFormView:(JMButtonFormView *)formView withTitleValue:(NSString *)value;

//List
- (void)listPressedFromFormView:(JMListFormView *)formView withSelectedValue:(NSString *)value;
- (void)presentListChoices:(NSArray *)choices forModelKey:(NSString *)modelKey currentChoice:(id)currentChoice;
- (void)presentListChoices:(NSArray *)choices currentChoice:(id)currentChoice withCompletionBlock:(JMFormViewCompltionBlock)block;
- (void)dismissWithChoice:(id)currentChoice forModelKey:(NSString *)modelKey;
- (void)pushListChoices:(NSArray *)choices forModelKey:(NSString *)modelKey currentChoice:(id)currentChoice;
- (void)popWithChoice:(id)currentChoice forModelKey:(NSString *)modelKey;

- (void)scrollToFormView:(JMFormView *)formView;

@end

@protocol JMKeyboardFormDelegate <NSObject>

#pragma mark - Keyboard Management

- (BOOL)nextFormViewAvailableAfterFormView:(JMFormView *)formView;
- (BOOL)previousFormViewAvailableBeforeFormView:(JMFormView *)formView;
- (void)presentNextFormViewAvailableAfterFormView:(JMFormView *)formView;
- (void)presentPreviousFormViewAvailableBeforeFormView:(JMFormView *)formView;

@end

