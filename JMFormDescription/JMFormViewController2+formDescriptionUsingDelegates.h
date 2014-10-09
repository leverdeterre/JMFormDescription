//
//  JMFormViewController2+formDescriptionUsingDelegates.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController2.h"
#import "JMFormDescription.h"
#import "JMFormModel.h"

@interface JMFormViewController2 (formDescriptionUsingDelegates)

- (JMFormDescription *)generateFormDescriptionUsingModel:(JMFormModel *)model;

@end
