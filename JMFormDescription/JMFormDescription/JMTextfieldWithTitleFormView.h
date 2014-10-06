//
//  JMTextfieldWithTitleFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMTextfieldFormView.h"

@interface JMTextfieldWithTitleFormViewDescription : JMTextfieldFormViewDescription
@property (copy, nonatomic) NSString *title;
@end

@interface JMTextfieldWithTitleFormView : JMTextfieldFormView

@property (strong, nonatomic) UIFont *formViewTitleFont UI_APPEARANCE_SELECTOR;

@end
