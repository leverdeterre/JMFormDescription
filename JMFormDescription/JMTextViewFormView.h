//
//  JMTextViewFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormView.h"

@interface JMTextViewFormViewDescription : JMFormViewDescription
@property (copy, nonatomic) NSString *placeholder;
@property (copy, nonatomic) NSString *text;
@end

@interface JMTextViewFormView : JMFormView

@end
