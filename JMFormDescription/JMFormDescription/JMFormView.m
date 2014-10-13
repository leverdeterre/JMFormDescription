//
//  JMFormTableViewCell.m
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormView.h"

@implementation JMFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.formViewHeight = 44.0f;
    }
    return self;
}
@end

@implementation JMFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.formViewCanBecomeResponder = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.formViewCanBecomeResponder = NO;
    }
    return self;
}

- (void)updateFormViewWithDescription:(JMFormViewDescription *)data
{
    self.updateBlock = data.updateBlock;
    self.formDelegate = data.formDelegate;
    self.keyboardFormDelegate = data.keyboardFormDelegate;
    self.formViewHeight = data.formViewHeight;
}

+ (instancetype)viewFromNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return [nib instantiateWithOwner:self options:nil][0];
}

- (void)formViewBecomeFirstResponder
{
}

- (void)setFormDelegate:(id<JMFormDelegate>)formDelegate
{
    _formDelegate = formDelegate;
    if (nil == _keyboardFormDelegate) {
        if ([_formDelegate conformsToProtocol:@protocol(JMKeyboardFormDelegate)]) {
            id <JMKeyboardFormDelegate> keyboardFormDelegate = (id <JMKeyboardFormDelegate>) _formDelegate;
            self.keyboardFormDelegate = keyboardFormDelegate;
        }
    }
}

- (void)setKeyboardFormDelegate:(id<JMKeyboardFormDelegate>)keyboardFormDelegate
{
    _keyboardFormDelegate = keyboardFormDelegate;
}

#pragma mark - Manage ToolBar

- (UIToolbar *)toolBar
{
    if ([self.keyboardFormDelegate respondsToSelector:@selector(nextFormViewAvailableAfterFormView:)] &&
        [self.keyboardFormDelegate respondsToSelector:@selector(previousFormViewAvailableBeforeFormView:)]) {
    } else {
        return nil;
    }
    
    UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 50.0f)];
    keyboardToolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *previousBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"previous",@"")
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(previousTextField:)];
    [previousBarButtonItem setEnabled:[self.keyboardFormDelegate previousFormViewAvailableBeforeFormView:self]];
    
    UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"next",@"")
                                                                          style:UIBarButtonItemStyleBordered
                                                                         target:self
                                                                         action:@selector(nextTextField:)];
    [nextBarButtonItem setEnabled:[self.keyboardFormDelegate nextFormViewAvailableAfterFormView:self]];
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done",@"")
                                                                          style:UIBarButtonItemStyleDone
                                                                         target:self
                                                                         action:@selector(resignKeyboard:)];
    
    [keyboardToolBar setItems: [NSArray arrayWithObjects:
                                previousBarButtonItem,
                                nextBarButtonItem,
                                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                doneBarButtonItem,
                                nil]];
    
    return keyboardToolBar;
}

- (void)previousTextField:(id)sender
{
    [self.keyboardFormDelegate presentPreviousFormViewAvailableBeforeFormView:self];
}

- (void)nextTextField:(id)sender
{
    [self.keyboardFormDelegate presentNextFormViewAvailableAfterFormView:self];
}

- (void)resignKeyboard:(id)sender
{
    //[self textfield resignFirstResponder];
}

#pragma mark - Appearance

- (void)setFormViewBackgroundColor:(UIColor *)formViewBackgroundColor
{
    self.backgroundColor = formViewBackgroundColor;
}

- (void)setFormViewTitleFont:(UIFont *)formViewTitleFont
{

}

@end
