//
//  JMSwitchFormView.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMSwitchFormView.h"

@implementation JMTSwitchFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.enable = YES;
        self.on = YES;
        self.formViewClass = [JMSwitchFormView class];
        self.formViewHeight = 50.0f;
    }
    return self;
}
@end

@interface JMSwitchFormView ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switche;
@property (weak, nonatomic) id <JMFormDelegate>formDelegate;
@end

@implementation JMSwitchFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.formViewCanBecomeResponder = NO;
    }
    return self;
}

- (void)updateFormViewWithDescription:(JMTSwitchFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    self.switche.enabled = description.enable;
    self.switche.on = description.on;
    self.textLabel.text = description.data;
    self.formDelegate = description.formDelegate;
    [self.switche addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)switchChanged:(id)sender
{
    if ([self.formDelegate respondsToSelector:@selector(switchChangedFromFormView:toValue:)]) {
        [self.formDelegate switchChangedFromFormView:self toValue:self.switche.on];
    }
    
    if (self.updateBlock) {
        self.updateBlock(@(self.switche.on));
    }
}

#pragma mark - Appearance

- (void)setFormViewTitleFont:(UIFont *)formViewTitleFont
{
    self.textLabel.font = formViewTitleFont;
}

- (void)setFormViewSwitchTintColor:(UIColor *)formViewSwitchTintColor
{
    self.switche.tintColor = formViewSwitchTintColor;
    self.switche.onTintColor = formViewSwitchTintColor;
}

@end
