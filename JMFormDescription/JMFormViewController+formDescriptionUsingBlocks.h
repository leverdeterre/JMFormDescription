//
//  JMFormViewController+formDescriptionUsingBlocks.h
//  JMFormDescription
//
//  Created by jerome morissard on 09/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController.h"
#import "JMFormDescription.h"
#import "JMFormModel.h"

@interface JMFormViewController (formDescriptionUsingBlocks)

- (JMFormDescription *)generateFormDescriptionBlocksUsingModel:(JMFormModel *)model;

@end
