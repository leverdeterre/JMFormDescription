//
//  JMListFormView.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMListFormView.h"

@implementation JMListFormViewDescription
- (id)init
{
    self = [super init];
    if (self) {
        self.formViewClass = [JMListFormView class];
        self.formViewHeight = 80.0f;
    }
    return self;
}
@end

@interface JMTextfieldWithTitleFormView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@end

@implementation JMListFormView

- (void)updateFormViewWithDescription:(JMListFormViewDescription *)description
{
    [super updateFormViewWithDescription:description];
    self.titleLabel.text = description.title;
    self.formDelegate = description.formDelegate;

    UIButton *overviewedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [overviewedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [overviewedButton setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [overviewedButton setFrame:self.bounds];
    [self addSubview:overviewedButton];
    self.textfield.delegate = nil;
    self.textfield.userInteractionEnabled = NO;
    
    self.textfield.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_arrow_down_list"]];
    CGRect rightImageViewFrame = rightImageView.frame;
    rightImageViewFrame.size = CGSizeMake(25.0f,25.0f);
    rightImageView.frame = rightImageViewFrame;
    rightImageView.contentMode = UIViewContentModeCenter;
    self.textfield.rightView = rightImageView;
}

- (void)buttonPressed:(id)sender
{
    if ([self.formDelegate respondsToSelector:@selector(listPressedFromFormView:withSelectedValue:)]){
        [self.formDelegate listPressedFromFormView:self withSelectedValue:self.textfield.text];
    }
}

@end
