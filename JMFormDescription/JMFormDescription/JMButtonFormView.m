//
//  JMButtonFormView.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMButtonFormView.h"
#import "JMFormDelegate.h"

@implementation JMButtonFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.enable = YES;
        self.formViewHeight = 50.0f;
        self.formViewClass = [JMButtonFormView class];
    }
    return self;
}
@end

@interface JMButtonFormView ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) id <JMFormDelegate>formDelegate;
@end

@implementation JMButtonFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.formViewCanBecomeResponder = NO;
    }
    return self;
}

- (void)updateFormViewWithDescription:(JMButtonFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    self.button.enabled = description.enable;
    [self.button setTitle:description.title forState:UIControlStateNormal];
    self.formDelegate = description.formDelegate;
    [self.button.layer setCornerRadius:2];
    [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)buttonPressed:(id)sender
{
    if ([self.formDelegate respondsToSelector:@selector(buttonPressedFromFormView:withTitleValue:)]) {
        [self.formDelegate buttonPressedFromFormView:self withTitleValue:self.button.titleLabel.text];
    }
    
    if (self.updateBlock) {
        self.updateBlock(nil);
    }
}

#pragma mark - Appearance

- (void)setFormViewButtonTitleColor:(UIColor *)formViewButtonTitleColor
{
    self.button.tintColor = formViewButtonTitleColor;
}

- (void)setFormViewButtonTitleFont:(UIFont *)formViewButtonTitleFont
{
    self.button.titleLabel.font = formViewButtonTitleFont;
}

- (void)setFormViewButtonBackgroundColor:(UIColor *)formViewButtonBackgroundColor
{
    self.button.backgroundColor = formViewButtonBackgroundColor;
}


@end
