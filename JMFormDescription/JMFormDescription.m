//
//  JMFormDescription.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormDescription.h"
#import "JMFormView.h"

@implementation JMFormDescription

- (NSString *)modelKeyForDescriptionAtIndex:(NSInteger)index
{
    JMFormViewDescription *desc = [self.formViewDescriptions objectAtIndex:index];
    return desc.modelKey;
}

@end
