//
//  JMListFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMTextfieldWithTitleFormView.h"

typedef NS_ENUM(NSUInteger, JMListFormViewStyle) {
    JMListFormViewAppleInlinePush,
    JMListFormViewModalChoice
};

@interface JMListFormViewDescription : JMTextfieldWithTitleFormViewDescription
@property (strong, nonatomic) NSArray *choices;
@property (assign, nonatomic) JMListFormViewStyle listStyle;
@end

@interface JMListFormView : JMTextfieldWithTitleFormView
@property (assign, nonatomic) JMListFormViewStyle listStyle;
@end
