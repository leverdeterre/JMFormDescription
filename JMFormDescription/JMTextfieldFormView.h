//
//  JMTextfieldFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormView.h"

@interface JMTextfieldFormViewDescription : JMFormViewDescription
@property (copy, nonatomic) NSString *placeholder;
@property (assign, nonatomic) CGSize textfieldSize;
@end

@interface JMTextfieldFormViewDescription (JMTextfieldFormBlocked)
@property (assign, nonatomic) SEL blockingButtonSelector;
@end

@interface JMTextfieldFormView : JMFormView
@end
