//
//  JMFormDescription.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMFormView;
@class JMFormScrollView;

@interface JMFormDescription : NSObject

@property (strong, nonatomic) NSArray *formViewDescriptions;

- (NSString *)modelKeyForDescriptionAtIndex:(NSInteger)index;

@end
