//
//  JMDemoParameters.h
//  JMFormDescription
//
//  Created by jerome morissard on 11/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMDemoParameters : NSObject
@property (strong, nonatomic) NSArray *availableColors;
@property (strong, nonatomic) NSString *formViewBackgroundColor;

@property (strong, nonatomic) NSArray *availableformViewSpaces;
@property (assign, nonatomic) CGFloat formViewSpace;
@end
