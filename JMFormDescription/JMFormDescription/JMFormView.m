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
}

+ (instancetype)viewFromNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return [nib instantiateWithOwner:self options:nil][0];
}

- (void)formViewBecomeFirstResponder
{
}

#pragma mark - Manage ToolBar

- (UIToolbar *)toolBar
{
    if ([self.formDelegate respondsToSelector:@selector(nextFormViewAvailableAfterFormView:)] &&
        [self.formDelegate respondsToSelector:@selector(previousFormViewAvailableBeforeFormView:)]) {
    } else {
        return nil;
    }
    
    UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 50.0f)];
    keyboardToolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *previousBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"previous",@"")
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(previousTextField:)];
    [previousBarButtonItem setEnabled:[self.formDelegate previousFormViewAvailableBeforeFormView:self]];
    
    UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"next",@"")
                                                                          style:UIBarButtonItemStyleBordered
                                                                         target:self
                                                                         action:@selector(nextTextField:)];
    [nextBarButtonItem setEnabled:[self.formDelegate nextFormViewAvailableAfterFormView:self]];
    
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
    [self.formDelegate presentPreviousFormViewAvailableBeforeFormView:self];
}

- (void)nextTextField:(id)sender
{
    [self.formDelegate presentNextFormViewAvailableAfterFormView:self];
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
