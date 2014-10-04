//
//  JMFormViewController+formDescription.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController.h"
#import "JMFormDescription.h"
#import "JMFormModel.h"

@interface JMFormViewController (formDescription)

- (JMFormDescription *)generateFormDescriptionUsingModel:(JMFormModel *)model;

@end
