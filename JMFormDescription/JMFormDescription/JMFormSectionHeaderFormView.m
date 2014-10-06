//
//  JMFormSectionHeaderFormView.m
//  hotel
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 Backelite. All rights reserved.
//

#import "JMFormSectionHeaderFormView.h"

@implementation JMFormSectionHeaderFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.formViewClass = [JMFormSectionHeaderFormView class];
        self.formViewHeight = 40.0f;
    }
    return self;
}
@end


@interface JMFormSectionHeaderFormView ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation JMFormSectionHeaderFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.formViewCanBecomeResponder = NO;
    }
    return self;
}

- (void)updateFormViewWithDescription:(JMFormSectionHeaderFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    self.textLabel.text = description.title;
}

#pragma mark - Appearance

- (void)setFormViewHeaderLabelColor:(UIColor *)formViewHeaderLabelColor
{
    self.textLabel.textColor = formViewHeaderLabelColor;
}

- (void)setFormViewHeaderLabelFont:(UIFont *)formViewHeaderLabelFont
{
    self.textLabel.font = formViewHeaderLabelFont;
}

- (void)setFormViewHeaderBackgroundColor:(UIColor *)formViewHeaderBackgroundColor
{
    self.backgroundColor = formViewHeaderBackgroundColor;
}

@end
