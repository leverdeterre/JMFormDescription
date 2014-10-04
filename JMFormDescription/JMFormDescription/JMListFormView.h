//
//  JMListFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMTextfieldWithTitleFormView.h"

@interface JMListFormViewDescription : JMTextfieldWithTitleFormViewDescription
@property (strong, nonatomic) NSArray *choices;
@end

@interface JMListFormView : JMTextfieldWithTitleFormView
@end
