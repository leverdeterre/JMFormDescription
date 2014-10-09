//
//  JMTextfieldFormView.m
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMTextfieldFormView.h"
#import "JMFormDelegate.h"
#import <objc/runtime.h>

@implementation JMTextfieldFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.formViewClass = [JMTextfieldFormView class];
        self.formViewHeight = 50.0f;
    }
    return self;
}
@end

@implementation JMTextfieldFormViewDescription (JMTextfieldFormBlocked)
- (void)setBlockingButtonSelector:(SEL)customSelector
{
    objc_setAssociatedObject(self, @selector(blockingButtonSelector), NSStringFromSelector(customSelector), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SEL)blockingButtonSelector
{
    return NSSelectorFromString(objc_getAssociatedObject(self, _cmd));
}
@end

@interface JMTextfieldFormView() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldHeight;
@end

@implementation JMTextfieldFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.formViewCanBecomeResponder = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.formViewCanBecomeResponder = YES;
    }
    return self;
}

- (BOOL)formViewCanBecomeResponder
{
    return self.textfield.userInteractionEnabled;
}

#pragma mark - JMFormViewDatasource

- (void)updateFormViewWithDescription:(JMTextfieldFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    if (!CGSizeEqualToSize(CGSizeZero,description.textfieldSize)) {
        self.textfieldWidth.constant = description.textfieldSize.width;
        self.textfieldHeight.constant = description.textfieldSize.height;
        [self setNeedsLayout];
    }
    
    self.textfield.placeholder = description.placeholder;
    self.textfield.text = description.data;
    
    if (description.blockingButtonSelector) {
        UIButton *overviewedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [overviewedButton addTarget:self.formDelegate action:description.blockingButtonSelector forControlEvents:UIControlEventTouchUpInside];
        [overviewedButton setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [overviewedButton setFrame:self.bounds];
        [self addSubview:overviewedButton];
        self.textfield.delegate = nil;
        self.textfield.userInteractionEnabled = NO;
        
    } else {
        self.formDelegate = description.formDelegate;
        self.textfield.delegate = self;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textfield.inputAccessoryView = [self toolBar];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([self.formDelegate respondsToSelector:@selector(textUpdatedFromFormView:textfield:toText:)]) {
        [self.formDelegate textUpdatedFromFormView:self textfield:textField toText:finalString];
    }
    
    if (self.updateBlock) {
        self.updateBlock(finalString);
    }
    
    return YES;
}

#pragma mark - ToolBar

- (void)resignKeyboard:(id)sender
{
    [self.textfield resignFirstResponder];
}

- (void)formViewBecomeFirstResponder
{
    [self.textfield becomeFirstResponder];
}

#pragma mark - Appearance

- (void)setFormViewTextfieldFont:(UIFont *)textfieldFont
{
    self.textfield.font = textfieldFont;
}

- (void)setFormViewTextfieldTextColor:(UIColor *)textfieldColor
{
    self.textfield.textColor = textfieldColor;
}

@end
