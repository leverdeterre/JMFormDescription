//
//  JMFormTableViewCell.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFormDatasources.h"
#import "JMFormDelegate.h"

@interface JMFormViewDescription : NSObject
@property (strong, nonatomic) Class formViewClass;
@property (strong, nonatomic) id data;
@property (assign, nonatomic) CGFloat formViewHeight;
@property (weak, nonatomic) id <JMKeyboardFormDelegate>keyboardFormDelegate;

//update with delegate
@property (weak, nonatomic) id <JMFormDelegate>formDelegate;
@property (weak, nonatomic) NSString* modelKey;

//update with block
@property (copy, nonatomic) JMFormViewCompltionBlock updateBlock;
@end

@interface JMFormView : UIView <JMFormViewDatasource>

@property (strong, nonatomic) UIColor *formViewBackgroundColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIFont *formViewTitleFont UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) BOOL formViewCanBecomeResponder;
@property (weak, nonatomic) id <JMFormDelegate>formDelegate;
@property (weak, nonatomic) id <JMKeyboardFormDelegate>keyboardFormDelegate;
@property (copy, nonatomic) JMFormViewCompltionBlock updateBlock;
@property (assign, nonatomic) CGFloat formViewHeight;

+ (instancetype)viewFromNib;
- (void)formViewBecomeFirstResponder;

#pragma mark - ToolBar
- (UIToolbar *)toolBar;
- (void)previousTextField:(id)sender;
- (void)nextTextField:(id)sender;
- (void)resignKeyboard:(id)sender;

@end
