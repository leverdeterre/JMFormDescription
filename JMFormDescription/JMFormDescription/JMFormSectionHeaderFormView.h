//
//  JMFormSectionHeaderFormView.h
//  hotel
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 Backelite. All rights reserved.
//

#import "JMFormView.h"

@interface JMFormSectionHeaderFormViewDescription : JMFormViewDescription
@property (copy, nonatomic) NSString *title;
@end

@interface JMFormSectionHeaderFormView : JMFormView

@property (strong, nonatomic) UIFont *formViewHeaderLabelFont UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *formViewHeaderLabelColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *formViewHeaderBackgroundColor UI_APPEARANCE_SELECTOR;

@end
