//
//  JMTextViewFormView.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMTextViewFormView.h"

@implementation JMTextViewFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.formViewClass = [JMTextViewFormView class];
        self.formViewHeight = 100.0f;
    }
    return self;
}
@end


@interface JMTextViewFormView () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation JMTextViewFormView
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
    return self.textView.userInteractionEnabled;
}

#pragma mark - JMFormViewDatasource

- (void)updateFormViewWithDescription:(JMTextViewFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    //self.textView.placeholder = description.placeholder;
    self.textView.text = description.data;
    self.formDelegate = description.formDelegate;
    self.textView.delegate = self;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.textView.inputAccessoryView = [self toolBar];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.formDelegate respondsToSelector:@selector(scrollToFormView:)]) {
        [self.formDelegate scrollToFormView:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * finalString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([self.formDelegate respondsToSelector:@selector(textUpdatedFromFormView:textView:toText:)]) {
        [self.formDelegate textUpdatedFromFormView:self textView:self.textView toText:finalString];
    }
    
    return YES;
}

#pragma mark - ToolBar

- (void)resignKeyboard:(id)sender
{
    [self.textView resignFirstResponder];
}

- (void)formViewBecomeFirstResponder
{
    [self.textView becomeFirstResponder];
}

@end
