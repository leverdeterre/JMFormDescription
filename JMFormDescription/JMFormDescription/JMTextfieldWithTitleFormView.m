//
//  JMTextfieldWithTitleFormView.m
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMTextfieldWithTitleFormView.h"

@implementation JMTextfieldWithTitleFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.formViewClass = [JMTextfieldWithTitleFormView class];
        self.formViewHeight = 80.0f;
    }
    return self;
}
@end

@interface JMTextfieldWithTitleFormView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation JMTextfieldWithTitleFormView

- (void)updateFormViewWithDescription:(JMTextfieldWithTitleFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    self.titleLabel.text = description.title;
    self.formDelegate = description.formDelegate;
}

#pragma mark - Appearance

- (void)setFormViewTitleFont:(UIFont *)formViewTitleFont
{
    self.titleLabel.font = formViewTitleFont;
}

@end
